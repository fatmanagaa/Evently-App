import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'login_navigator.dart';

class LoginViewModel extends ChangeNotifier {
  // Data
  final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool isLoading = false;

  LoginNavigator? navigator;

  Future<void> login() async {
    if (isLoading) return;

    if (formKey.currentState?.validate() != true) return;

    setLoading(true);

    try {
      final credential =
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text,
      );

      if (credential.user != null) {
        clearControllers();
        navigator?.goHome();
      }
    } on FirebaseAuthException catch (e) {
      navigator?.showErrorMessage(
        getErrorMessage(e),
      );
    } catch (e) {
      navigator?.showErrorMessage(
        'Login failed: ${e.toString()}',
      );
    } finally {
      setLoading(false);
    }
  }

  void setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  void clearControllers() {
    emailController.clear();
    passwordController.clear();
  }

  String getErrorMessage(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return 'No user found for that email.';

      case 'wrong-password':
        return 'Wrong password provided for that user.';

      case 'invalid-email':
        return 'The email address is invalid.';

      case 'user-disabled':
        return 'Your account has been disabled.';

      case 'too-many-requests':
        return 'Too many login attempts. Please try again later.';

      default:
        return e.message ?? e.code;
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}