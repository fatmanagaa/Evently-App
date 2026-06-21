import 'package:evently_app/core/app_assets.dart';
import 'package:evently_app/core/app_colors.dart';
import 'package:evently_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/app_language_provider.dart';
import '../../../providers/app_theme_provider.dart';

class OnBoardingP1 extends StatefulWidget {
  const OnBoardingP1({super.key});

  @override
  State<OnBoardingP1> createState() => _OnBoardingP1State();
}

class _OnBoardingP1State extends State<OnBoardingP1> {
  @override
  Widget build(BuildContext context) {
    final appLanguageProvider = Provider.of<AppLanguageProvider>(context);
    final appThemeProvider = Provider.of<AppThemeProvider>(context);

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
                languageItem(context, appLanguageProvider, appThemeProvider,
                    AppLocalizations.of(context)!.english, "en"),
                const SizedBox(width: 10),
                languageItem(context, appLanguageProvider, appThemeProvider,
                    AppLocalizations.of(context)!.arabic, "ar"),
              ],
            ),
            Row(
              children: [
                Text(
                  AppLocalizations.of(context)!.theme,
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                const Spacer(),
                themeItem(context, appThemeProvider, Icons.wb_sunny, false),
                const SizedBox(width: 10),
                themeItem(context, appThemeProvider, Icons.nightlight, true),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Language selection item
  Widget languageItem(
    BuildContext context,
    AppLanguageProvider languageProvider,
    AppThemeProvider themeProvider,
    String title,
    String code,
  ) {
    final isSelected = languageProvider.appLanguage == code;
    final isDarkMode = themeProvider.isDarkMode();

    return GestureDetector(
      onTap: () {
        languageProvider.changeLanguage(code);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: BoxDecoration(
          color: isDarkMode
              ? (isSelected ? AppColors.mainDarkMode : AppColors.mainDarkColor_2)
              : (isSelected ? AppColors.main : Colors.white),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isSelected ? Colors.white : AppColors.main,
          ),
        ),
      ),
    );
  }

  /// Theme selection item
  Widget themeItem(
    BuildContext context,
    AppThemeProvider themeProvider,
    IconData icon,
    bool isDark,
  ) {
    final isSelected = themeProvider.isDarkMode() == isDark;
    final currentDarkMode = themeProvider.isDarkMode();

    return GestureDetector(
      onTap: () {
        final newMode = isDark ? ThemeMode.dark : ThemeMode.light;
        themeProvider.changeTheme(newMode);
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: currentDarkMode
              ? (isSelected ? AppColors.mainDarkMode : AppColors.mainDarkColor_2)
              : (isSelected ? AppColors.main : Colors.white),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(
          icon,
          color: isSelected ? Colors.white : AppColors.main,
        ),
      ),
    );
  }
}
