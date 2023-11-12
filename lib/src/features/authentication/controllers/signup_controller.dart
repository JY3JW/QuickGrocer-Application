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

  //Call this Function from Design and it will do the rest
  void registerUser(String email, String password) {
    AuthenticationRepository.instance
        .createUserWithEmailAndPassword(email, password);
  }

  //Get phoneNo from user and pass it to Auth Repository for Firebase Authentication
  void phoneAuthentication(String phone) {
    AuthenticationRepository.instance.phoneAuthentication(phone);
  }

  void createEmailAuthentication(String email, String password) {
    AuthenticationRepository.instance
        .createUserWithEmailAndPassword(email, password);
  }

  Future<void> createUser(UserModel user) async {
    await userRepo.createUser(user);
    phoneAuthentication(user.phoneNo);
    createEmailAuthentication(user.email, user.password);
  }
}
