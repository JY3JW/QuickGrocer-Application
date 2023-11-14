import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickgrocer_application/src/repository/authentication_repository/authentication_repository.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  // TextField Controllers to get data from TextFields
  final email = TextEditingController();
  final password = TextEditingController();

  // Call this function from Design & it will do the rest
  Future<void> loginUser(String email, String password) async {
    String? error = await AuthenticationRepository.instance
        .loginWithEmailAndPassword(email, password);
    if (error != null) {
      Get.showSnackbar(GetSnackBar(message: error.toString()));
    }
  }
}
