import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel{
  final String name;
  final String imageUrl;

  const CategoryModel({
    required this.name,
    required this.imageUrl,
  });

  // map user fetched from Firebase to CategoryModel
  factory CategoryModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return CategoryModel(
      name: data["name"],
      imageUrl: data["imageUrl"],
    );
  }
}
