import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:quickgrocer_application/src/constants/colors.dart';
import 'package:quickgrocer_application/src/constants/text_strings.dart';
import 'package:quickgrocer_application/src/features/core/screens/checkout/checkout_card.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          placeOrder,
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
                orderSummary,
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
              SizedBox(
                height: 400,
                child: ListView(children: [
                  CheckoutCard(),
                  CheckoutCard(),
                ]),
              ),
              SizedBox(
                height: 50,
              ),
              TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Remark...'),
              )
            ])),
      ),
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
                      icon: Icon(Icons.payment_rounded),
                      label: Text('Pay'),
                    )
                  ]))),
    );
  }
}
