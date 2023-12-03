import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickgrocer_application/src/constants/text_strings.dart';
import 'package:quickgrocer_application/src/features/authentication/models/user_model.dart';
import 'package:quickgrocer_application/src/repository/authentication_repository/authentication_repository.dart';
import 'package:quickgrocer_application/src/repository/user_repository/user_repository.dart';

class ManageUserController extends GetxController {
  static ManageUserController get instance => Get.find();

  final _userRepo = Get.put(UserRepository());

  //TextField Controllers to get data from TextFields
  final fullName = TextEditingController();
  final email = TextEditingController();
  final phoneNumber = TextEditingController();
  final password = TextEditingController();

  //create new user
  Future<String?> registerNewUser(String email, String password) {
    // lead to auto login to newly created user
    // decided to delete admin functions
    return AuthenticationRepository.instance
        .createUserWithEmailAndPassword(email, password);
  }

  Future<void> createNewUser(UserModel user) async {
    try {
      String? userID = await registerNewUser(user.email, user.password);
      await _userRepo.createUser(user, userID);

    } catch (e) {
      Get.snackbar("Error", e.toString(),
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 5));
    }
  }

  Future<List<UserModel>> getAllUsers() async => await _userRepo.allUsers();
  //Future<List<UserModel>> getAllUsersName() async => await _userRepo.allUsersName(fullName);

  updateUserRecord(UserModel user, String? userId) async {
    try {
      await _userRepo.updateUserRecord(user, userId);
    } catch (e) {
      Get.snackbar(ohSnap, e.toString(),
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 5));
    }
  }

  deleteUserRecord(UserModel user) async {
    try {
      //await _userRepo.deleteUserRecord(user);
    } catch (e) {
      Get.snackbar(ohSnap, e.toString(),
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 5));
    }
  }
}
