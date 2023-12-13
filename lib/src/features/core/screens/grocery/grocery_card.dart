import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickgrocer_application/src/constants/colors.dart';
import 'package:quickgrocer_application/src/features/core/models/grocery_model.dart';
import 'package:quickgrocer_application/src/features/core/screens/grocery/update_grocery_screen.dart';

class GroceryCard extends StatefulWidget {
  final GroceryModel grocery;

  const GroceryCard({super.key, required this.grocery});

  @override
  State<GroceryCard> createState() => _GroceryCardState();
}

class _GroceryCardState extends State<GroceryCard> {
  @override
  Widget build(BuildContext context) {
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
                    decoration: const BoxDecoration(
                      color: AppColors.mainPineColor,
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                    ),
                    child: IconButton(
                        icon: Icon(Icons.edit_square, color: Colors.white),
                        onPressed: () => Get.to(() => UpdateGroceryScreen(grocery: widget.grocery)),
                        ),
                  ),
                  const SizedBox(width: 5),
                ],
              ),
            ],
          )),
    );
  }
}
