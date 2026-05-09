import 'package:evently_app/core/utils/app_assets.dart';
import 'package:evently_app/core/utils/app_colors.dart';
import 'package:evently_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/app_language_provider.dart';
import '../../../providers/app_theme_provider.dart';
import '../../home_screen/tabs/profile/language/language_bottom_sheet.dart';
import '../../home_screen/tabs/profile/theme/theme_bottom_sheet.dart';

class OnBoardingP1 extends StatefulWidget {


  const OnBoardingP1({super.key,

  });

  @override
  State<OnBoardingP1> createState() => _OnBoardingP1State();
}

class _OnBoardingP1State extends State<OnBoardingP1> {
  // removed local state for language/theme selection; we'll read providers directly
  @override
  Widget build(BuildContext context) {
    // read providers so UI updates when they change
    var appLanguageProvider = Provider.of<AppLanguageProvider>(context);
    var appThemeProvider = Provider.of<AppThemeProvider>(context);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          spacing: 10,
          children: [
            Image.asset(
              AppAssets.getOnBoardingImage_1(context),
              width: 343,
              height: 343,
            ),
            Text(
              AppLocalizations.of(context)!.personalizeExperience,
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            Text(
              AppLocalizations.of(context)!.chooseThemeAndLanguage,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Row(
              children: [
                Text(
                  AppLocalizations.of(context)!.language,
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                const Spacer(),

                languageItem(context, AppLocalizations.of(context)!.english, "en"),
                const SizedBox(width: 10),
                languageItem(context, AppLocalizations.of(context)!.arabic, "ar"),
              ],
            ),
            Row(
              children: [
                Text(
                  AppLocalizations.of(context)!.theme,
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                const Spacer(),
                themeItem(Icons.wb_sunny, false),
                const SizedBox(width: 10),
                themeItem(Icons.nightlight, true),
              ],
            )




          ],
        ),
      ),
    );
  }
  Widget languageItem(BuildContext context, String title, String code) {
    final appLanguageProvider = Provider.of<AppLanguageProvider>(context);
    final appThemeProvider = Provider.of<AppThemeProvider>(context);

    bool isSelected = appLanguageProvider.appLanguage == code;
    bool isDarkLocal = appThemeProvider.isDarkMode();

    return GestureDetector(
      onTap: () {
        // change language immediately without showing any modal
        appLanguageProvider.changeLanguage(code);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: BoxDecoration(
          color: isDarkLocal
              ? (isSelected ? AppColors.mainDarkMode : AppColors.mainDarkColor_2)
              : (isSelected ? AppColors.main : Colors.white),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isDarkLocal
                ? (isSelected ? Colors.white : AppColors.main)
                : (isSelected ? Colors.white : AppColors.main),
          ),
        ),
      ),
    );
  }
  Widget themeItem(IconData icon, bool dark) {
    // Use a Builder so we can read providers with the correct context when this
    // widget is built inside the parent build method.
    return Builder(builder: (context) {
      final appThemeProvider = Provider.of<AppThemeProvider>(context);
      bool isSelected = appThemeProvider.isDarkMode() == dark;
      bool isDarkLocal = appThemeProvider.isDarkMode();

      return GestureDetector(
        onTap: () {
          // apply theme immediately across the app
          final newMode = dark ? ThemeMode.dark : ThemeMode.light;
          appThemeProvider.changeTheme(newMode);
        },
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: isDarkLocal
                ? (isSelected ? AppColors.mainDarkMode : AppColors.mainDarkColor_2)
                : (isSelected ? AppColors.main : Colors.white),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            icon,
            color: isDarkLocal
                ? (isSelected ? Colors.white : AppColors.main)
                : (isSelected ? Colors.white : AppColors.main),
          ),
        ),
      );
    });
  }
  void showLanguageModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => LanguageBottomSheet(),
    );
  }

  void showThemeModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => ThemeBottomSheet(),
    );
  }
}




