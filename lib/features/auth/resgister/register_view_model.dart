//todo: viewModel => observable => stateManagement
//todo: hold data - handle logic

import 'package:evently_app/features/auth/resgister/register_navigator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterViewModel extends ChangeNotifier {
  ///this is the data
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final repasswordController = TextEditingController();
  bool _isLoading = false;

  bool get isLoading => _isLoading;
  RegisterNavigator? navigator;

  Future<void> register(BuildContext context) async {
    if (_isLoading) return;
    if (formKey.currentState?.validate() != true) return;
    _setLoading(true);

    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text,
          );

      if (credential.user != null) {
        _clearControllers();

        // Navigate to home (use pushReplacementNamed to prevent back navigation to register)
        navigator?.goHome();
      }
    } on FirebaseAuthException catch (e) {
      navigator?.showErrorMessage(_getErrorMessage(e));
    } catch (e) {
      navigator?.showErrorMessage('Error Try Again${e.toString()}');
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void setLoading(bool value) {
    _setLoading(value);
  }

  void _clearControllers() {
    nameController.clear();
    emailController.clear();
    passwordController.clear();
    repasswordController.clear();
  }

  String _getErrorMessage(FirebaseAuthException e) {
    switch (e.code) {
      case 'weak-password':
        return 'Password is too weak — use at least 6 characters';
      case 'email-already-in-use':
        return 'This email is already in use — please sign in';
      case 'invalid-email':
        return 'Invalid email address';
      case 'too-many-requests':
        return 'Too many attempts — please try again later';
      default:
        return e.message ?? 'An unexpected error occurred';
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    repasswordController.dispose();
    super.dispose();
  }
}
