import 'package:evently_app/core/utils/app_assets.dart';
import 'package:evently_app/core/utils/app_colors.dart';
import 'package:evently_app/core/utils/app_style.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:evently_app/core/utils/app_routes.dart';
import '../../../l10n/app_localizations.dart';
import '../../../providers/app_theme_provider.dart';
import '../../home_screen/widgets/custom_text_field.dart';
import '../google_auth/google_auth.dart';
class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;
  bool passwordVisible = false;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
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
                    AppLocalizations.of(context)!.loginToAccount,
                    style: Theme.of(context).textTheme.labelLarge,
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
                    obscureText: !passwordVisible,
                    Validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },

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
                  TextButton(
                    onPressed: () {
                      // navigate to forget password screen
                      Navigator.pushNamed(context, AppRoutes.forgetPassScreen);
                    },
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Text(
                        AppLocalizations.of(context)!.forgetPassword,
                        style: appThemeProvider.isDarkMode()
                            ? AppStyles.regular14MainDark.copyWith(
                                decoration: TextDecoration.underline,
                                color: AppColors.mainDarkMode,
                              )
                            : AppStyles.regular14Main.copyWith(
                                decoration: TextDecoration.underline,
                                color: AppColors.main,
                              ),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: isLoading ? null : () => login(context),
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
                              AppLocalizations.of(context)!.login,
                              style: AppStyles.semi20White,
                            ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.dontHaveAccount,
                        style: AppStyles.regular14Grey,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, AppRoutes.registerScreen);
                        },
                        child: Text(
                          AppLocalizations.of(context)!.signUp,
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
                                       const SnackBar(content: Text('Google sign-in cancelled')),
                                     );
                                   }
                                 }
                               } catch (e) {
                                 if (mounted) {
                                   ScaffoldMessenger.of(context).showSnackBar(
                                     SnackBar(content: Text(e.toString())),
                                   );
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
                          Image.asset(AppAssets.googleLogo, width: 24, height: 24),
                          SizedBox(width: 5),
                          Text(
                            AppLocalizations.of(context)!.loginWithGoogle,
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

  Future<void> login(BuildContext context) async {
    if (isLoading) return;
    if (formKey.currentState?.validate() != true) return;

    setState(() => isLoading = true);
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text,
      );

      if (credential.user != null) {
        // Clear controllers on success
        emailController.clear();
        passwordController.clear();
        // Navigate to home (use pushReplacementNamed to prevent back navigation to login)
        if (mounted) Navigator.pushReplacementNamed(context, AppRoutes.homeScreen);
      }
    } on FirebaseAuthException catch (e) {
      String message = '';
      if (e.code == 'user-not-found') {
        message = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        message = 'Wrong password provided for that user.';
      } else if (e.code == 'invalid-email') {
        message = 'The email address is invalid.';
      } else if (e.code == 'user-disabled') {
        message = 'Your account has been disabled. Please contact support.';
      } else if (e.code == 'too-many-requests') {
        message = 'Too many login attempts. Please try again later.';
      } else if (e.code == 'operation-not-allowed') {
        message = 'Email/Password sign in is not enabled. Please contact support.';
      } else {
        message = e.message ?? e.code;
      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Login failed: ${e.toString()}')));
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }
}
