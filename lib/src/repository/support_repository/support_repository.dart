import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:quickgrocer_application/src/features/core/models/support_model.dart';

class SupportRepository extends GetxController {
  static SupportRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  // Fetch all support details
  Future<List<SupportModel>> getSupportInfo() async {
   final snapshot = await _db.collection("supports").orderBy('mode').get();
    final supportData =
        snapshot.docs.map((e) => SupportModel.fromSnapshot(e)).toList();
    return supportData;
  }
}
