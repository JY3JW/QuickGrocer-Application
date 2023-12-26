import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickgrocer_application/src/constants/app_constant.dart';
import 'package:quickgrocer_application/src/features/core/controllers/grocery_controller.dart';
import 'package:quickgrocer_application/src/features/core/models/cart_item_model.dart';
import 'package:quickgrocer_application/src/features/core/models/cart_model.dart';
import 'package:quickgrocer_application/src/features/core/models/grocery_model.dart';
import 'package:quickgrocer_application/src/repository/cart_repository/cart_repository.dart';
import 'package:uuid/uuid.dart';

class CartController extends GetxController {
  static CartController instance = Get.find();
  final _cartRepo = Get.put(CartRepository());
  int maxQuantity = 0;
  double totalPrice = 0.0;

  void addProductToCart(GroceryModel grocery) async {
    try {
      bool groceryIsInCart = await _isItemAlreadyAdded(grocery);
      if (groceryIsInCart == true) {
        CartItemModel itemInCart = await getAddedItem(grocery);
        if (await checkQuantity(itemInCart) == true) {
          increaseQuantity(itemInCart);
          Get.snackbar(
            "Check your cart",
            "${grocery.name} is already added",
            backgroundColor: Colors.green.withOpacity(0.1),
            colorText: Colors.green,
          );
        } else {
          Get.snackbar("Invalid Operation",
              "Quantity to purchase cannot exceed the quantity of item in stock");
        }
      } else {
        String itemId = Uuid().v4();
        await _cartRepo.updateCartData({
          "cart": FieldValue.arrayUnion([
            {
              "id": itemId,
              "groceryId": grocery.id,
              "name": grocery.name,
              "quantity": 1,
              "price": grocery.price,
              "image": grocery.imageUrl,
              "description": grocery.description,
              "category": grocery.category,
              "cost": grocery.price,
            }
          ])
        });
        Get.snackbar(
          "Item added",
          "${grocery.name} was added to your cart",
          backgroundColor: Colors.green.withOpacity(0.1),
          colorText: Colors.green,
        );
      }
    } catch (e) {
      Get.snackbar("Error", "Cannot add this item");
      debugPrint(e.toString());
    }
  }

  void clearItemsInTheCart() async {
    await _cartRepo.updateCartData({"cart": []});
  }

  void removeCartItem(CartItemModel cartItem) async {
    try {
      await _cartRepo.updateCartData({
        "cart": FieldValue.arrayRemove([cartItem.toJson()])
      });
    } catch (e) {
      Get.snackbar("Error", "Cannot remove this item");
      debugPrint(e.toString());
    }
  }

  // calculate the newest total price of items in cart
  double changeCartTotalPrice(CartModel cartModel) {
    totalPrice = 0.0;

    if (cartModel.cart.isNotEmpty) {
      cartModel.cart.forEach((cartItem) {
        totalPrice += cartItem.cost;
      });
    }

    return totalPrice;
  }

  Future<bool> _isItemAlreadyAdded(GroceryModel grocery) async {
    CartModel? cartModel = await CartController.instance.getCartData();
    if (cartModel.cart.length > 0) {
      for (int i = 0; i < cartModel.cart.length; i++) {
        if (cartModel.cart[i].groceryId == grocery.id) {
          return true;
        }
      }
    }
    return false;
  }

  Future<CartItemModel> getAddedItem(GroceryModel grocery) async {
    CartModel? cartModel = await CartController.instance.getCartData();
    if (cartModel.cart.length > 0) {
      for (int i = 0; i < cartModel.cart.length; i++) {
        if (cartModel.cart[i].groceryId == grocery.id) {
          return cartModel.cart[i];
        }
      }
    }
    return CartModel(id: "", cart: []) as Future<CartItemModel>;
  }

  void decreaseQuantity(CartItemModel item) async {
    if (item.quantity == 1) {
      removeCartItem(item);
    } else {
      removeCartItem(item);
      item.quantity--;
      await _cartRepo.updateCartData({
        "cart": FieldValue.arrayUnion([item.toJson()])
      });
    }
  }

  Future<bool> checkQuantity(CartItemModel item) async {
    GroceryModel groc =
        await GroceryController.instance.getGroceryData(item.groceryId);
    if ((item.quantity + 1) <= groc.quantity) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> itemOutOfStock(CartItemModel item) async {
    GroceryModel groc =
        await GroceryController.instance.getGroceryData(item.groceryId);
    if (groc.quantity == 0) {
      return true;
    } else {
      return false;
    }
  }

  void increaseQuantity(CartItemModel item) async {
    removeCartItem(item);
    item.quantity++;
    logger.i({"quantity": item.quantity});
    await _cartRepo.updateCartData({
      "cart": FieldValue.arrayUnion([item.toJson()])
    });
  }

  Future<CartModel> getCartData() async {
    CartModel cartModel = await _cartRepo.getCartDetails();
    return cartModel;
  }

  Future<void> removeOutOfStockData() async {
    CartModel cartModel = await getCartData();
    for (int i = 0; i < cartModel.cart.length; i++) {
      if (await itemOutOfStock(cartModel.cart[i]) == true) {
        removeCartItem(cartModel.cart[i]);
      } else if (await checkQuantity(cartModel.cart[i]) == false) {
        removeCartItem(cartModel.cart[i]);
        Future.delayed(const Duration(milliseconds: 250));
        GroceryModel groc = await GroceryController.instance
            .getGroceryData(cartModel.cart[i].groceryId);
        while (cartModel.cart[i].quantity > groc.quantity) {
          cartModel.cart[i].quantity--;
        }
        logger.i({"quantity": cartModel.cart[i].quantity});
        await _cartRepo.updateCartData({
          "cart": FieldValue.arrayUnion([cartModel.cart[i].toJson()])
        });
      }
    }
  }
}
