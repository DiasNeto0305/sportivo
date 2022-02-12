import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sportivo/utils/constants.dart';

class Place with ChangeNotifier {
  final String id;
  final String name;
  final String description;
  final String address;
  final List urlImage;
  final int categoryId;
  bool suggestion;
  bool isFavorite;

  Place({
    required this.id,
    required this.name,
    required this.description,
    required this.address,
    required this.urlImage,
    required this.categoryId,
    this.suggestion = true,
    this.isFavorite = false,
  });

  void _toggleFavorite() {
    isFavorite = !isFavorite;
    notifyListeners();
  }

  Future<void> toggleFavorite(String token, String userId) async {
    _toggleFavorite();
    final response = await http.put(
      Uri.parse('${Constants.USER_FAVORITE_URL}/$userId/$id.json?auth=$token'),
      body: jsonEncode(isFavorite),
    );

    if (response.statusCode >= 400) {
      _toggleFavorite();
    }
  }
}
