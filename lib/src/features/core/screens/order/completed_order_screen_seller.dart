import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickgrocer_application/src/features/core/controllers/order_controller.dart';
import 'package:quickgrocer_application/src/features/core/models/order_model.dart';
import 'package:quickgrocer_application/src/features/core/screens/order/order_card.dart';

class CompletedOrderScreenSeller extends StatefulWidget {
  const CompletedOrderScreenSeller({super.key});

  @override
  State<CompletedOrderScreenSeller> createState() =>
      _CompletedOrderScreenSellerState();
}

class _CompletedOrderScreenSellerState extends State<CompletedOrderScreenSeller> {
  @override
  Widget build(BuildContext context) {
    final orderController = Get.put(OrderController());

    return Scaffold(
        body: RefreshIndicator(
      onRefresh: () async {
        setState(() {});
        await Future.delayed(const Duration(seconds: 1));
      },
      child: Container(
        margin: const EdgeInsets.all(10),
        child: Column(
          children: [
            Container(
              child: FutureBuilder(
                  future: orderController.allBuyersOrdersCompleted(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasData) {
                        List<OrderModel> orders =
                            snapshot.data as List<OrderModel>;
                        return Expanded(
                            child: ListView.builder(
                              itemCount: orders.length,
                              itemBuilder: (context, index) {
                                print(orders.length);
                                return OrderCard(order: orders[index]);
                              },
                            ));
                      } else if (snapshot.hasError) {
                        return Center(child: Text(snapshot.error.toString()));
                      } else {
                        return const Center(
                            child: Text("Something went wrong"));
                      }
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  }),
            ),
          ],
        ),
      ),
    ));
  }
}
