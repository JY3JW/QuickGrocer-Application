import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickgrocer_application/src/constants/text_strings.dart';
import 'package:quickgrocer_application/src/features/core/screens/order/order_card.dart';
import 'package:quickgrocer_application/src/features/core/screens/order/order_card_buyer.dart';

class ManageOrderScreen extends StatefulWidget {
  const ManageOrderScreen({super.key});
  
  @override
  State<ManageOrderScreen> createState() => _ManageOrderScreenState();
}

class _ManageOrderScreenState extends State<ManageOrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          manageOrder,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: ListView(
        children: [
          OrderCardBuyer(),
          OrderCard(),
          OrderCard(),
          OrderCard(),
          OrderCard(),
        ],
      ),
      );

  }
}