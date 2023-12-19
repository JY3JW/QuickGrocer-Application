import 'package:flutter/material.dart';
import 'package:flutter_helper_utils/flutter_helper_utils.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:quickgrocer_application/src/constants/text_strings.dart';
import 'package:quickgrocer_application/src/features/core/controllers/order_controller.dart';
import 'package:quickgrocer_application/src/features/core/models/feedback_model.dart';
import 'package:quickgrocer_application/src/features/core/models/order_model.dart';
import 'package:quickgrocer_application/src/features/core/screens/checkout/checkout_card.dart';

class ViewFeedbackDetailsScreen extends StatefulWidget {
  const ViewFeedbackDetailsScreen({
    super.key,
    required this.feedbackModel,
  });

  final FeedbackModel feedbackModel;

  @override
  State<ViewFeedbackDetailsScreen> createState() =>
      _ViewFeedbackDetailsScreenState();
}

class _ViewFeedbackDetailsScreenState extends State<ViewFeedbackDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    var iconColorWithoutBackground =
        Get.isDarkMode ? Colors.white : Colors.black;
    final controller = Get.put(OrderController());

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: Icon(LineAwesomeIcons.angle_left,
                color: iconColorWithoutBackground)),
        title: Text(
          feedbackDetails,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Card(
                margin: EdgeInsets.zero,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            feedbackId,
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                          Text(
                            widget.feedbackModel.id,
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            feedbackTime,
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                          Text(
                            widget.feedbackModel.dateTime
                                .toString()
                                .substring(0, 19),
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            feedbackCategory,
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                          Text(
                            widget.feedbackModel.category,
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            feedbackDescription,
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                          SizedBox(height: 10.0),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 11 / 12,
                            child: Text(
                              widget.feedbackModel.description,
                              style: Theme.of(context).textTheme.labelLarge,
                              textAlign: TextAlign.justify,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Card(
                child: FutureBuilder(
                    future: controller
                        .singleOrderDetails(widget.feedbackModel.orderId),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasData) {
                          OrderModel order = snapshot.data as OrderModel;
                          return Column(children: [
                            Text(
                              orderSummary,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 5 / 12,
                                child: ListView.separated(
                                  itemCount: order.cart.length,
                                  separatorBuilder: (context, index) {
                                    return Divider(
                                        thickness: 1.0, height: 0, endIndent: 0);
                                  },
                                  itemBuilder: (context, index) {
                                    return CheckoutCard(
                                        cartItem: order.cart[index]);
                                  },
                                )),
                            Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          totalPrice,
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelLarge,
                                        ),
                                        Text(
                                          '\RM'
                                          '${order.totalPrice.toStringAsFixed(2)}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelLarge,
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 20),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          orderID,
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelLarge,
                                        ),
                                        Text(
                                          order.id,
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelLarge,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          orderTime,
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelLarge,
                                        ),
                                        Text(
                                          order.dateTime
                                              .toString()
                                              .substring(0, 19),
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelLarge,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          orderBuyerEmail,
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelLarge,
                                        ),
                                        Text(
                                          order.email,
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelLarge,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          orderStatus,
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelLarge,
                                        ),
                                        Text(
                                          order.status.toPascalCase,
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelLarge,
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 20),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          orderRemark,
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelLarge,
                                        ),
                                        SizedBox(height: 10.0),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              11 /
                                              12,
                                          child: Text(
                                            order.remarks != ''
                                                ? order.remarks
                                                : 'none',
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelLarge,
                                            textAlign: TextAlign.justify,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ))
                          ]);
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
      ),
    );
  }
}
