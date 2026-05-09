import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AppThemeProvider extends ChangeNotifier {
  ThemeMode appTheme = ThemeMode.light;

  void changeTheme(ThemeMode newMode) {
    // if the requested theme is the same as current, do nothing
    if (newMode == appTheme) return;
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




