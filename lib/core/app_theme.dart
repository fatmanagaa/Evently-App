import 'package:evently_app/core/app_colors.dart';
import 'package:evently_app/core/app_style.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.background,
    textTheme: TextTheme(
      headlineLarge: AppStyles.semi20Black,
      headlineMedium: AppStyles.regular14Grey,
      headlineSmall: AppStyles.medium16Black,
    ),
  );
  static final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.bgDarkMode,
    textTheme: TextTheme(
      headlineLarge: AppStyles.semi20White,
      headlineMedium: AppStyles.regular14White,
      headlineSmall: AppStyles.medium16White,
    ),
  );
}
