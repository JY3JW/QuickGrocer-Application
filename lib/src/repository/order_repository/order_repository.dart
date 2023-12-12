import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickgrocer_application/src/features/core/models/order_model.dart';

class OrderRepository extends GetxController {
  static OrderRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  createOrder(OrderModel order) async {
    await _db
        .collection("orders")
        .doc(order.id)
        .set(order.toJson())
        .whenComplete(() => {})
        .catchError((error, stackTrace) {
      Get.snackbar("Error", "Something went wrong. Try again",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent.withOpacity(0.1),
          colorText: Colors.red);
      print(error.toString());
    });
  }

  // Fetch order details
  Future<OrderModel> getOrderDetailsByOrderId(String orderId) async {
    var snapshot =
        await _db.collection("orders").where("id", isEqualTo: orderId).get();
    final orderData =
        snapshot.docs.map((e) => OrderModel.fromSnapshot(e)).single;
    return orderData;
  }

  Future<List<OrderModel>> getAllBuyerOrdersBySingleBuyer() async {
    var snapshot = await _db
        .collection("orders")
        .orderBy('date time', descending: true)
        .where("buyer email",
            isEqualTo: FirebaseAuth.instance.currentUser?.email)
        .get();
    final orderData =
        snapshot.docs.map((e) => OrderModel.fromSnapshot(e)).toList();
    return orderData;
  }

  Future<List<OrderModel>> getAllBuyersOrders() async {
    var snapshot = await _db
        .collection("orders")
        .orderBy('date time', descending: true)
        .get();
    final orderData =
        snapshot.docs.map((e) => OrderModel.fromSnapshot(e)).toList();
    return orderData;
  }

  Future<void> updateOrderStatus(String orderId, Map<String, dynamic> data) async {
    await _db.collection("orders").doc(orderId).update(data);
  }
}
