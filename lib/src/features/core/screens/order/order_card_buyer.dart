import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickgrocer_application/src/constants/colors.dart';
import 'package:quickgrocer_application/src/constants/image_strings.dart';
import 'package:quickgrocer_application/src/features/core/screens/order/view_order_details.dart';

class OrderCardBuyer extends StatefulWidget {
  const OrderCardBuyer({Key? key}) : super(key: key);

  @override
  State<OrderCardBuyer> createState() => _OrderCardBuyerState();
}

class _OrderCardBuyerState extends State<OrderCardBuyer> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(12.0),
        child: Card(
          color: Colors.white,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image(
                      image: AssetImage(orderImage),
                      width: 80,
                      height: 80,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("OR0000001",
                            style:
                                TextStyle(fontSize: 18, color: Colors.black)),
                        Text("Total: \RM345",
                            style:
                                TextStyle(fontSize: 16, color: Colors.black)),
                      ],
                    ),
                    Container(
                        child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => ViewOrderDetailsScreen()),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              backgroundColor: AppColors.subDarkerLimeColor,
                              shape: StadiumBorder(),
                            ),
                            child: const Text("Details"),
                        ),
                        ))
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
