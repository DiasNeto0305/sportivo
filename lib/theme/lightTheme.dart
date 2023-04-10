import 'package:flutter/material.dart';
import 'package:sportivo/theme/colors.dart';

class LightTheme {
  static final data = ThemeData(
    scaffoldBackgroundColor: SportivoColors.lightBackground,
    primarySwatch: Colors.lightBlue,
    colorScheme: ColorScheme.light(),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: EdgeInsets.all(16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
    iconTheme: IconThemeData(
      color: Colors.black54,
      size: 20,
    ),
  );
}
