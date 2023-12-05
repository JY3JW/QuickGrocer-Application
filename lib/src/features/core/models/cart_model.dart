import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quickgrocer_application/src/constants/app_constant.dart';
import 'package:quickgrocer_application/src/features/core/models/cart_item_model.dart';

class CartModel {
  static const ID = "id";
  static const CART = "cart";

  String id;
  List<CartItemModel> cart;

  CartModel({required this.id, required this.cart});

  static List<CartItemModel> _convertCartItems(List cartFromDb) {
    List<CartItemModel> _result = [];
    logger.i(cartFromDb.length);
    cartFromDb.forEach((element) {
      _result.add(CartItemModel.fromSnapshot(element));
    });

    return _result;
  }

  factory CartModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return CartModel(
      id: data[ID],
      cart: _convertCartItems(data[CART] ?? []),
    );
  }

  toJson() {
    return {
      ID: id,
      CART: cart,
    };
  }
}
