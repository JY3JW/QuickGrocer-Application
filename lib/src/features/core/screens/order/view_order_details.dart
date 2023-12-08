import 'package:flutter/material.dart';
import 'package:quickgrocer_application/src/constants/colors.dart';
import 'package:quickgrocer_application/src/constants/text_strings.dart';
//import 'package:quickgrocer_application/src/features/core/controllers/order_controller.dart';
//import 'package:quickgrocer_application/src/features/core/models/order_item_model.dart';
//import 'package:quickgrocer_application/src/features/core/models/order_model.dart';

class ViewOrderDetailsScreen extends StatefulWidget {
  const ViewOrderDetailsScreen ({super.key,});

  @override
  State<ViewOrderDetailsScreen> createState() => _ViewOrderDetailsScreenState();
}

class _ViewOrderDetailsScreenState extends State<ViewOrderDetailsScreen> {
  //late List<OrderItemModel> orderItems;

  @override
  Widget build(BuildContext context) {
    //late orderModel order;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          viewOrderDetailsTitle,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 36),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  orderID,
                  style: const TextStyle(
                    fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Text(
                  orderDate,
                  style: const TextStyle(
                    fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 36),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.greyColor1,
                borderRadius: BorderRadius.circular(40)
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 1/7,
                        child: Text(
                          //order item quantity
                          "2x",
                          textAlign: TextAlign.left,
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 3/7,
                        child: Text(
                          //order item name
                          "order item",
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 2/7,
                        child: Text(
                          //order item price
                          "RM 0.00",
                          textAlign: TextAlign.right,
                        ),
                )]),
              ]),
            ),]
        ),),
        bottomSheet: BottomAppBar(
          height: MediaQuery.of(context).size.height / 12,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            alignment: Alignment.center,
            width: double.infinity,
            child:
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween, 
                children: [
                  Text(
                    //'\RM' '${widget.grocery.price.toStringAsFixed(2)}',
                    totalPrice,
                    style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  ElevatedButton(
                    onPressed: () => {},
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      backgroundColor: AppColors.mainPineColor,
                      shape: StadiumBorder()
                    ), 
                    child: Text('Rate'),
                  )
                ])
          )),
    );
  }
}
