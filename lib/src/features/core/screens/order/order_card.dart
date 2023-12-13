import 'package:flutter/material.dart';
import 'package:flutter_helper_utils/flutter_helper_utils.dart';
import 'package:get/get.dart';
import 'package:quickgrocer_application/src/constants/colors.dart';
import 'package:quickgrocer_application/src/constants/image_strings.dart';
import 'package:quickgrocer_application/src/features/core/controllers/order_controller.dart';
import 'package:quickgrocer_application/src/features/core/models/order_model.dart';
import 'package:quickgrocer_application/src/features/core/screens/order/view_order_details.dart';

class OrderCard extends StatefulWidget {
  const OrderCard({super.key, required this.order});

  final OrderModel order;
  @override
  State<OrderCard> createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  @override
  Widget build(BuildContext context) {
    final orderController = Get.put(OrderController());

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
              builder: (context) => ViewOrderDetailsScreen(
                    order: widget.order,
                  )),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          color: Colors.white,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image(
                      image: AssetImage(orderImage),
                      width: 60,
                      height: 60,
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
                            style:
                                TextStyle(fontSize: 16, color: Colors.black)),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                    title: Text('Order Status'),
                                    content: Text('Change order status to'),
                                    actions: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: ElevatedButton(
                                              child: Text('ACCEPTED'),
                                              onPressed: () async {
                                                orderController
                                                    .setOrderStatusToAccepted(
                                                        widget.order.id);
                                                Navigator.pop(context);
                                              },
                                            ),
                                          ),
                                          SizedBox(width: 10),
                                          Expanded(
                                            child: ElevatedButton(
                                              child: Text('PREPARING'),
                                              onPressed: () async {
                                                orderController
                                                    .setOrderStatusToPreparing(
                                                        widget.order.id);
                                                Navigator.pop(context);
                                              },
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: ElevatedButton(
                                              child: Text('READY'),
                                              onPressed: () async {
                                                orderController
                                                    .setOrderStatusToReady(
                                                        widget.order.id);
                                                Navigator.pop(context);
                                              },
                                            ),
                                          ),
                                          SizedBox(width: 10),
                                          Expanded(
                                            child: ElevatedButton(
                                              child: Text('COMPLETED'),
                                              onPressed: () async {
                                                orderController
                                                    .setOrderStatusToComplete(
                                                        widget.order.id);
                                                Navigator.pop(context);
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ]));
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        backgroundColor: AppColors.subDarkerLimeColor,
                        side: BorderSide(color: AppColors.subDarkerLimeColor),
                        foregroundColor: Colors.white,
                        shape: StadiumBorder(),
                      ),
                      child: Text(widget.order.status.toPascalCase),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Divider(
                  thickness: 2,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(widget.order.dateTime.toString().substring(0, 19),
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w500)),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => ViewOrderDetailsScreen(
                                    order: widget.order,
                                  )),
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
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
