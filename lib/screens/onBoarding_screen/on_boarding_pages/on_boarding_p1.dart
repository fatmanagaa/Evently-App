import 'package:evently_app/core/app_assets.dart';
import 'package:evently_app/core/app_colors.dart';
import 'package:evently_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

import '../../home_screen/tabs/profile/language/language_bottom_sheet.dart';
import '../../home_screen/tabs/profile/theme/theme_bottom_sheet.dart';

class OnBoardingP1 extends StatefulWidget {


  const OnBoardingP1({super.key,

  });

  @override
  State<OnBoardingP1> createState() => _OnBoardingP1State();
}

class _OnBoardingP1State extends State<OnBoardingP1> {
  bool isDark = false;
  String selectedLang = "en";
  @override
  Widget build(BuildContext context) {
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

                languageItem(context,AppLocalizations.of(context)!.english, "en"),
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
    bool isSelected = selectedLang == code;
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: () {
        showLanguageDialog(context);

        selectedLang = code;



        setState(() {});
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: BoxDecoration(
          color: isDark
              ? (isSelected ? AppColors.mainDarkMode : AppColors.mainDarkColor_2)
              : (isSelected ? AppColors.main : Colors.white),
          borderRadius: BorderRadius.circular(10),

        ),
        child: Text(
          title,
          style: TextStyle(
            color: isDark
                ? (isSelected ? Colors.white : AppColors.main)
                : (isSelected ? Colors.white : AppColors.main),
          ),
        ),
      ),
    );
  }
  Widget themeItem(IconData icon, bool dark) {
    bool isSelected = isDark == dark;

    return GestureDetector(
      onTap: () {
        setState(() {
          showThemeDialog(context);
          isDark = dark;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isDark
              ? (isSelected ? AppColors.mainDarkMode : AppColors.mainDarkColor_2)
              : (isSelected ? AppColors.main : Colors.white),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(
          icon,
          color: isDark
              ? (isSelected ? Colors.white : AppColors.main)
              : (isSelected ? Colors.white : AppColors.main),
        ),
      ),
    );
  }

  void showLanguageDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => LanguageBottomSheet(),
    );
  }

  void showThemeDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => ThemeBottomSheet(),
    );
  }



}
