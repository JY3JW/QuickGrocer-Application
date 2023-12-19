import 'package:get/get.dart';
import 'package:quickgrocer_application/src/features/core/models/support_model.dart';
import 'package:quickgrocer_application/src/repository/support_repository/support_repository.dart';

class SupportController extends GetxController {
  static SupportController get instance => Get.find();

  final _supportRepo = Get.put(SupportRepository());

  // Fetch List of Categories
  Future<List<SupportModel>> getAllSupportInfo() async => await _supportRepo.getSupportInfo();
}
