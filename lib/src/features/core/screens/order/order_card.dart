import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickgrocer_application/src/constants/colors.dart';
import 'package:quickgrocer_application/src/constants/image_strings.dart';

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
                      Text("Price: \$345", style: TextStyle(fontSize: 16, color: Colors.black)),
                    ],
                  ),
                  Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text("Preparing", style: TextStyle(fontSize: 16, color: Colors.black)),
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
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: AppColors.subDarkerLimeColor,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Details", style: TextStyle(fontSize: 16, color: Colors.black)),
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
