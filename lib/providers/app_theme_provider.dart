import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AppThemeProvider extends ChangeNotifier {
  ThemeMode appTheme=ThemeMode.light;
  void changeTheme(ThemeMode newMode) {
    if (newMode == ThemeMode.light) {
      return;
    }
    appTheme = newMode;
    notifyListeners();
  }
    bool  isDarkMode() {
     return appTheme==ThemeMode.dark;
    }
    bool isLightMode() {
      return appTheme==ThemeMode.light;
    }
  }




