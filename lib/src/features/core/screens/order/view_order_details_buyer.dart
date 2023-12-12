import 'package:flutter/material.dart';
import 'package:flutter_helper_utils/flutter_helper_utils.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:quickgrocer_application/src/constants/colors.dart';
import 'package:quickgrocer_application/src/constants/text_strings.dart';
import 'package:quickgrocer_application/src/features/core/models/order_model.dart';
import 'package:quickgrocer_application/src/features/core/screens/checkout/checkout_card.dart';

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
      body: Container(
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
                  return Divider(thickness: 1.0);
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
                      widget.order.dateTime.toString(),
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
              ],
            ),
          ),
        ]),
      )),
      bottomSheet: BottomAppBar(
          height: MediaQuery.of(context).size.height / 12,
          child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              alignment: Alignment.center,
              width: double.infinity,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      totalPrice +
                          '\RM' '${widget.order.totalPrice.toStringAsFixed(2)}',
                      style: const TextStyle(
                          fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    ElevatedButton.icon(
                      onPressed: () => {},
                      style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          backgroundColor: AppColors.mainPineColor,
                          side: BorderSide(color: AppColors.mainPineColor),
                          foregroundColor: Colors.white,
                          shape: StadiumBorder()),
                      icon: Icon(Icons.star_rate_rounded),
                      label: Text('Rate'),
                    )
                  ]))),
    );
  }
}
