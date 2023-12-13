import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickgrocer_application/src/constants/colors.dart';
import 'package:quickgrocer_application/src/features/core/controllers/cart_controller.dart';
import 'package:quickgrocer_application/src/features/core/models/grocery_model.dart';

class GroceryCardBuyer extends StatefulWidget {
  final GroceryModel grocery;

  const GroceryCardBuyer({super.key, required this.grocery});

  @override
  State<GroceryCardBuyer> createState() => _GroceryCardBuyerState();
}

class _GroceryCardBuyerState extends State<GroceryCardBuyer> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CartController());

    return Card(
      color: Colors.white,
      child: Container(
          width: MediaQuery.of(context).size.width / 2,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              SizedBox(
                height: 120,
                width: 120,
                child: Image.network(widget.grocery.imageUrl, fit: BoxFit.cover),
              ),
              Text(
                widget.grocery.name,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
              ),
              Text(
                '\RM' '${widget.grocery.price.toStringAsFixed(2)}',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: widget.grocery.quantity == 0? Colors.grey : AppColors.mainPineColor,
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                    ),
                    child:
                      IconButton(
                          icon: widget.grocery.quantity == 0? Icon(Icons.remove_shopping_cart, color: Colors.white) : Icon(Icons.add_shopping_cart, color: Colors.white),
                          onPressed: widget.grocery.quantity == 0? () => {} : () => controller.addProductToCart(widget.grocery),
                          ),
                  ),
                ],
              ),
            ],
          )),
    );
  }
}
