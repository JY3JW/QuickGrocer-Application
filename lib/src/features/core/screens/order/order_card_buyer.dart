import 'package:flutter/material.dart';
import 'package:flutter_helper_utils/flutter_helper_utils.dart';
import 'package:quickgrocer_application/src/constants/colors.dart';
import 'package:quickgrocer_application/src/constants/image_strings.dart';
import 'package:quickgrocer_application/src/features/core/models/order_model.dart';
import 'package:quickgrocer_application/src/features/core/screens/order/view_order_details_buyer.dart';

class OrderCardBuyer extends StatefulWidget {
  const OrderCardBuyer({super.key, required this.order});

  final OrderModel order;

  @override
  State<OrderCardBuyer> createState() => _OrderCardBuyerState();
}

class _OrderCardBuyerState extends State<OrderCardBuyer> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
              builder: (context) => ViewOrderDetailsBuyerScreen(
                    order: widget.order,
                  )),
        );
      },
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
                      Text(widget.order.id,
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.w500)),
                      const SizedBox(height: 5),
                      Text(
                          "Total: \RM ${widget.order.totalPrice.toStringAsFixed(2)}",
                          style: TextStyle(fontSize: 16, color: Colors.black)),
                      const SizedBox(height: 5),
                      Text(widget.order.dateTime.toString().substring(0, 19),
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w500)),
                      const SizedBox(height: 10),
                      Text(widget.order.status.toPascalCase,
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.w400)),
                    ],
                  ),
                  Container(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => ViewOrderDetailsBuyerScreen(
                                  order: widget.order)),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        backgroundColor: AppColors.subDarkerLimeColor,
                        side: BorderSide(color: AppColors.subDarkerLimeColor),
                        foregroundColor: Colors.white,
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
      ),
    );
  }
}
