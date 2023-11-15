import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickgrocer_application/src/constants/text_strings.dart';
import 'package:quickgrocer_application/src/repository/authentication_repository/authentication_repository.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  // TextField Controllers to get data from TextFields
  final showPassword = false.obs;
  final email = TextEditingController();
  final password = TextEditingController();

  // Email and Password Login
  Future<void> loginUser(String email, String password) async {
    try {
      final auth = AuthenticationRepository.instance;
      await auth.loginWithEmailAndPassword(email, password);
      auth.setInitialScreen(auth.firebaseUser.value);
    } catch (e) {
      Get.snackbar(ohSnap, e.toString(), snackPosition: SnackPosition.BOTTOM, duration: const Duration(seconds: 5));
    }
  }

  // Reset Password
  Future<void> resetPassword(String email) async {
    try {
      final auth = AuthenticationRepository.instance;
      await auth.resetPasswordEmail(email);
      auth.setInitialScreen(auth.firebaseUser.value);
    } catch (e) {
      Get.snackbar(ohSnap, e.toString(), snackPosition: SnackPosition.BOTTOM, duration: const Duration(seconds: 5));
    }
  }

  Future<void> googleSignIn() async {
    try {
      final auth = AuthenticationRepository.instance;
      await auth.signInWithGoogle();
      auth.setInitialScreen(auth.firebaseUser.value);
    } catch (e) {
      Get.showSnackbar(GetSnackBar(message: e.toString()));
    }
  }
}
