import 'package:evently_app/l10n/app_localizations.dart';
import 'package:evently_app/screens/home_screen/tabs/profile/profile_tab.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.language),

      ),
       body: ProfileTab(),

    );
  }
}
