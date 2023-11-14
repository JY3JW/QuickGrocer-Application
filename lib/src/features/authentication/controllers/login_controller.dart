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
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  var isPasswordHidden = true.obs;

  // Loader
  final isGoogleLoading = false.obs;
  final isLoading = false.obs;

  // Email and Password Login
  Future<void> loginUser(String email, String password) async {
    try {
      isLoading.value = true;
      if (!loginFormKey.currentState!.validate()) {
        isLoading.value = false;
        return;
      }
      final auth = AuthenticationRepository.instance;
      await auth.loginWithEmailAndPassword(email, password);
      auth.setInitialScreen(auth.firebaseUser.value);
    } catch (e) {
      isLoading.value = false;
      Get.snackbar(ohSnap, e.toString(), snackPosition: SnackPosition.BOTTOM, duration: const Duration(seconds: 5));
    }
  }

  Future<void> googleSignIn() async {
    try {
      isGoogleLoading.value = true;
      final auth = AuthenticationRepository.instance;
      await auth.signInWithGoogle();
      isGoogleLoading.value = false;
      auth.setInitialScreen(auth.firebaseUser.value);
    } catch (e) {
      isGoogleLoading.value = false;
      Get.showSnackbar(GetSnackBar(message: e.toString()));
    }
  }
}
