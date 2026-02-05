import 'package:evently_app/l10n/app_localizations.dart';
import 'package:evently_app/screens/home_screen/tabs/profile/theme/theme_bottom_sheet.dart';
import 'package:flutter/material.dart';

import 'language/language_bottom_sheet.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10 ,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(AppLocalizations.of(context)!.theme),
              IconButton(
                onPressed: () {
                  showThemeDialog(context);
                },
                icon: Icon(Icons.arrow_forward_ios_rounded),
              ),
            ],
          ),
        ),
      ],
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
