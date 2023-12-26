import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickgrocer_application/src/features/core/models/grocery_model.dart';

class GroceryRepository extends GetxController {
  static GroceryRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  createGrocery(GroceryModel grocery) async {
    await _db
        .collection("groceries")
        .doc(grocery.id)
        .set(grocery.toJson())
        .whenComplete(
          () => Get.snackbar("Success", "New grocery has been added.",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.green.withOpacity(0.1),
              colorText: Colors.green,
              duration: const Duration(seconds: 5)),
        )
        .catchError((error, stackTrace) {
      Get.snackbar("Error", "Something went wrong. Try again",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent.withOpacity(0.1),
          colorText: Colors.red);
      print(error.toString());
    });
  }

  // Fetch single grocery details
  Future<GroceryModel> getGroceryDetails(String id) async {
    final snapshot =
        await _db.collection("groceries").where("id", isEqualTo: id).get();
    final groceryData =
        snapshot.docs.map((e) => GroceryModel.fromSnapshot(e)).single;
    return groceryData;
  }

  // Fetch all grocery details
  Future<List<GroceryModel>> allGroceries() async {
    final snapshot = await _db.collection("groceries").orderBy('name').get();
    final groceryData =
        snapshot.docs.map((e) => GroceryModel.fromSnapshot(e)).toList();
    return groceryData;
  }

  // Fetch all grocery details
  Future<List<GroceryModel>> allGroceriesReport() async {
    final snapshot = await _db.collection("groceries").get();
    final groceryData =
        snapshot.docs.map((e) => GroceryModel.fromSnapshot(e)).toList();
    return groceryData;
  }

  // Fetch all grocery of the chosen category
  Future<List<GroceryModel>> categoryGroceries(String category) async {
    final snapshot = await _db.collection("groceries").orderBy('name').get();
    final groceryData =
        snapshot.docs.map((e) => GroceryModel.fromSnapshot(e)).toList();
    final groceryDataOfCategory = <GroceryModel>[
      for (int i = 0; i < groceryData.length; i++)
        if (groceryData[i].category == category)
          GroceryModel(
              id: groceryData[i].id,
              name: groceryData[i].name,
              category: groceryData[i].category,
              imageUrl: groceryData[i].imageUrl,
              description: groceryData[i].description,
              price: groceryData[i].price,
              quantity: groceryData[i].quantity)
    ];
    return groceryDataOfCategory;
  }

  Future<void> updateGroceryRecord(GroceryModel grocery) async {
    await _db.collection("groceries").doc(grocery.id).update(grocery.toJson());
  }

  // used by stock counting using barcode scanner
  Future<void> updateGroceryStockQuantity(String id, int quantity) async {
    await _db.collection("groceries").doc(id).update({
      'quantity': FieldValue.increment(quantity),
    });
  }

  Future<void> deleteGroceryRecord(GroceryModel grocery) async {
    await _db.collection("groceries").doc(grocery.id).delete();
  }
}
