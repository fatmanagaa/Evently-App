import 'package:evently_app/core/app_assets.dart';
import 'package:evently_app/core/app_colors.dart';
import 'package:evently_app/core/app_style.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Logo
                Image.asset(AppAssets.logo),
                const SizedBox(height: 48),

                // Title
                Text(
                  'Login to your account',
                  style: AppStyles.bold24Main,
                ),
                const SizedBox(height: 24),

                // Email
                TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: 'Enter your email',
                    prefixIcon: Image.asset(AppAssets.sms),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(color: AppColors.stroke),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(color: AppColors.stroke),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Password
                TextField(
                  controller: _passwordController,
                  obscureText: !_isPasswordVisible,
                  decoration: InputDecoration(
                    hintText: 'Enter your password',
                    prefixIcon: Image.asset(AppAssets.lock),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(color: AppColors.stroke),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(color: AppColors.stroke),
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                // Forget password
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      'Forget Password?',

                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Login Button
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(343, 48),
                    backgroundColor: AppColors.main,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Text(
                    'Login',
                    style: AppStyles.semi20White,
                  ),
                ),
                const SizedBox(height: 24),

                // Signup
                Wrap(
                  alignment: WrapAlignment.center,
                  children: [
                    Text(
                      "Don't have an account? ",
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        'Signup',
                        style: TextStyle(
                          color: AppColors.main,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Or divider
                const Row(
                  children: [
                    Expanded(child: Divider()),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child:
                      Text('Or', style: TextStyle(color: Colors.grey)),
                    ),
                    Expanded(child: Divider()),
                  ],
                ),
                const SizedBox(height: 24),

                // Google Button
                Image.asset(
                  'assets/images/Main btn.png',
                  height: 48,
                  width: 343,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
