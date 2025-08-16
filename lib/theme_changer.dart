import 'package:flutter/material.dart';
class themeChanger extends ChangeNotifier{
  ThemeMode mode = ThemeMode.system;
  void changeTheme ( ThemeMode value)
  {
    mode = value;
    notifyListeners();
  }
}