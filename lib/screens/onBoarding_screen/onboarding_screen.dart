import 'package:evently_app/core/app_assets.dart';
import 'package:evently_app/core/app_colors.dart';
import 'package:evently_app/core/app_style.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final introKey = GlobalKey<IntroductionScreenState>();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: IntroductionScreen(
        key: introKey,
        globalBackgroundColor: Color(0xFFF4F7FF),
        showSkipButton: false,
        showNextButton: false,
        showDoneButton: false,

        dotsDecorator: DotsDecorator(
          activeColor: AppColors.main,
          size: const Size.square(10.0),
          activeSize:const Size(20.0, 10.0),
          spacing: const EdgeInsets.symmetric(horizontal: 3.0),
          activeShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),


        ),
        pages: [
          PageViewModel(

            title: '',
            bodyWidget: Column(
              spacing: height * 0.02,

              children: [
                Center(
                  child: Image.asset(AppAssets.logo, width: 142, height: 27),
                ),
                Center(
                  child: Image.asset(
                    AppAssets.onBoarding_1,
                    width: 343,
                    height: 343,
                  ),
                ),
                Text(
                  'Personalize Your Experience',
                  style: AppStyles.semi20Black,
                ),
                Text(
                  'Choose your preferred theme and language to get started with a comfortable, tailored experience that suits your style.',
                style: AppStyles.regular14Grey,),
                Row(
                  children: [
                    Text('Language',style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                      color: AppColors.main
                    ),),

                  ],
                ),
                Row(
                  children: [
                    Text('Theme')
                  ],
                ),
                ElevatedButton(onPressed: (){}, child:Container(
                  color: AppColors.main,

                ) )
              ],

            ),
          ),
        ],
      ),
    );
  }
}
