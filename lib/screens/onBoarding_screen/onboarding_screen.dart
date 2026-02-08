import 'package:evently_app/core/app_assets.dart';
import 'package:evently_app/core/app_style.dart';
import 'package:evently_app/core/app_theme.dart';
import 'package:evently_app/l10n/app_localizations.dart';
import 'package:evently_app/screens/onBoarding_screen/on_boarding_pages/on_boarding_p3.dart';
import 'package:flutter/material.dart';

import '../home_screen/home_screen.dart';
import 'on_boarding_pages/on_boarding_p1.dart';
import 'on_boarding_pages/on_boarding_p2.dart';
import 'on_boarding_pages/on_boarding_p4.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController controller = PageController();
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Center(
                child: Image.asset(
                  AppAssets.getLogo(context),
                  width: 142,
                  height: 27,
                ),
              ),
              Expanded(
                child: PageView(
                  controller: controller,
                  onPageChanged: (index) {
                    currentIndex = index;
                    setState(() {});
                  },
                  children: [
                    OnBoardingP1(),
                    OnBoardingP2(),
                    OnBoardingP3(),
                    OnBoardingP4(),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  if (currentIndex < 3) {
                    controller.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  } else {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomeScreen(),
                      ),
                    );
                  }
                },
                child: Center(
                  child: Text(
                    currentIndex == 0
                        ? AppLocalizations.of(context)!.letsStart
                        : AppLocalizations.of(context)!.next,
                    style: AppStyles.semi20White,
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
