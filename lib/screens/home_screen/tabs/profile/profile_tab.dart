import 'package:evently_app/core/app_assets.dart';
import 'package:evently_app/core/app_colors.dart';
import 'package:evently_app/l10n/app_localizations.dart';
import 'package:evently_app/screens/home_screen/tabs/profile/theme/theme_bottom_sheet.dart';
import 'package:evently_app/screens/home_screen/tabs/profile/widgets/settings_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/app_style.dart';
import '../../../../providers/app_theme_provider.dart';
import 'language/language_bottom_sheet.dart';

class ProfileTab extends StatefulWidget {
  ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  bool isDark = false;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<AppThemeProvider>(context);
    bool isDark = themeProvider.isDarkMode();
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.04,
          vertical: height * 0.04,
        ),
        child: Column(
          spacing: height * 0.02,

          children: [
            SizedBox(height: height * 0.04),
            Image.asset(AppAssets.profilePic),
            Center(
              child: Text(
                'John Safwat',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ),
            Text(
              'johnsafwat.route@gmail.com',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            SettingsItem(
              text: AppLocalizations.of(context)!.darkMode,
              item: Switch(
                activeThumbColor: AppColors.strokeDarkColor,
                inactiveThumbColor: AppColors.greyColor,
                value: isDark,
                onChanged: (newValue) {
                  isDark = newValue;
                  themeProvider.changeTheme(
                    isDark ? ThemeMode.dark : ThemeMode.light,
                  );
                  setState(() {});
                },
              ),
            ),
            SettingsItem(
              text: AppLocalizations.of(context)!.language,
              item: IconButton(
                onPressed: () {
                  showLanguageModalBottomSheet(context);
                },

                icon: Icon(
                  Icons.arrow_forward_ios_outlined,
                  size: 30,
                  color: isDark ? AppColors.strokeDarkColor : AppColors.main,
                ),
              ),
            ),
            SettingsItem(
              text: AppLocalizations.of(context)!.logout,
              item: IconButton(
                onPressed: () {},
                icon: Icon(Icons.logout, size: 30, color: AppColors.red),
              ),
            ),
          ],
        ),
      ),
    );
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
