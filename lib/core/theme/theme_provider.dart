import 'package:flutter/material.dart';
import 'package:task_project/core/theme/light_mode.dart';
import 'dark_mode.dart';

class ThemeProvider extends ChangeNotifier {
  //intially, light mode.
  ThemeData _themeData = lightMode;

  //get current theme.
  ThemeData get themedata => _themeData;

  //is current mode dark?
  bool get isDarkMode => _themeData == darkMode;

  //set th theme.
  set themeData (ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  //toggle the theme.
  void toggleTheme() {
    if(_themeData == lightMode) {
      _themeData = darkMode;
    }
    else {
      _themeData = lightMode;
    }
  }
}