import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sportivo/controllers/place_controller.dart';
import 'package:sportivo/pages/places_page.dart';

class DataSearch extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: Icon(Icons.clear))
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, '');
      },
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final provider = Provider.of<PlaceController>(context);
    var placesData = provider.places.where((element) {
      var placesTitle = element.name as String;
      return placesTitle.toLowerCase().startsWith(query.toLowerCase());
    });
    return PlacesPage(placesData: placesData.toList(), appBar: false,);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final provider = Provider.of<PlaceController>(context);
    var placesData = provider.places.where((element) {
      var placesTitle = element.name as String;
      return placesTitle.toLowerCase().startsWith(query.toLowerCase());
    });
    final suggestionList =
        query.length < 3 ? provider.favorites : placesData.toList();
    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        onTap: () {
          query = suggestionList[index].name as String;
          showResults(context);
        },
        leading: Icon(
          Icons.place,
          color: provider.categoryItem(suggestionList[index])['color'],
        ),
        title: RichText(
          text: TextSpan(
              text: (suggestionList[index].name as String)
                  .substring(0, query.length),
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              children: [
                TextSpan(
                    text: (suggestionList[index].name as String)
                        .substring(query.length),
                    style: TextStyle(color: Colors.black54))
              ]),
        ),
      ),
      itemCount: suggestionList.length,
    );
  }
}
