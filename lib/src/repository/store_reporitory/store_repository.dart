import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickgrocer_application/src/constants/text_strings.dart';
import 'package:quickgrocer_application/src/features/core/models/store_model.dart';

class StoreRepository extends GetxController {
  static StoreRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  createStore() async {
    await _db
        .collection("store")
        .doc(storeId)
        .set({"status": true, "id": storeId})
        .whenComplete(() => {})
        .catchError((error, stackTrace) {
          Get.snackbar("Error", "Something went wrong. Try again",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.redAccent.withOpacity(0.1),
              colorText: Colors.red);
          print(error.toString());
        });
  }

  // Fetch all grocery details
  Future<StoreModel> getStoreInfo() async {
    final storeData;
    var snapshot =
        await _db.collection("store").where("id", isEqualTo: storeId).get();
    if (snapshot.isBlank == false) {
      storeData = snapshot.docs.map((e) => StoreModel.fromSnapshot(e)).single;
    } else {
      await createStore();
      snapshot =
          await _db.collection("store").where("id", isEqualTo: storeId).get();
      storeData = snapshot.docs.map((e) => StoreModel.fromSnapshot(e)).single;
    }
    return storeData;
  }

  Future<void> updateStoreInfo(Map<String, dynamic> data) async {
    await _db.collection("store").doc(storeId).update(data);
  }
}
