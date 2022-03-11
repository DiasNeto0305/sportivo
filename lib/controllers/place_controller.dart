import 'package:flutter/cupertino.dart';
import 'package:sportivo/data/dummy_data.dart' as dummyData;
import 'package:sportivo/models/place.dart';
import 'package:sportivo/repositories/place_list.dart';

class PlaceController with ChangeNotifier {
  PlaceList placeList = PlaceList();
  String _token;
  String _userId;
  List<Place> _items = [];

  PlaceController(this._token, this._userId, this._items);

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

  List<Place> get places {
    return _items;
  }

  int get placesItemsCount {
    return _items.length;
  }

  List filterByCategory(int categoryId) {
    return _items.where((place) => place.categoryId == categoryId).toList();
  }

  Map categoryItem(Place place) {
    return place.categoryItem();
  }

  Future<void> savePlace(Map<String, Object> data, String flagListType) async {
    bool hasId = data['id'] != null;

    final place = Place(
      id: hasId ? data['id'] as String : '',
      name: data['name'] as String,
      description: data['description'] as String,
      address: data['address'] as String,
      categoryId: data['categoryId'] as int,
      urlImage: data['urlImage'] as List,
    );
    if (hasId) {
      await placeList.updatePlace(place, flagListType, _token);
      loadPlaces();
    } else {
      await placeList.addPlace(place, _token);
      loadPlaces();
    }
  }

  Future<void> removePlace(Place place) async {
    await placeList.removePlace(place.id, _token);
    loadPlaces();
  }

  Future<void> loadPlaces() async {
    _items = await placeList.loadPlaces(_token, _userId);
    notifyListeners();
  }

  Future<void> toggleFavorite(Place place) async {
    place.isFavorite = !place.isFavorite;
    await placeList.toggleFavorite(place, _token, _userId);
    loadPlaces();
  }
}
