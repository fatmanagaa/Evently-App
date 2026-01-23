import 'package:evently_app/core/app_routes.dart';
import 'package:evently_app/screens/home_screen/home_screen.dart';
import 'package:evently_app/screens/onBoarding_screen/onboarding_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: AppRoutes.onboardingScreen,
      routes: {
        AppRoutes.onboardingScreen: (context) => OnboardingScreen(),
        AppRoutes.homeScreen: (context) => HomeScreen(),
      },
    );
  }
}
