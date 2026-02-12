import 'package:evently_app/core/app_assets.dart';
import 'package:evently_app/core/app_colors.dart';
import 'package:evently_app/core/app_style.dart';
import 'package:evently_app/screens/home_screen/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/app_routes.dart';
import '../../../l10n/app_localizations.dart';
import '../../../providers/app_language_provider.dart';
import '../../../providers/app_theme_provider.dart';
import '../google_auth/google_auth.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});


  @override
  Widget build(BuildContext context) {
    late var appLanguageProvider = Provider.of<AppLanguageProvider>(context);
    late var appThemeProvider = Provider.of<AppThemeProvider>(context);
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.04,
            vertical: height * 0.02,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: height * 0.02,
            children: [
              Center(
                child: Image.asset(
                  AppAssets.getLogo(context),
                  width: 142,
                  height: 27,
                ),
              ),
              Text(
                AppLocalizations.of(context)!.loginToAccount,
                style: Theme.of(context).textTheme.labelLarge,
              ),
              CustomTextField(
                filled: appThemeProvider.isDarkMode() ? false : true,
                fillColor: AppColors.white,
                borderColor: appThemeProvider.isDarkMode()
                    ? AppColors.main
                    : AppColors.strokeColor,
                prefixIcon: Icon(
                  Icons.email,
                  color: AppColors.lightGrey,
                  size: 25,
                ),
                hintText: AppLocalizations.of(context)!.enterEmail,
                hintStyle: AppStyles.regular14Grey,
              ),
              CustomTextField(
                borderColor: appThemeProvider.isDarkMode()
                    ? AppColors.main
                    : AppColors.strokeColor,
                filled: appThemeProvider.isDarkMode() ? false : true,
                fillColor: AppColors.white,
                prefixIcon: Icon(
                  Icons.lock,
                  color: AppColors.lightGrey,
                  size: 25,
                ),
                suffixIcon: Icon(
                  Icons.visibility_off,
                  color: AppColors.lightGrey,
                  size: 25,
                ),
                hintText: AppLocalizations.of(context)!.enterPassword,
                hintStyle: AppStyles.regular14Grey,
              ),
              TextButton(
                onPressed: () {
                  //todo:navigate to forget password screen
                  Navigator.pushNamed(context, AppRoutes.forgetPassScreen);
                },
                child: Align(
                  alignment: Alignment.topRight,
                  child: Text(
                    AppLocalizations.of(context)!.forgetPassword,
                    style: appThemeProvider.isDarkMode()
                        ? AppStyles.regular14MainDark.copyWith(
                            decoration: TextDecoration.underline,
                            color: AppColors.mainDarkMode,
                          )
                        : AppStyles.regular14Main.copyWith(
                            decoration: TextDecoration.underline,
                            color: AppColors.main,
                          ),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.homeScreen);
                },
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    AppLocalizations.of(context)!.login,
                    style: AppStyles.semi20White,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppLocalizations.of(context)!.dontHaveAccount,
                    style: AppStyles.regular14Grey,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoutes.registerScreen);
                    },
                    child: Text(
                      AppLocalizations.of(context)!.signUp,
                      style: appThemeProvider.isDarkMode()
                          ? AppStyles.regular14MainDark.copyWith(
                              decoration: TextDecoration.underline,
                            )
                          : AppStyles.regular14Main.copyWith(
                              decoration: TextDecoration.underline,
                            ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Divider(
                      color: AppColors.lightGrey,
                      thickness: 2,
                      indent: width * 0.02,
                      endIndent: width * 0.02,
                    ),
                  ),
                  Text(
                    AppLocalizations.of(context)!.or,
                    style: appThemeProvider.isDarkMode()
                        ? AppStyles.medium16MainDark
                        : AppStyles.medium16Main,
                  ),
                  Expanded(
                    child: Divider(
                      color: AppColors.lightGrey,
                      thickness: 2,
                      indent: width * 0.02,
                      endIndent: width * 0.02,
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: 343,
                height: 43,
                child: MaterialButton(
                  onPressed: () async {
                    //todo:navigate to google login
                    final user = await signInWithGoogle();

                    if (user != null) {
                      print("Email: ${user.user!.email}");

                    }},
                  color: appThemeProvider.isDarkMode()
                      ? AppColors.bgDarkMode
                      : AppColors.white,

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                    side: BorderSide(
                      color: appThemeProvider.isDarkMode()
                          ? AppColors.strokeDarkColor
                          : AppColors.strokeColor,
                      width: 2,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(AppAssets.googleLogo, width: 24, height: 24),
                      SizedBox(width: 5),
                      Text(
                        AppLocalizations.of(context)!.loginWithGoogle,
                        style: appThemeProvider.isDarkMode()
                            ? AppStyles.medium18mainDark
                            : AppStyles.medium18main,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
