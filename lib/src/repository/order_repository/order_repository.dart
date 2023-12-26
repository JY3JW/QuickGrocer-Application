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
    List<OrderModel> allOrderData = await getAllBuyersOrders();
    List<OrderModel> orderData = allOrderData
        .where((item) => item.email == FirebaseAuth.instance.currentUser?.email)
        .toList();
    return orderData;
  }

  Future<List<OrderModel>> getAllBuyerOrdersBySingleBuyerOngoing(
      String status) async {
    List<OrderModel> allOrderData = await getAllBuyerOrdersBySingleBuyer();
    List<OrderModel> orderData =
        allOrderData.where((item) => item.status != (status)).toList();
    return orderData;
  }

  Future<List<OrderModel>> getAllBuyerOrdersBySingleBuyerCompleted(
      String status) async {
    List<OrderModel> allOrderData = await getAllBuyerOrdersBySingleBuyer();
    List<OrderModel> orderData =
        allOrderData.where((item) => item.status == (status)).toList();
    return orderData;
  }

  Future<List<OrderModel>> getAllBuyersOrders() async {
    try {
      final snapshot = await _db
          .collection("orders")
          .orderBy("dateTime", descending: true)
          .get();
      if (snapshot.docs.isEmpty) {
        return []; // Return an empty list if there are no documents
      }

      final orderData =
          snapshot.docs.map((e) => OrderModel.fromSnapshot(e)).toList();
      return orderData;
    } catch (e) {
      print("Error fetching orders: $e");
      return []; // Return an empty list in case of an error
    }
  }

  Future<List<OrderModel>> getAllBuyersOrdersAsc() async {
    try {
      final snapshot = await _db
          .collection("orders")
          .orderBy("dateTime")
          .get();
      if (snapshot.docs.isEmpty) {
        return []; // Return an empty list if there are no documents
      }

      final orderData =
          snapshot.docs.map((e) => OrderModel.fromSnapshot(e)).toList();
      return orderData;
    } catch (e) {
      print("Error fetching orders: $e");
      return []; // Return an empty list in case of an error
    }
  }

  Future<List<OrderModel>> getAllBuyersOrdersByCategory(String status) async {
    List<OrderModel> allOrderData = await getAllBuyersOrders();
    List<OrderModel> orderData =
        allOrderData.where((item) => item.status == (status)).toList();
    return orderData;
  }

  Future<List<OrderModel>> getAllOrdersBetweenDuration(
      DateTime start, DateTime end) async {
    List<OrderModel> allOrderData = await getAllBuyersOrders();
    start = start.subtract(Duration(days: 1));
    end = end.add(Duration(days: 1));
    List<OrderModel> orderData = allOrderData
        .where((item) =>
            (item.dateTime!.isAfter(start) && item.dateTime!.isBefore(end)))
        .toList();
    return orderData;
  }

  Future<List<OrderModel>> getAllOrdersBetweenDurationAsc(
      DateTime start, DateTime end) async {
    List<OrderModel> allOrderData = await getAllBuyersOrdersAsc();
    start = start.subtract(Duration(days: 1));
    end = end.add(Duration(days: 1));
    List<OrderModel> orderData = allOrderData
        .where((item) =>
            (item.dateTime!.isAfter(start) && item.dateTime!.isBefore(end)))
        .toList();
    return orderData;
  }

  Future<void> updateOrderStatus(
      String orderId, Map<String, dynamic> data) async {
    await _db.collection("orders").doc(orderId).update(data);
  }
}
