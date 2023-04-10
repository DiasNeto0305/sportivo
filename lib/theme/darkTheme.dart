import 'package:flutter/material.dart';
import 'package:sportivo/theme/colors.dart';

class DarkTheme {
  static final data = ThemeData(
    scaffoldBackgroundColor: SportivoColors.darkBackground,
    primarySwatch: Colors.blue,
    colorScheme: ColorScheme.dark(),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: EdgeInsets.all(16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
    iconTheme: IconThemeData(color: Colors.white54, size: 20),
  );
}
