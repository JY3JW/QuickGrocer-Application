import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_helper_utils/flutter_helper_utils.dart';
import 'package:quickgrocer_application/src/constants/app_constant.dart';
import 'package:quickgrocer_application/src/features/core/models/cart_item_model.dart';

class OrderModel {
  static const ID = "id";
  static const CART = "cart";
  static const EMAIL = "buyerEmail";
  static const DATETIME = "dateTime";
  static const TOTALPRICE = "totalPrice";
  static const REMARK = "remarks";
  static const STATUS = "status";

  String id;
  List<CartItemModel> cart;
  String email;
  DateTime? dateTime;
  double totalPrice;
  String remarks;
  String status; //accepted, preparing, ready, completed

  OrderModel(
      {required this.id,
      required this.cart,
      required this.email,
      this.dateTime,
      required this.totalPrice,
      required this.remarks,
      required this.status});

  static List<CartItemModel> _convertCartItems(List cartFromDb) {
    List<CartItemModel> _result = [];
    logger.i(cartFromDb.length);
    cartFromDb.forEach((element) {
      _result.add(CartItemModel.fromSnapshot(element));
    });

    return _result;
  }

  String getListedCartItems() {
    String items = '';

    for (int i = 0; i < cart.length; i++) {
      items += (cart[i].quantity.toString() + 'x  ' + cart[i].name + '  RM ' + cart[i].cost.toStringAsFixed(2) + '\n');
    }
    return items;
  }

  factory OrderModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return OrderModel(
        id: data[ID],
        cart: _convertCartItems(data[CART] ?? []),
        email: data[EMAIL],
        dateTime: (data[DATETIME] as Timestamp).toDate(),
        totalPrice: toDouble(data[TOTALPRICE]),
        remarks: data[REMARK],
        status: data[STATUS]);
  }

  toJson() {
    return {
      ID: id,
      CART: cart.map((e) => e.toJson()).toList(),
      EMAIL: email,
      DATETIME: FieldValue.serverTimestamp(),
      TOTALPRICE: totalPrice,
      REMARK: remarks,
      STATUS: status
    };
  }
}
