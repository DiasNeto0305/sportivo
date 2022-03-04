import 'package:flutter/material.dart';

class DarkTheme {
  static final data = ThemeData(
    scaffoldBackgroundColor: Colors.grey.shade900,
    primarySwatch: Colors.indigo,
    colorScheme: ColorScheme.dark(),
    iconTheme: IconThemeData(
      color: Colors.white54,
      size: 20
    ),
  );
}