import 'package:evently_app/features/auth/resgister/register_navigator.dart';
import 'package:evently_app/features/auth/resgister/register_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/app_assets.dart';
import '../../../core/app_colors.dart';
import '../../../core/app_routes.dart';
import '../../../core/app_style.dart';
import '../../../l10n/app_localizations.dart';
import '../../../providers/app_theme_provider.dart';
import '../../home_screen/widgets/custom_text_field.dart';
import '../google_auth/google_auth.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> implements RegisterNavigator {

  late RegisterViewModel viewModel;
  bool passwordVisible = false;
  bool repasswordVisible = false;


  @override
  void initState() {
    super.initState();
    viewModel = RegisterViewModel();
    viewModel.navigator = this;
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appThemeProvider = Provider.of<AppThemeProvider>(context);
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return ChangeNotifierProvider(
      create: (BuildContext context) {
        return viewModel;
      },
      child: Consumer<RegisterViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            body: SingleChildScrollView(
              child: SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                  horizontal: width * 0.04,
                  vertical: height * 0.02,
                ),
                child: Form(
                  key: viewModel.formKey,
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
                         controller: viewModel.nameController,
                         Validator: (value) {
                           if (value == null || value.trim().isEmpty) {
                             return 'Please enter your name';
                           }
                           return null;
                         },
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
                         controller: viewModel.emailController,
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
                         controller: viewModel.passwordController,
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
                         controller: viewModel.repasswordController,
                         Validator: (value) {
                           if (value == null || value.isEmpty) {
                             return 'Please confirm your password';
                           }
                           if (value != viewModel.passwordController.text) {
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
                        onPressed: viewModel.isLoading ? null : () => viewModel.register(context),
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: viewModel.isLoading
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
                           onPressed: viewModel.isLoading
                               ? null
                               : () async {
                                   viewModel.setLoading(true);
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
                                     if (mounted) viewModel.setLoading(false);
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
                  ), // Column
                ), // Form
              ), // Padding
            ), // SafeArea
          ), // SingleChildScrollView
        ); // return Scaffold
      }, // builder
    ), // Consumer
  ); // ChangeNotifierProvider
  }

  @override
  void goHome() {
    Navigator.pushReplacementNamed(context, AppRoutes.homeScreen);
  }

  @override
  void showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }
}
