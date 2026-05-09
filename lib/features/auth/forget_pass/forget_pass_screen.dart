import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/utils/app_assets.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_style.dart';
import '../../../l10n/app_localizations.dart';
import '../../../providers/app_theme_provider.dart';
import '../../home_screen/widgets/custom_text_field.dart';

class ForgetPassScreen extends StatefulWidget {
  const ForgetPassScreen({super.key});

  @override
  State<ForgetPassScreen> createState() => _ForgetPassScreenState();
}

class _ForgetPassScreenState extends State<ForgetPassScreen> {
  late TextEditingController emailController;
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appThemeProvider = Provider.of<AppThemeProvider>(context);
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context)!.forgetPassword,
          style: appThemeProvider.isDarkMode()
              ? AppStyles.regular18White
              : AppStyles.regular18Black,
        ),
      ),
      body: SingleChildScrollView(
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
                // Forget Password Image
                Center(
                  child: Image.asset(
                    AppAssets.getForgetPassImage(context),
                    width: 343,
                    height: 250,
                  ),
                ),
                SizedBox(height: height * 0.02),

                // Title
                Text(
                  AppLocalizations.of(context)!.forgetPassword,
                  style: appThemeProvider.isDarkMode()
                      ? AppStyles.semi20White
                      : AppStyles.semi20Black,
                ),

                // Description
                Text(
                  'Enter your email address and we\'ll send you a password reset link.',
                  style: appThemeProvider.isDarkMode()
                      ? AppStyles.regular14Grey.copyWith(color: Colors.white70)
                      : AppStyles.regular14Grey,
                ),

                SizedBox(height: height * 0.02),

                // Email Input Field
                CustomTextField(
                  controller: emailController,
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
                ),

                SizedBox(height: height * 0.03),

                // Reset Password Button
                ElevatedButton(
                  onPressed: isLoading ? null : () => _sendPasswordResetEmail(context),
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
                            AppLocalizations.of(context)!.resetPassword,
                            style: AppStyles.semi20White,
                          ),
                  ),
                ),

                SizedBox(height: height * 0.02),

                // Back to Login Link
                Center(
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Back to Login',
                      style: appThemeProvider.isDarkMode()
                          ? AppStyles.regular14MainDark.copyWith(
                              decoration: TextDecoration.underline,
                            )
                          : AppStyles.regular14Main.copyWith(
                              decoration: TextDecoration.underline,
                            ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _sendPasswordResetEmail(BuildContext context) async {
    if (isLoading) return;
    if (formKey.currentState?.validate() != true) return;

    setState(() => isLoading = true);
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: emailController.text.trim(),
      );

      // Show success message
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Password reset email sent! Check your inbox.',
            ),
            duration: Duration(seconds: 4),
            backgroundColor: Colors.green,
          ),
        );

        // Clear input
        emailController.clear();

        // Navigate back after a short delay
        await Future.delayed(Duration(seconds: 2));
        if (mounted) Navigator.pop(context);
      }
    } on FirebaseAuthException catch (e) {
      String message = '';
      if (e.code == 'user-not-found') {
        message = 'No user found for that email address.';
      } else if (e.code == 'invalid-email') {
        message = 'The email address is invalid.';
      } else if (e.code == 'too-many-requests') {
        message = 'Too many password reset requests. Please try again later.';
      } else {
        message = e.message ?? e.code;
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(message),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to send reset email: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }
}
