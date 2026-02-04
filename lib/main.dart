import 'package:evently_app/core/app_routes.dart';
import 'package:evently_app/providers/app_language_provider.dart';
import 'package:evently_app/screens/home_screen/home_screen.dart';
import 'package:evently_app/screens/auth/login_screen.dart';
import 'package:evently_app/screens/onBoarding_screen/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'l10n/app_localizations.dart';


void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => AppLanguageProvider(),
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var appLanguageProvider = Provider.of<AppLanguageProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.homeScreen,
      routes: {
        AppRoutes.onboardingScreen: (context) => OnboardingScreen(),
        AppRoutes.homeScreen: (context) => HomeScreen(),
        AppRoutes.loginScreen: (context) => LoginScreen(),
      },
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale(appLanguageProvider.appLanguage),

    );
  }
}
