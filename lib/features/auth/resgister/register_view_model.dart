//todo: viewModel => observable => stateManagement
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterViewModel extends ChangeNotifier {
  //todo: hold data - handle logic
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
