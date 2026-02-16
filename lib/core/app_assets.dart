import 'package:flutter/material.dart';

class AppAssets {
  static String getLogo(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? 'assets/images/logo_dark.png'
        : 'assets/images/logo.png';
  }
static const String logo='assets/images/logo.png';
static const String english='assets/images/Eng.png';
static const String arabic='assets/images/Arabic.png';
static const String creative='assets/images/creative.png';
static const String light='assets/images/Light.png';
static const String dark='assets/images/Dark.png';
static const String eyeSlash='assets/images/eye-slash.png';
static const String lock='assets/images/lock.png';
static const String sms='assets/images/sms.png';
static const String mainButton='assets/images/Main btn.png';
static const String profilePic='assets/images/Profile pic.png';
static const String googleLogo='assets/images/image 6.png';
static const String birthday='assets/images/birth_day_image.png';


  static String getOnBoardingImage_1(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? 'assets/images/on_boarding_1_dark.png'
        : 'assets/images/onBoarding 1.png';

}
  static String getOnBoardingImage_2(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? 'assets/images/on_boarding_2_dark.png'
        : 'assets/images/onBoarding 2.png';

  }
  static String getOnBoardingImage_3(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? 'assets/images/on_boarding_3_dark.png'
        : 'assets/images/onBoarding 3.png';

  }
  static String getOnBoardingImage_4(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? 'assets/images/on_boarding_4_dark.png'
        : 'assets/images/onBoarding 4.png';

  }
  static String getSplashLogo(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? 'assets/images/logo_dark.png'
        : 'assets/images/logo_white.png';

  }
  static String getBrandingImage(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? 'assets/images/branding_dark.png'
        : 'assets/images/branding_light.png';

  }
  static String getForgetPassImage(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? 'assets/images/change-setting (1).png'
        : 'assets/images/change-setting.png';

  }












}