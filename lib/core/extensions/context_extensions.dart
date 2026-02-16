import 'package:evently_app/providers/app_language_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/app_theme_provider.dart';

extension ContextExtensions on BuildContext {
  double get width => MediaQuery.of(this).size.width;

  double get height => MediaQuery.of(this).size.height;

  AppThemeProvider get theme =>
      Provider.of<AppThemeProvider>(this, listen: false);

  AppLanguageProvider get language =>
      Provider.of<AppLanguageProvider>(this, listen: false);

  //todo:way to use this extension
  // final width = context.width;
  // final height = context.height;
  // final theme = context.theme;
  // final language = context.language;
  //context.language.appLanguage //todo:to access thing inside it

  bool get isDark => Theme.of(this).brightness == Brightness.dark;

  // if(context.isDark) ...

  Future<T?> pushNamed<T>(String routeName, {Object? arguments}) {
    return Navigator.of(this).pushNamed<T>(routeName, arguments: arguments);
  }

  // context.pushNamed('/details', arguments: 42);

  Future<T?> pushReplacementNamed<T, TO>(
    String routeName, {
    Object? arguments,
  }) {
    return Navigator.of(
      this,
    ).pushReplacementNamed<T, TO>(routeName, arguments: arguments);
    // context.pushReplacementNamed('/home');
  }
}
