import 'dart:convert';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart' as http;
import 'package:sportivo/models/place.dart';

class PlaceList {
  final _baseUrl = 'https://sportivo-backend-default-rtdb.firebaseio.com';

  Future<List<Place>> loadPlaces(String token, String userId) async {
    List<Place> items = [];
    final response = await http.get(
      Uri.parse('$_baseUrl/places.json?auth=$token'),
    );

    final favResponse = await http.get(
      Uri.parse('$_baseUrl/userFavorites/$userId.json?auth=$token'),
    );

    Map<String, dynamic> favData = favResponse.body == 'null' ? {} : jsonDecode(favResponse.body); 

    Map<String, dynamic> data = jsonDecode(response.body);
    data.forEach((placeId, placeData) {
      final isFavorite = favData[placeId] ?? false;
      items.add(
        Place(
          id: placeId,
          name: placeData['name'],
          description: placeData['description'],
          address: placeData['address'],
          categoryId: placeData['categoryId'],
          isFavorite: isFavorite,
          urlImage: placeData['urlImage'],
          suggestion: placeData['suggestion'],
        ),
      );
    });
    return items;
  }

  Future<void> updatePlace(
      Place place, String flagListType, String token) async {
    if (flagListType == 'File') {
      var urlImage = await _uploadImages(place.urlImage, place.name);
      await http.patch(
        Uri.parse('$_baseUrl/places/${place.id}.json?auth=$token'),
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
        Uri.parse('$_baseUrl/places/${place.id}.json?auth=$token'),
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

  Future<void> removePlace(String id, String token) async {
    await http.delete(Uri.parse('$_baseUrl/places/$id.json?auth=$token'));
  }

  Future<List<String>> _uploadImages(List imageList, String placeName) async {
    final storage =
        FirebaseStorage.instanceFor(bucket: 'sportivo-backend.appspot.com');
    List<String> urlList = [];
    int index = 0;
    print(storage);
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

  Future<void> addPlace(Place place, String token) async {
    var urlImage = await _uploadImages(place.urlImage, place.name);
    var response = await http.post(
      Uri.parse('$_baseUrl/places.json?auth=$token'),
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
    print(response);
  }

  Future<void> toggleFavorite(Place place, String token, String userId) async {
    final response = await http.put(
      Uri.parse('$_baseUrl/userFavorites/$userId/${place.id}.json?auth=$token'),
      body: jsonEncode(place.isFavorite),
    );

    if (response.statusCode >= 400) {
      place.isFavorite = !place.isFavorite;
    }
  }
}
