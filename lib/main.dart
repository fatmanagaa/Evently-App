import 'package:evently_app/core/app_routes.dart';
import 'package:evently_app/providers/app_language_provider.dart';
import 'package:evently_app/providers/app_theme_provider.dart';
import 'package:evently_app/screens/home_screen/home_screen.dart';
import 'package:evently_app/screens/auth/login/login_screen.dart';
import 'package:evently_app/screens/onBoarding_screen/onboarding_screen.dart';
import 'package:evently_app/screens/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/app_theme.dart';
import 'l10n/app_localizations.dart';


void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => AppLanguageProvider()),
    ChangeNotifierProvider(create: (context) => AppThemeProvider()),
  ],
  child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var appLanguageProvider = Provider.of<AppLanguageProvider>(context);
    var appThemeProvider = Provider.of<AppThemeProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.splashScreen,
      routes: {
        AppRoutes.onboardingScreen: (context) => OnboardingScreen(),
        AppRoutes.homeScreen: (context) => HomeScreen(),
        AppRoutes.loginScreen: (context) => LoginScreen(),
        AppRoutes.splashScreen: (context) => SplashScreen(),
      },
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale(appLanguageProvider.appLanguage),

      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: appThemeProvider.appTheme,
    );
  }
}

