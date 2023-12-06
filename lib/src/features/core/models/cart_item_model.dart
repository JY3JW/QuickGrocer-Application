import 'package:flutter_helper_utils/flutter_helper_utils.dart';

class CartItemModel {
  static const ID = "id";
  static const IMAGE = "image";
  static const NAME = "name";
  static const QUANTITY = "quantity";
  static const DESCRIPTION = "description";
  static const CATEGORY = "category";
  static const COST = "cost";
  static const PRICE = "price";
  static const GROCERY_ID = "groceryId";

  String id;
  String image;
  String name;
  int quantity;
  String description;
  String category;
  double cost;
  String groceryId;
  double price;

  CartItemModel(
      {required this.groceryId,
      required this.id,
      required this.image,
      required this.name,
      required this.cost,
      required this.price,
      required this.quantity,
      required this.description,
      required this.category});

  factory CartItemModel.fromSnapshot(Map<String, dynamic> document) {
    final data = document;
    return CartItemModel(
      id: data[ID],
      image: data[IMAGE],
      name: data[NAME],
      quantity: toInt(data[QUANTITY]),
      description: data[DESCRIPTION],
      category: data[CATEGORY],
      cost: toDouble(data[COST]),
      groceryId: data[GROCERY_ID],
      price: toDouble(data[PRICE]),
    );
  }

  toJson() {
    return {
      ID: id,
      GROCERY_ID: groceryId,
      IMAGE: image,
      NAME: name,
      QUANTITY: quantity,
      DESCRIPTION: description,
      CATEGORY: category,
      COST: price * quantity,
      PRICE: price,
    };
  }
}
