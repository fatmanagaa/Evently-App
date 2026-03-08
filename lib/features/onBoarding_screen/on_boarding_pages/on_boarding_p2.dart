import 'package:evently_app/core/app_assets.dart';
import 'package:evently_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class OnBoardingP2 extends StatelessWidget {

  const OnBoardingP2({super.key, superkey});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          spacing: 20,
          children: [
            Image.asset(
              AppAssets.getOnBoardingImage_2(context),
              width: 343,
              height: 343,
            ),
            Text(
              AppLocalizations.of(context)!.findEvents,
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            Text(
              AppLocalizations.of(context)!.diveIntoEvents,
              style: Theme.of(context).textTheme.headlineMedium,
            ),

          ],
        ),
      ),
    );
  }
}
