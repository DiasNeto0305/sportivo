import 'package:sportivo/data/dummy_data.dart' as dummyData;

class Place {
  String id;
  String name;
  String description;
  String address;
  List urlImage;
  int categoryId;
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

  Map categoryItem() {
    return dummyData.categories[this.categoryId];
  }
}
