import 'package:evently_app/core/app_colors.dart';
import 'package:evently_app/core/app_style.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.background,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(AppColors.main),
        fixedSize: MaterialStateProperty.all(const Size(340, 55)),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16), // Radius 16
          ),
        ),
        padding: MaterialStateProperty.all(const EdgeInsets.all(16)),
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.background,
      selectedItemColor: AppColors.main,
      unselectedItemColor: AppColors.greyColor,
      selectedLabelStyle: AppStyles.regular12Main,
      unselectedLabelStyle: AppStyles.regular12Grey

    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.bgDarkMode,
      foregroundColor: AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(30)
      ),
    ),
    textTheme: TextTheme(
      headlineLarge: AppStyles.semi20Black,
      headlineMedium: AppStyles.regular14Grey,
      headlineSmall: AppStyles.medium16Black,
      displaySmall: AppStyles.medium16Grey,
      displayMedium: AppStyles.medium18main



    ),
  );
  static final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.bgDarkMode,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(AppColors.mainDarkMode),
        fixedSize: MaterialStateProperty.all(const Size(340, 55)),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16), // Radius 16
          ),
        ),
        padding: MaterialStateProperty.all(const EdgeInsets.all(16)),
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.bgDarkMode,
        selectedItemColor: AppColors.main,
        unselectedItemColor: AppColors.greyColor,
        selectedLabelStyle: AppStyles.regular12mainDark,
        unselectedLabelStyle: AppStyles.regular12Grey

    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.main,
      foregroundColor: AppColors.white,
      shape: StadiumBorder(


      )
    ),
    textTheme: TextTheme(
      headlineLarge: AppStyles.semi20White,
      headlineMedium: AppStyles.regular14White,
      headlineSmall: AppStyles.medium16White,

      displayMedium: AppStyles.regular18White



    ),
    );

}
