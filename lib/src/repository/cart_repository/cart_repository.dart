import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickgrocer_application/src/features/core/models/cart_model.dart';

class CartRepository extends GetxController {
  static CartRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  createCart(CartModel cart) async {
    await _db
        .collection("carts")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set(cart.toJson())
        .whenComplete(() => {})
        .catchError((error, stackTrace) {
      Get.snackbar("Error", "Something went wrong. Try again",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent.withOpacity(0.1),
          colorText: Colors.red);
      print(error.toString());
    });
  }

  // Fetch cart details
  Future<CartModel> getCartDetails() async {
    var snapshot =
        await _db.collection("carts").where("id", isEqualTo: FirebaseAuth.instance.currentUser?.uid).get();
    final cartData = snapshot.docs.map((e) => CartModel.fromSnapshot(e)).single;
    return cartData;
  }

  Future<void> updateCartData(Map<String, dynamic> data) async {
    await _db
        .collection("carts")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .update(data);
  }
}
