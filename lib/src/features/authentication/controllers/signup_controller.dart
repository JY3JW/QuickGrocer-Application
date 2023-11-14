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
  GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();
  var isPasswordHidden = true.obs;

  final userRepo = Get.put(UserRepository());

  // Loader
  final isLoading = false.obs;

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
      isLoading.value = true;
      if (!signUpFormKey.currentState!.validate()) {
        isLoading.value = false;
        return;
      }
      String? userID = await registerUser(user.email, user.password);
      await userRepo.createUser(user, userID);
    } catch (e) {
      isLoading.value = false;
      Get.snackbar("Error", e.toString(),
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 5));
    }
  }
}
