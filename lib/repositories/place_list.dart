import 'dart:convert';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart' as http;
import 'package:sportivo/models/place.dart';

class PlaceList {
  final _baseUrl = 'https://sportivo-c9005-default-rtdb.firebaseio.com';

  Future<List<Place>> loadPlaces() async {
    List<Place> items = [];
    final response = await http.get(
      Uri.parse('$_baseUrl/places.json'),
    );
    Map<String, dynamic> data = jsonDecode(response.body);
    data.forEach((placeId, placeData) {
      items.add(
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
    return items;
  }

  Future<void> updatePlace(Place place, String flagListType) async {
    if (flagListType == 'File') {
      var urlImage = await _uploadImages(place.urlImage, place.name);
      await http.patch(
        Uri.parse('$_baseUrl/places/${place.id}.json'),
        body: jsonEncode(
          {
            "name": place.name,
            "description": place.description,
            "address": place.address,
            "categoryId": place.categoryId,
            "urlImage": urlImage,
            "suggestion": place.suggestion
          },
        ),
      );
    } else {
      await http.patch(
        Uri.parse('$_baseUrl/places/${place.id}.json'),
        body: jsonEncode(
          {
            "name": place.name,
            "description": place.description,
            "address": place.address,
            "categoryId": place.categoryId,
            "urlImage": place.urlImage,
            "suggestion": place.suggestion
          },
        ),
      );
    }
  }

  Future<void> removePlace(String id) async {
    await http.delete(Uri.parse('$_baseUrl/places/$id.json'));
  }

  Future<List<String>> _uploadImages(List imageList, String placeName) async {
    final storage = FirebaseStorage.instance;
    List<String> urlList = [];
    int index = 0;
    urlList = await Future.wait(imageList.map((file) async {
      var value;
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

    return urlList;
  }

  Future<void> addPlace(Place place) async {
    var urlImage = await _uploadImages(place.urlImage, place.name);
    var response = await http.post(
      Uri.parse('$_baseUrl/places.json'),
      body: jsonEncode(
        {
          "name": place.name,
          "description": place.description,
          "address": place.address,
          "categoryId": place.categoryId,
          "urlImage": urlImage,
          "isFavorite": place.isFavorite,
          "suggestion": place.suggestion
        },
      ),
    );
    print(response);
  }

  Future<void> toggleFavorite(Place place) async {
    final response = await http.patch(
      Uri.parse('$_baseUrl/places/${place.id}.json'),
      body: jsonEncode({'isFavorite': place.isFavorite}),
    );

    if (response.statusCode >= 400) {
      place.isFavorite = !place.isFavorite;
    }
  }
}
