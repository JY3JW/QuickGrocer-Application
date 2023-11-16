import 'package:get/get.dart';
import 'package:quickgrocer_application/src/constants/text_strings.dart';
import 'package:quickgrocer_application/src/features/authentication/models/user_model.dart';
import 'package:quickgrocer_application/src/features/core/screens/admin/manage_user/manage_user_screen.dart';
import 'package:quickgrocer_application/src/repository/authentication_repository/authentication_repository.dart';
import 'package:quickgrocer_application/src/repository/user_repository/user_repository.dart';

class ManageUserController extends GetxController {
  static ManageUserController get instance => Get.find();

  final _authRepo = Get.put(AuthenticationRepository());
  final _userRepo = Get.put(UserRepository());

  getUserData() {
    final email = _authRepo.firebaseUser.value?.email;
    if (email != null) {
      return _userRepo.allUsers();
    } else {
      Get.snackbar(" ", " ");
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
      await _userRepo.deleteUserRecord(user);
    } catch (e) {
      Get.snackbar(ohSnap, e.toString(),
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 5)
      );
    }
  }
}
