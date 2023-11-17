import 'package:get/get.dart';
import 'package:quickgrocer_application/src/features/core/models/category_model.dart';
import 'package:quickgrocer_application/src/repository/category_repository/category_repository.dart';

class CategoryController extends GetxController {
  static CategoryController get instance => Get.find();

  final _catRepo = Get.put(CategoryRepository());

  // Fetch List of Categories
  Future<List<CategoryModel>> getAllCategories() async => await _catRepo.allCategories();
}
