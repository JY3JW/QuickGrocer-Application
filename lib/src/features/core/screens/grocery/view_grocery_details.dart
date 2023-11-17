import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:quickgrocer_application/src/constants/colors.dart';
import 'package:quickgrocer_application/src/constants/sizes.dart';
import 'package:quickgrocer_application/src/constants/text_strings.dart';
import 'package:quickgrocer_application/src/features/core/models/grocery_model.dart';

class ViewGroceryDetailsScreen extends StatelessWidget {
  final GroceryModel grocery;
  const ViewGroceryDetailsScreen({super.key, required this.grocery,});

  @override
  Widget build(BuildContext context) {
    var iconColorWithoutBackground = Get.isDarkMode ? Colors.white : Colors.black;
    var detailsBackground = Get.isDarkMode ? AppColors.greyColor4 : AppColors.greyColor1;

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
                    child: Image.network(grocery.imageUrl, fit: BoxFit.cover),
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
                            grocery.name.toUpperCase(),
                            style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                          ),),
                          SizedBox(
                            width: MediaQuery.of(context).size.width*2/7,
                            child: Text(
                              '\RM' '${grocery.price.toStringAsFixed(2)}',
                              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold,),
                              textAlign: TextAlign.right
                            ),
                          ),
                      ],),
                    const SizedBox(height: 14,),
                    Text(
                      grocery.description,
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
                      grocery.quantity.toString(),
                      style: const TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      bottomSheet: BottomAppBar(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          alignment: Alignment.center,
          width: double.infinity,
          height: MediaQuery.of(context).size.height/11,
          decoration: const BoxDecoration(
            color: AppColors.mainPineColor,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10),),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '\RM' '${grocery.price.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 34, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              ElevatedButton.icon(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: buttonHeight),
                ),
                icon: const Icon(Icons.add_shopping_cart_rounded),
                label: const Text(addToCart)
              ),
            ]
          ),
        ),
      ),
    );
  }
}