import 'package:get/get.dart';
import 'package:quickgrocer_application/src/features/core/models/store_model.dart';
import 'package:quickgrocer_application/src/repository/store_reporitory/store_repository.dart';

class StoreController extends GetxController {
  static StoreController instance = Get.find();
  final _storeRepo = Get.put(StoreRepository());

  void setStoreClose() async {
    await _storeRepo.updateStoreInfo({
      "status": false
    });
  }

  void setStoreOpen() async {
    await _storeRepo.updateStoreInfo({
      "status": true
    });
  }

  Future<StoreModel> getStoreData() async {
    return await _storeRepo.getStoreInfo();
  }
}
