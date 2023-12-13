import 'package:flutter/material.dart';
import 'package:quickgrocer_application/src/constants/text_strings.dart';
import 'package:quickgrocer_application/src/features/core/screens/order/completed_order_screen_seller.dart';
import 'package:quickgrocer_application/src/features/core/screens/order/new_order_screen_seller.dart';
import 'package:quickgrocer_application/src/features/core/screens/order/preparing_order_screen_seller.dart';
import 'package:quickgrocer_application/src/features/core/screens/order/ready_order_screen_seller.dart';

class ManageOrderScreen extends StatefulWidget {
  const ManageOrderScreen({super.key});

  @override
  State<ManageOrderScreen> createState() => _ManageOrderScreenState();
}

class _ManageOrderScreenState extends State<ManageOrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add_alert_outlined, color: Colors.red),
                  ],
                )),
                Tab(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.cached, color: Colors.amber),
                  ],
                )),
                Tab(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.shopping_basket_outlined, color: Colors.green),
                  ],
                )),
                Tab(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.done, color: Colors.blue),
                  ],
                )),
              ],
            ),
            title: const Text(manageOrderTitle),
          ),
          body: const TabBarView(
            children: [
              NewOrderScreenSeller(),
              PreparingOrderScreenSeller(),
              ReadyOrderScreenSeller(),
              CompletedOrderScreenSeller(),
            ],
          ),
        ),
      ),
    );
  }
}
