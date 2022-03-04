import 'package:flutter/material.dart';
import 'package:sportivo/components/search/data_search.dart';

class SearchButton extends StatelessWidget {
  final String label;
  const SearchButton({Key? key, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Container(
      width: deviceSize.width * 0.90,
      child: OutlinedButton.icon(
        onPressed: () {
          showSearch(context: context, delegate: DataSearch());
        },
        icon: Icon(Icons.search, size: 18),
        style: ButtonStyle(
          shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
        ),
        label: Text(label),
      ),
    );
  }
}
