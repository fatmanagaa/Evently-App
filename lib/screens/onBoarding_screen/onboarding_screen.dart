import 'package:evently_app/core/app_assets.dart';
import 'package:evently_app/core/app_colors.dart';
import 'package:evently_app/core/app_style.dart';
import 'package:flutter/material.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Image.asset(AppAssets.logo), centerTitle: true),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Image.asset(AppAssets.creative, width: double.infinity)),
            SizedBox(height: 18),
            Text('Personalize Your Experience', style: AppStyles.semi20Black),
            SizedBox(height: 8),
            Text(
              'Choose your preferred theme and language to get started with a comfortable, tailored experience that suits your style.',

            ),
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Language'),
                  SizedBox(width: 50),
                  Image.asset(AppAssets.english),
                  Image.asset(AppAssets.arabic),
                ],
              ),
            ),
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Theme', ),
                  SizedBox(width: 50),
                  Image.asset(AppAssets.light),
                  Image.asset(AppAssets.dark),
                ],
              ),
            ),
            SizedBox(height: 15),
            Center(
              child: ElevatedButton(onPressed: () {}, style: ElevatedButton.styleFrom(
                fixedSize: Size(343, 60),

                padding: EdgeInsets.symmetric(vertical: 16,horizontal: 50),
                backgroundColor: AppColors.main,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ), child: Text('Let’s start',)),
            ),
          ],
        ),
      ),
    );
  }
}
