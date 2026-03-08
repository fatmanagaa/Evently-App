import 'package:evently_app/core/utils/app_style.dart';
import 'package:evently_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/utils/app_assets.dart';
import '../../../providers/app_language_provider.dart';
import '../../../providers/app_theme_provider.dart';

class ForgetPassScreen extends StatelessWidget {
  const ForgetPassScreen({super.key});

  @override
  Widget build(BuildContext context) {
    late var appLanguageProvider = Provider.of<AppLanguageProvider>(context);
    late var appThemeProvider = Provider.of<AppThemeProvider>(context);
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Forget Password',
          style: appThemeProvider.isDarkMode()
              ? AppStyles.regular18White
              : AppStyles.regular18Black,
        ),
      ),

      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.04,
          vertical: height * 0.02,
        ),

        child: Column(
          children: [
            SizedBox(width: 20,),
            Center(
              child: Image.asset(
                AppAssets.getForgetPassImage(context),
                width: 343,
                height: 343,
              ),
            ),
            SizedBox(height: 20,),
            ElevatedButton(
              onPressed: () {},
              child: Text(
                AppLocalizations.of(context)!.resetPassword,
                style: AppStyles.semi20White,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
