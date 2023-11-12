import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickgrocer_application/src/features/authentication/models/user_model.dart';
import 'package:quickgrocer_application/src/repository/authentication_repository/authentication_repository.dart';
import 'package:quickgrocer_application/src/repository/user_repository/user_repository.dart';

class ProfileController extends GetxController {
  static ProfileController get instance => Get.find();

  final _authRepo = Get.put(AuthenticationRepository());
  final _userRepo = Get.put(UserRepository());

  // get user email and pass to UserRepository to fetch user record
  getUserData() {
    final email = _authRepo.firebaseUser.value?.email;
    if (email != null) {
      return _userRepo.getUserDetails(email);
    } else {
      Get.snackbar("Error", "Login to continue");
    }
  }

  // Fetch List of user records
  Future<List<UserModel>> getAllUsers() async => await _userRepo.allUsers();

  updateRecord(UserModel user) async {
    await _userRepo.updateUserRecord(user);
  }
}
