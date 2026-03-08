import 'package:evently_app/core/app_assets.dart';
import 'package:evently_app/core/app_routes.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushReplacementNamed(context, AppRoutes.onboardingScreen);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(height: 320),
              Center(
                child: Image.asset(
                  AppAssets.getSplashLogo(context),
                  width: 300,
                  height: 50,
                ),
              ),
              SizedBox(height: 250),
              Center(
                child: Image.asset(
                  AppAssets.getBrandingImage(context),
                  width: 210,
                  height: 50,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
