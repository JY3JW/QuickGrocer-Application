import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickgrocer_application/src/constants/colors.dart';
import 'package:quickgrocer_application/src/features/core/models/grocery_model.dart';
import 'package:quickgrocer_application/src/features/core/screens/grocery/view_grocery_details.dart';

class GroceryCardBuyer extends StatefulWidget {
  final GroceryModel grocery;

  const GroceryCardBuyer({super.key, required this.grocery});

  @override
  State<GroceryCardBuyer> createState() => _GroceryCardBuyerState();
}

class _GroceryCardBuyerState extends State<GroceryCardBuyer> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width / 2,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: AppColors.greyColor2,
        ),
        child: Column(
          children: [
            SizedBox(
              height: 130,
              width: 130,
              child: Image.network(widget.grocery.imageUrl, fit: BoxFit.cover),
            ),
            Text(
              widget.grocery.name,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              '\RM' '${widget.grocery.price.toStringAsFixed(2)}',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: AppColors.mainPineColor,
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                  child:
                    IconButton(
                        icon: Icon(Icons.add_shopping_cart, color: Colors.white),
                        onPressed: () => Get.to(() => ViewGroceryDetailsScreen(grocery: widget.grocery)),
                        ),
                ),
              ],
            ),
          ],
        ));
  }
}
