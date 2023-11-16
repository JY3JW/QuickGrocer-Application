import 'package:cloud_firestore/cloud_firestore.dart';

class GroceryModel {
  final String id;
  final String name;
  final String category;
  final String imageUrl;
  final String description;
  final double price;
  final int quantity;

  const GroceryModel({
    required this.id,
    required this.name,
    required this.category,
    required this.imageUrl,
    required this.description,
    required this.price,
    required this.quantity
  });

  toJson() {
    return {
      "id": id,
      "name": name,
      "category": category,
      "imageUrl": imageUrl,
      "description": description,
      "price": price,
      "quantity": quantity,
    };
  }

  // map user fetched from Firebase to GroceryModel
  factory GroceryModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return GroceryModel(
      id: document.id,
      name: data["name"],
      category: data["category"],
      imageUrl: data["imageUrl"],
      description: data["description"],
      price: data["price"],
      quantity: data["quantity"],
    );
  }
}
