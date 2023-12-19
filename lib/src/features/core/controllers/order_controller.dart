import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickgrocer_application/src/features/core/controllers/cart_controller.dart';
import 'package:quickgrocer_application/src/features/core/models/order_model.dart';
import 'package:quickgrocer_application/src/repository/grocery_repository/grocery_repository.dart';
import 'package:quickgrocer_application/src/repository/order_repository/order_repository.dart';

class OrderController extends GetxController {
  static OrderController get instance => Get.find();

  final _orderRepo = Get.put(OrderRepository());
  final _grocRepo = Get.put(GroceryRepository());

  //TextField Controllers to get data from TextFields
  final remarks = TextEditingController();

  clearControllers() {
    remarks.clear();
  }

  // create new grocery
  createNewOrder(OrderModel order) async {
    try {
      await _orderRepo.createOrder(order);
      for (int i = 0; i < order.cart.length; i++) {
        _grocRepo.updateGroceryStockQuantity(order.cart[i].groceryId, -order.cart[i].quantity);
      }
      CartController.instance.clearItemsInTheCart();
    } catch (e) {
      Get.snackbar("Order Creation Failed", e.toString(),
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 5));
    }
  }

  // Fetch all single order details
  Future<OrderModel> singleOrderDetails(String orderId) async {
    final userData = await _orderRepo.getOrderDetailsByOrderId(orderId);
    return userData;
  }

  // Fetch all single user orders
  Future<List<OrderModel>> singleBuyerOrders() async {
    final userData = await _orderRepo.getAllBuyerOrdersBySingleBuyer();
    return userData;
  }

  Future<List<OrderModel>> singleBuyerOrdersOngoing() async {
    final userData = await _orderRepo.getAllBuyerOrdersBySingleBuyerOngoing('completed');
    return userData;
  }

  Future<List<OrderModel>> singleBuyerOrdersCompleted() async {
    final userData = await _orderRepo.getAllBuyerOrdersBySingleBuyerCompleted('completed');
    return userData;
  }

  // Fetch all user orders
  Future<List<OrderModel>> allBuyersOrders() async {
    final userData = await _orderRepo.getAllBuyersOrders();
    return userData;
  }

  Future<List<OrderModel>> allBuyersOrdersNew() async {
    final userData = await _orderRepo.getAllBuyersOrdersByCategory('accepted');
    return userData;
  }

  Future<List<OrderModel>> allBuyersOrdersPreparing() async {
    final userData = await _orderRepo.getAllBuyersOrdersByCategory('preparing');
    return userData;
  }

  Future<List<OrderModel>> allBuyersOrdersReady() async {
    final userData = await _orderRepo.getAllBuyersOrdersByCategory('ready');
    return userData;
  }

  Future<List<OrderModel>> allBuyersOrdersCompleted() async {
    final userData = await _orderRepo.getAllBuyersOrdersByCategory('completed');
    return userData;
  }

  void setOrderStatusToComplete(String orderId) async {
    await _orderRepo.updateOrderStatus(orderId, {"status": 'completed'});
  }

  void setOrderStatusToReady(String orderId) async {
    await _orderRepo.updateOrderStatus(orderId, {"status": 'ready'});
  }

  void setOrderStatusToPreparing(String orderId) async {
    await _orderRepo.updateOrderStatus(orderId, {"status": 'preparing'});
  }

  void setOrderStatusToAccepted(String orderId) async {
    await _orderRepo.updateOrderStatus(orderId, {"status": 'accepted'});
  }
}
