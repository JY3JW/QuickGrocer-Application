import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickgrocer_application/src/features/core/models/grocery_model.dart';
import 'package:quickgrocer_application/src/repository/grocery_repository/grocery_repository.dart';

class GroceryController extends GetxController {
  static GroceryController get instance => Get.find();

  final _grocRepo = Get.put(GroceryRepository());

  //TextField Controllers to get data from TextFields
  final id = TextEditingController();
  final name = TextEditingController();
  final description = TextEditingController();
  final imageUrl = TextEditingController();
  final category = TextEditingController();
  final price = TextEditingController();
  final quantity = TextEditingController();

  clearControllers() {
    id.clear();
    name.clear();
    description.clear();
    imageUrl.clear();
    category.clear();
    price.clear();
    quantity.clear();
  }

  // create new grocery
  createNewGrocery(GroceryModel grocery) async {
    try {
      await _grocRepo.createGrocery(grocery);
    } catch (e) {
      Get.snackbar("Grocery Creation Failed", e.toString(),
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 5));
    }
  }

  // get grocery id and pass to GroceryRepository to fetch grocery record
  getGroceryData(id) {
    return _grocRepo.getGroceryDetails(id);
  }

  // Fetch all of groceries records
  Future<List<GroceryModel>> getAllGroceries() async =>
      await _grocRepo.allGroceries();

  // Fetch all of groceries by chosen category
  Future<List<GroceryModel>> getGroceriesByCategory(category) async =>
      await _grocRepo.categoryGroceries(category);

  updateGrocery(GroceryModel grocery) async {
    try {
      await _grocRepo.updateGroceryRecord(grocery);
    } catch (e) {
      Get.snackbar("Grocery Update Failed", e.toString(),
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 5));
    }
  }

  // update the stock of grocery
  updateGroceryStock(String id, int quantity) async {
    try {
      await _grocRepo.updateGroceryStockQuantity(id, quantity);
    } catch (e) {
      Get.snackbar("Grocery Stock Update Failed", e.toString(),
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 5));
    }
  }

  deleteGrocery(GroceryModel grocery) async {
    try {
      await _grocRepo.deleteGroceryRecord(grocery);
    } catch (e) {
      Get.snackbar("Grocery Deletion Failed", e.toString(),
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 5));
    }
  }
}
