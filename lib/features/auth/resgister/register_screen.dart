import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/utils/app_assets.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_routes.dart';
import '../../../core/utils/app_style.dart';
import '../../../l10n/app_localizations.dart';
import '../../../providers/app_theme_provider.dart';
import '../../home_screen/widgets/custom_text_field.dart';
import '../google_auth/google_auth.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController repasswordController;
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;
  bool passwordVisible = false;
  bool repasswordVisible = false;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    repasswordController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    repasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appThemeProvider = Provider.of<AppThemeProvider>(context);
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
                      hintStyle: appThemeProvider.isDarkMode()
                          ? AppStyles.regular14Grey.copyWith(color: Colors.white)
                          : AppStyles.regular14Grey,
                      style: appThemeProvider.isDarkMode()
                          ? TextStyle(color: Colors.white)
                          : null,
                  ),
                  CustomTextField(
                    controller: emailController,
                    Validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter your email';
                      }
                      final emailValid = RegExp(
                        r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]+$",
                      ).hasMatch(value);
                      if (!emailValid) {
                        return 'Please enter a valid email';
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
                      hintStyle: appThemeProvider.isDarkMode()
                          ? AppStyles.regular14Grey.copyWith(color: Colors.white)
                          : AppStyles.regular14Grey,
                      style: appThemeProvider.isDarkMode()
                          ? TextStyle(color: Colors.white)
                          : null,
                  ),
                  CustomTextField(
                    controller: passwordController,
                    Validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                    obscureText: !passwordVisible,

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
                    suffixIcon: GestureDetector(
                      onTap: () => setState(() => passwordVisible = !passwordVisible),
                      child: Icon(
                        passwordVisible ? Icons.visibility : Icons.visibility_off,
                        color: AppColors.lightGrey,
                        size: 25,
                      ),
                    ),
                    hintText: AppLocalizations.of(context)!.enterPassword,
                      hintStyle: appThemeProvider.isDarkMode()
                          ? AppStyles.regular14Grey.copyWith(color: Colors.white)
                          : AppStyles.regular14Grey,
                      style: appThemeProvider.isDarkMode()
                          ? TextStyle(color: Colors.white)
                          : null,
                  ),
                  CustomTextField(
                    controller: repasswordController,
                    Validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please confirm your password';
                      }
                      if (value != passwordController.text) {
                        return 'Password does not match';
                      }
                      return null;
                    },
                    obscureText: !repasswordVisible,

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
                    suffixIcon: GestureDetector(
                      onTap: () => setState(() => repasswordVisible = !repasswordVisible),
                      child: Icon(
                        repasswordVisible ? Icons.visibility : Icons.visibility_off,
                        color: AppColors.lightGrey,
                        size: 25,
                      ),
                    ),
                    hintText: AppLocalizations.of(context)!.confirmPassword,
                      hintStyle: appThemeProvider.isDarkMode()
                          ? AppStyles.regular14Grey.copyWith(color: Colors.white)
                          : AppStyles.regular14Grey,
                      style: appThemeProvider.isDarkMode()
                          ? TextStyle(color: Colors.white)
                          : null,
                  ),

                  ElevatedButton(
                    onPressed: isLoading ? null : () => register(context),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: isLoading
                          ? SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : Text(
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
                      onPressed: isLoading
                          ? null
                          : () async {
                              setState(() => isLoading = true);
                              try {
                                final user = await signInWithGoogle();
                                if (user != null) {
                                  // Use pushReplacementNamed to prevent back navigation
                                  if (mounted) Navigator.pushReplacementNamed(context, AppRoutes.homeScreen);
                                } else {
                                  // User cancelled Google sign-in
                                  if (mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('Google sign-up cancelled')),
                                    );
                                  }
                                }
                              } catch (e) {
                                if (mounted) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(content: Text(e.toString())));
                                }
                              } finally {
                                if (mounted) setState(() => isLoading = false);
                              }
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

  Future<void> register(BuildContext context) async {
    if (isLoading) return;
    if (formKey.currentState?.validate() != true) return;

    setState(() => isLoading = true);
    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text,
      );

      if (credential.user != null) {
        // Clear controllers on success
        emailController.clear();
        passwordController.clear();
        repasswordController.clear();
        // Navigate to home (use pushReplacementNamed to prevent back navigation to register)
        if (mounted) Navigator.pushReplacementNamed(context, AppRoutes.homeScreen);
      }
    } on FirebaseAuthException catch (e) {
      String message;
      if (e.code == 'weak-password') {
        message = 'The password provided is too weak. Use at least 6 characters with a mix of letters and numbers.';
      } else if (e.code == 'email-already-in-use') {
        message = 'The account already exists for that email. Please login instead.';
      } else if (e.code == 'invalid-email') {
        message = 'The email address is invalid.';
      } else if (e.code == 'operation-not-allowed') {
        message = 'Email/Password registration is not enabled. Please contact support.';
      } else if (e.code == 'too-many-requests') {
        message = 'Too many registration attempts. Please try again later.';
      } else {
        message = e.message ?? e.code;
      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Registration failed: ${e.toString()}')));
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }
}
