import 'package:flutter_helper_utils/flutter_helper_utils.dart';

class CartItemModel {
  static const ID = "id";
  static const IMAGE = "image";
  static const NAME = "name";
  static const QUANTITY = "quantity";
  static const COST = "cost";
  static const PRICE = "price";
  static const GROCERY_ID = "groceryId";

  String id;
  String image;
  String name;
  int quantity;
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
      required this.quantity});

  factory CartItemModel.fromSnapshot(
      Map<String, dynamic> document) {
    final data = document;
    return CartItemModel(
      id: data[ID],
      image: data[IMAGE],
      name: data[NAME],
      quantity: data[QUANTITY],
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
      COST: price * quantity,
      PRICE: price,
    };
  }
}
