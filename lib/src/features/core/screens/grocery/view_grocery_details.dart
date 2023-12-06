import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:quickgrocer_application/src/constants/colors.dart';
import 'package:quickgrocer_application/src/constants/text_strings.dart';
import 'package:quickgrocer_application/src/features/core/controllers/cart_controller.dart';
import 'package:quickgrocer_application/src/features/core/models/grocery_model.dart';

class ViewGroceryDetailsScreen extends StatefulWidget {
  final GroceryModel grocery;
  const ViewGroceryDetailsScreen({super.key, required this.grocery,});

  @override
  State<ViewGroceryDetailsScreen> createState() => _ViewGroceryDetailsScreenState();
}

class _ViewGroceryDetailsScreenState extends State<ViewGroceryDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    var iconColorWithoutBackground = Get.isDarkMode ? Colors.white : Colors.black;
    var detailsBackground = Get.isDarkMode ? AppColors.greyColor4 : AppColors.greyColor1;
    final controller = Get.put(CartController());

    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () => Get.back(),
              icon: Icon(LineAwesomeIcons.angle_left, color: iconColorWithoutBackground)),
          title: Text(
            viewGroceryDetailsTitle,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          backgroundColor: Colors.transparent, elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 36),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 220,
                    height: 220,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.greyColor2,
                    ),
                    child: Image.network(widget.grocery.imageUrl, fit: BoxFit.cover),
                  ),
                ],
              ),
              const SizedBox(height: 36),
              Container(
                padding: const EdgeInsets.all(20),
                width: double.infinity,
                height: 400,
                decoration: BoxDecoration(
                  color: detailsBackground,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width*4/7,
                          child: Text(
                            textAlign: TextAlign.left,
                            widget.grocery.name.toUpperCase(),
                            style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                          ),),
                          SizedBox(
                            width: MediaQuery.of(context).size.width*2/7,
                            child: Text(
                              '\RM' '${widget.grocery.price.toStringAsFixed(2)}',
                              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold,),
                              textAlign: TextAlign.right
                            ),
                          ),
                      ],),
                    const SizedBox(height: 14,),
                    Text(
                      widget.grocery.description,
                      textAlign: TextAlign.justify,
                      style: const TextStyle(fontSize: 14),
                    ),
                    const SizedBox(height: 14,),
                    Text(
                      quantityInStock,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 14,),
                    Text(
                      widget.grocery.quantity.toString(),
                      style: const TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      bottomSheet: BottomAppBar(
        height: MediaQuery.of(context).size.height/12,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          alignment: Alignment.center,
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '\RM' '${widget.grocery.price.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              ElevatedButton.icon(
                onPressed: widget.grocery.quantity == 0? () => {} :() => controller.addProductToCart(widget.grocery),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.all(10),
                  backgroundColor: widget.grocery.quantity == 0? Colors.grey : AppColors.mainPineColor,
                  side:  widget.grocery.quantity == 0? BorderSide(color: Colors.grey) : BorderSide(color: AppColors.mainPineColor),
                  foregroundColor: Colors.white,
                ),
                icon: widget.grocery.quantity == 0? Icon(Icons.remove_shopping_cart_rounded) : Icon(Icons.add_shopping_cart_rounded),
                label: widget.grocery.quantity == 0? Text(outOfStock) : Text(addToCart)
              ),
            ]
          ),
        ),
      ),
    );
  }
}