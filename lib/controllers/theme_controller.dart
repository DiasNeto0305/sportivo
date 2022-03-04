import 'package:flutter/cupertino.dart';

class ThemeController with ChangeNotifier {
  int _selectedTheme = 2;

  get selectedTheme {
    return _selectedTheme;
  }

  void changeTheme(int value) {
    _selectedTheme = value;
    notifyListeners();
  }
}