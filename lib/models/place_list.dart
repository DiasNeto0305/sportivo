import 'dart:convert';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:sportivo/data/dummy_data.dart' as dummyData;
import 'package:sportivo/models/place.dart';

class PlaceList with ChangeNotifier {
  final _baseUrl = 'https://sportivo-c9005-default-rtdb.firebaseio.com';

  List<Place> _items = [];

  List get favorites {
    return _items.where((place) => place.isFavorite == true).toList();
  }

  List get suggestions {
    return _items.where((place) => place.suggestion == true).toList();
  }

  List get categories {
    return dummyData.categories;
  }

  int get categoriesItemsCount {
    return dummyData.categories.length;
  }

  List get places {
    return _items;
  }

  int get placesItemsCount {
    return _items.length;
  }

  List filterByCategory(int categoryId) {
    return _items.where((place) => place.categoryId == categoryId).toList();
  }

  Map categoryItem(index) {
    var categoryId;
    final placeCategory = _items.where((place) => place.id == index);
    placeCategory.forEach((place) {
      categoryId = place.categoryId;
    });
    return dummyData.categories[categoryId];
  }

  Future<void> loadPlaces() async {
    _items = [];
    final response = await http.get(
      Uri.parse('$_baseUrl/places.json'),
    );
    Map<String, dynamic> data = jsonDecode(response.body);
    data.forEach((placeId, placeData) {
      _items.add(
        Place(
          id: placeId,
          name: placeData['name'],
          description: placeData['description'],
          address: placeData['address'],
          categoryId: placeData['categoryId'],
          urlImage: placeData['urlImage'],
          suggestion: placeData['suggestion'],
          isFavorite: placeData['isFavorite'],
        ),
      );
    });
    notifyListeners();
  }

  void savePlace(Map<String, Object> data) {
    bool hasId = data['id'] != null;

    final place = Place(
      id: hasId ? data['id'] as String : '',
      name: data['name'] as String,
      description: data['description'] as String,
      address: data['address'] as String,
      categoryId: data['categoryId'] as int,
      urlImage: data['urlImage'] as List,
    );
    if (hasId)
      updatePlace(place);
    else
      addPlace(place);
  }

  void updatePlace(Place place) async {
    if (place.urlImage is List<String>) {
      http
          .patch(Uri.parse('$_baseUrl/places/${place.id}.json'),
              body: jsonEncode({
                "name": place.name,
                "description": place.description,
                "address": place.address,
                "categoryId": place.categoryId,
                "id": place.id,
                "urlImage": place.urlImage,
                "suggestion": place.suggestion
              }))
          .then((value) {
        loadPlaces();
      });
    } else {
      _uploadImages(place.urlImage, place.name).then((value) {
        http
            .patch(Uri.parse('$_baseUrl/places/${place.id}.json'),
                body: jsonEncode({
                  "name": place.name,
                  "description": place.description,
                  "address": place.address,
                  "categoryId": place.categoryId,
                  "urlImage": value,
                  "id": place.id,
                  "suggestion": place.suggestion
                }))
            .then((value) {
          loadPlaces();
        });
      });
    }
  }

  void removePlace(Place place) {
    int index = _items.indexWhere((p) => p.id == place.id);

    if (index >= 0) {
      _items.removeWhere((p) => p.id == place.id);
      notifyListeners();
    }
  }

  Future<List<String>> _uploadImages(List imageList, String placeName) async {
    final storage = FirebaseStorage.instance;
    List<String> urlList = [];
    int index = 0;
    urlList = await Future.wait(imageList.map((file) async {
      var value;
      print(index);
      final imageRef = storage
          .ref()
          .child('images')
          .child(placeName)
          .child(index.toString());
      index++;
      await imageRef.putFile(file);
      var url = await imageRef.getDownloadURL();
      value = url;
      return value;
    }));
    print('segundo return');
    print(urlList);
    return urlList;
  }

  void addPlace(Place place) {
    _uploadImages(place.urlImage, place.name).then((value) {
      http
          .post(Uri.parse('$_baseUrl/places.json'),
              body: jsonEncode({
                "name": place.name,
                "description": place.description,
                "address": place.address,
                "categoryId": place.categoryId,
                "urlImage": value,
                "isFavorite": place.isFavorite,
                "suggestion": place.suggestion
              }))
          .then((value) {
        loadPlaces();
      });
    });
  }

  toggleFavorite(place) {
    place.isFavorite = !(place.isFavorite);
    notifyListeners();
  }
}
