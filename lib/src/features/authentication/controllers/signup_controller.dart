import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickgrocer_application/src/features/authentication/models/user_model.dart';
import 'package:quickgrocer_application/src/repository/authentication_repository/authentication_repository.dart';
import 'package:quickgrocer_application/src/repository/user_repository/user_repository.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();

  //TextField Controllers to get data from TextFields
  final email = TextEditingController();
  final password = TextEditingController();
  final name = TextEditingController();
  final phone = TextEditingController();

  final userRepo = Get.put(UserRepository());

  clearControllers() {
    email.clear();
    name.clear();
    password.clear();
    phone.clear();
  }

  //Call this Function from Design and it will do the rest
  Future<String?> registerUser(String email, String password) {
    return AuthenticationRepository.instance
        .createUserWithEmailAndPassword(email, password);
  }

  //Get phoneNo from user and pass it to Auth Repository for Firebase Authentication
  void phoneAuthentication(String phone) {
    AuthenticationRepository.instance.phoneAuthentication(phone);
  }

  Future<void> createUser(UserModel user) async {
    try {
      String? userID = await registerUser(user.email, user.password);
      await userRepo.createUser(user, userID);
      AuthenticationRepository.instance.setInitialScreen(
          AuthenticationRepository.instance.firebaseUser.value);
    } catch (e) {
      Get.snackbar("Sign Up Failed", e.toString().toString(),
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 5));
    }
  }
}
