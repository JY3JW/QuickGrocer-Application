import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:quickgrocer_application/src/features/core/models/category_model.dart';

class CategoryRepository extends GetxController {
  static CategoryRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  // Fetch all grocery details
  Future<List<CategoryModel>> allCategories() async {
    final snapshot = await _db.collection("categories").get();
    final category =
        snapshot.docs.map((e) => CategoryModel.fromSnapshot(e)).toList();
    return category;
  }
}
