import 'package:flutter/material.dart';
import 'package:quickgrocer_application/src/constants/colors.dart';
import 'package:quickgrocer_application/src/constants/text_strings.dart';
import 'package:quickgrocer_application/src/features/core/screens/checkout/checkout_card.dart';
//import 'package:quickgrocer_application/src/features/core/controllers/order_controller.dart';
//import 'package:quickgrocer_application/src/features/core/models/order_item_model.dart';
//import 'package:quickgrocer_application/src/features/core/models/order_model.dart';

class ViewOrderDetailsScreen extends StatefulWidget {
  const ViewOrderDetailsScreen ({super.key,});

  @override
  State<ViewOrderDetailsScreen> createState() => _ViewOrderDetailsScreenState();
}

class _ViewOrderDetailsScreenState extends State<ViewOrderDetailsScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          viewOrderDetailsTitle,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Text(
                orderID,
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
              Text(
                orderDate,
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
              SizedBox(
                height: 400,
                child: ListView(
                  children: [
                    CheckoutCard(),
                    CheckoutCard(),
                    CheckoutCard()
                  ],
                ),
              ) 
            ]
          ),
      )),
      bottomSheet: BottomAppBar(
        height: MediaQuery.of(context).size.height / 12,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          alignment: Alignment.center,
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                //'\RM' '${widget.grocery.price.toStringAsFixed(2)}',
                totalPrice,
                style: const TextStyle(
                fontSize: 22, fontWeight: FontWeight.bold),
              ),
              ElevatedButton.icon(
                onPressed: () => {},
                style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 20),
                backgroundColor: AppColors.mainPineColor,
                shape: StadiumBorder()),
                icon: Icon(Icons.star_rate_rounded),
                label: Text('Rate'),
              )
      ]))),
    );
  }
}
