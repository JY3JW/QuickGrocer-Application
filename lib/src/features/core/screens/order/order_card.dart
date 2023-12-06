import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickgrocer_application/src/constants/colors.dart';
import 'package:quickgrocer_application/src/constants/image_strings.dart';
import 'package:quickgrocer_application/src/features/core/screens/order/view_order_details.dart';
import 'package:quickgrocer_application/src/features/core/screens/shopping_cart/shopping_cart_screen.dart';

class OrderCard extends StatefulWidget {
  const OrderCard({Key? key}) : super(key: key);
  @override
  State<OrderCard> createState() => _OrderCardState();
}
class _OrderCardState extends State<OrderCard> {
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
                      Text("OR0000001", style: TextStyle(fontSize: 18, color: Colors.black)),
                      Text("Username", style: TextStyle(fontSize: 16, color: Colors.black)),
                    ],
                  ),
                  Container(
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text("Total: \RM345", style: TextStyle(fontSize: 16, color: Colors.black)),
                      ))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Divider(
                thickness: 2,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Date ${DateTime.now().toString().substring(0, 10)}",
                      style: TextStyle(fontSize: 18, color: Colors.black)),
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
            ),
          ],
        ),
      ),
    );
  }
}
