import 'package:flutter/material.dart';
import 'package:todo/theme.dart';

class Themeprovader with ChangeNotifier {
  ThemeData _themeData = lightMode;
  ThemeData get themeData => _themeData;

  get toggleTheme => null;

  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  void changeMode() {
    themeData = themeData == lightMode ? darkMode : lightMode;
  }
}
