import 'package:flutter/material.dart';
import 'package:flutter_helper_utils/flutter_helper_utils.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:quickgrocer_application/src/constants/colors.dart';
import 'package:quickgrocer_application/src/constants/sizes.dart';
import 'package:quickgrocer_application/src/constants/text_strings.dart';
import 'package:quickgrocer_application/src/features/core/models/order_model.dart';
import 'package:quickgrocer_application/src/features/core/screens/checkout/checkout_card.dart';
import 'package:quickgrocer_application/src/features/core/screens/feedback/feedback_screen.dart';

class ViewOrderDetailsBuyerScreen extends StatefulWidget {
  const ViewOrderDetailsBuyerScreen({
    super.key,
    required this.order,
  });

  final OrderModel order;

  @override
  State<ViewOrderDetailsBuyerScreen> createState() =>
      _ViewOrderDetailsBuyerScreenState();
}

class _ViewOrderDetailsBuyerScreenState
    extends State<ViewOrderDetailsBuyerScreen> {
  @override
  Widget build(BuildContext context) {
    var iconColorWithoutBackground =
        Get.isDarkMode ? Colors.white : Colors.black;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: Icon(LineAwesomeIcons.angle_left,
                color: iconColorWithoutBackground)),
        title: Text(
          viewOrderDetailsTitle,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(children: [
          Text(
            orderSummary,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          SizedBox(
              height: MediaQuery.of(context).size.height * 5 / 12,
              child: ListView.separated(
                itemCount: widget.order.cart.length,
                separatorBuilder: (context, index) {
                  return Divider(thickness: 1.0, height: 0, endIndent: 0);
                },
                itemBuilder: (context, index) {
                  return CheckoutCard(cartItem: widget.order.cart[index]);
                },
              )),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      totalPrice,
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    Text(
                      '\RM'
                      '${widget.order.totalPrice.toStringAsFixed(2)}',
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      orderID,
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    Text(
                      widget.order.id,
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      orderTime,
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    Text(
                      widget.order.dateTime.toString().substring(0, 19),
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      orderStatus,
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    Text(
                      widget.order.status.toPascalCase,
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Card(
                  margin: EdgeInsets.zero,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          orderRemark,
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                        SizedBox(height: 10.0),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 11 / 12,
                          child: Text(
                            widget.order.remarks != ''
                                ? widget.order.remarks
                                : 'none',
                            style: Theme.of(context).textTheme.bodySmall,
                            textAlign: TextAlign.justify,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                // future builder sprint 4 to fetch feedback if feedback exist then will display
                Card(
                  margin: EdgeInsets.zero,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          feedback,
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                        SizedBox(height: 10.0),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 11 / 12,
                          child: Text(
                            widget.order.remarks != ''
                                ? widget.order.remarks
                                : 'none',
                            style: Theme.of(context).textTheme.bodySmall,
                            textAlign: TextAlign.justify,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 40),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: widget.order.status == 'completed'
                            ? () => {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) => FeedbackScreen()),
                                  )
                                }
                            : () => Get.back(),
                        style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.all(buttonHeight),
                            backgroundColor: AppColors.mainPineColor,
                            side: BorderSide(color: AppColors.mainPineColor),
                            foregroundColor: Colors.white,
                            shape: StadiumBorder()),
                        icon: widget.order.status == 'completed'
                            ? Icon(Icons.star_rate_rounded)
                            : Icon(LineAwesomeIcons.angle_left),
                        label: widget.order.status == 'completed'
                            ? Text('Rate')
                            : Text('Return'),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ]),
      )),
    );
  }
}
