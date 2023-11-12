import 'package:get/get.dart';
import 'package:quickgrocer_application/src/features/core/screens/dashboard/dashboard.dart';
import 'package:quickgrocer_application/src/repository/authentication_repository/authentication_repository.dart';

class OTPController extends GetxController {
  static OTPController get instance => Get.find();

//! "OTPController" not found. You need to call "Get.put(OTPController())" or "Get.lazyPut(()=>OTPController())""

  void verifyOTP(String otp) async {
    var isVerified = await AuthenticationRepository.instance.verifyOTP(otp);
    isVerified ? Get.offAll(const Dashboard()) : Get.back();
  }
}
