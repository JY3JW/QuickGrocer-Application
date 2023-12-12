import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:quickgrocer_application/src/constants/colors.dart';
import 'package:quickgrocer_application/src/constants/text_strings.dart';

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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Text(
                orderSummary,
                style: Theme.of(context).textTheme.bodyLarge
              ),

              ListView(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        quantity,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      Column(
                        children: [
                          Text(
                            orderItem,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          Text(
                            price,
                            style: Theme.of(context).textTheme.bodySmall,
                          )
                        ],
                      ),
                      Text(
                        price,
                        style: Theme.of(context).textTheme.bodySmall,
                      )
                    ],
                  )
                ],
              )
            ],
          ),
        )
      )
    );
  }
}