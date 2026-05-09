import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/utils/app_assets.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_routes.dart';
import '../../../core/utils/app_style.dart';
import '../../../l10n/app_localizations.dart';
import '../../../providers/app_language_provider.dart';
import '../../../providers/app_theme_provider.dart';
import '../../home_screen/widgets/custom_text_field.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController repasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    late var appLanguageProvider = Provider.of<AppLanguageProvider>(context);
    late var appThemeProvider = Provider.of<AppThemeProvider>(context);
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: width * 0.04,
              vertical: height * 0.02,
            ),
            child: Form(
              key: formKey,
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
                    AppLocalizations.of(context)!.createAccount,
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  CustomTextField(
                    filled: appThemeProvider.isDarkMode() ? false : true,
                    fillColor: AppColors.white,
                    borderColor: appThemeProvider.isDarkMode()
                        ? AppColors.main
                        : AppColors.strokeColor,
                    prefixIcon: Icon(
                      Icons.person_outlined,
                      color: AppColors.lightGrey,
                      size: 25,
                    ),
                    hintText: AppLocalizations.of(context)!.enterName,
                    hintStyle: AppStyles.regular14Grey,
                  ),
                  CustomTextField(
                    controller: emailController,
                    Validator: (value) {
                      if (value!.isEmpty || value == null) {
                        return 'Please enter your email';
                      }
                      final bool emailValid = RegExp(
                        r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]+$",
                      ).hasMatch(value);
                      if (!emailValid) {
                        return 'please enter your email';
                      }
                      return null;
                    },
                    borderColor: appThemeProvider.isDarkMode()
                        ? AppColors.main
                        : AppColors.strokeColor,
                    filled: appThemeProvider.isDarkMode() ? false : true,
                    fillColor: AppColors.white,
                    prefixIcon: Icon(
                      Icons.email,
                      color: AppColors.lightGrey,
                      size: 25,
                    ),
        
                    hintText: AppLocalizations.of(context)!.enterEmail,
                    hintStyle: AppStyles.regular14Grey,
                  ),
                  CustomTextField(
                    controller: passwordController,
                    Validator: (value) {
                      if (value!.isEmpty || value == null) {
                        return 'Please enter your pass';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                    obscureText: true,
        
        
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
                  CustomTextField(
                    controller: repasswordController,
                    Validator: (value) {
                      if (value!.isEmpty || value == null) {
                        return 'Please enter your pass';
                      }
                      if (value != passwordController.text) {
                        return 'Password does not match';
                      }
                      return null;
                    },
                    obscureText: true,
        
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
                    hintText: AppLocalizations.of(context)!.confirmPassword,
                    hintStyle: AppStyles.regular14Grey,
                  ),
        
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoutes.homeScreen);
                    },
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        AppLocalizations.of(context)!.signUp,
                        style: AppStyles.semi20White,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.alreadyHaveAccount,
                        style: AppStyles.regular14Grey,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, AppRoutes.loginScreen);
                        },
                        child: Text(
                          AppLocalizations.of(context)!.login,
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
                      onPressed: () {
                        //todo:navigate to google login
                      },
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
                          Image.asset(
                            AppAssets.googleLogo,
                            width: 24,
                            height: 24,
                          ),
                          SizedBox(width: 5),
                          Text(
                            AppLocalizations.of(context)!.signUpWithGoogle,
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
        ),
      ),
    );
  }
  Future<void> register() async {
    if(formKey.currentState?.validate()==true){
      try {
        final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        print('Reg Sucsssfuylly');
        print('id:${credential.user?.uid??''}');
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          print('The account already exists for that email.');
        }
      } catch (e) {
        print(e);
      }
    }
  }
}
