import 'package:flutter/material.dart';
import 'package:sportivo/data/dummy_data.dart' as dummyData;
import 'package:sportivo/theme/colors.dart';

class DropdownLocation extends StatefulWidget {
  const DropdownLocation({Key? key}) : super(key: key);

  @override
  State<DropdownLocation> createState() => _DropdownLocationState();
}

class _DropdownLocationState extends State<DropdownLocation> {
  String dropdownValue = 'Rua Terezinha de Medeiros Dantas Souza';

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: Icon(
        Icons.arrow_drop_down,
        color: SportivoColors.primary,
      ),
      elevation: 16,
      style: TextStyle(
        fontWeight: FontWeight.bold,
      ),
      onChanged: (String? newValue) {
        setState(() {
          dropdownValue = newValue!;
        });
      },
      items: dummyData.locationPlaces
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
