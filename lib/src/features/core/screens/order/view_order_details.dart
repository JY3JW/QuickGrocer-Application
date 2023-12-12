import 'package:flutter/material.dart';
import 'package:quickgrocer_application/src/constants/colors.dart';
import 'package:quickgrocer_application/src/constants/text_strings.dart';
import 'package:quickgrocer_application/src/features/core/screens/checkout/checkout_card.dart';

class ViewOrderDetailsScreen extends StatefulWidget {
  const ViewOrderDetailsScreen ({super.key,});

  @override
  State<ViewOrderDetailsScreen> createState() => _ViewOrderDetailsScreenState();
}

class _ViewOrderDetailsScreenState extends State<ViewOrderDetailsScreen> {

  @override
  Widget build(BuildContext context) {
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
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Text(
                  orderComplete,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
        
                SizedBox(
                  height: 400,
                  child: ListView(
                    children: [
                      CheckoutCard(),
                      CheckoutCard(),
                      CheckoutCard()
                    ],
                  ),
                ),
        
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          orderID,
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                        Text(
                          'OR00000001',
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
                          '12-12-2023 12:12',
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                      ],
                    ),
        
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          paymentTime,
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                        Text(
                          '12-12-2023 12:21',
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                      ],
                    ),
        
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          completeTime,
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                        Text(
                          '13-12-2023 13:12',
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                      ],
                    ),
                  ],
                ),
        
                SizedBox(
                  height: 35,
                ),
        
                Card(
                  margin: EdgeInsets.zero,
                  color: Colors.white,
                  child: SizedBox(
                    width: double.infinity,
                    height: 150,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                          feedback,
                          style: Theme.of(context).textTheme.titleMedium,
                          textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                )
              ]
            ),
        )),
      ),
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
                //'\RM' '${widget.grocery.price.toStringAsFixed(2)}',
                totalPrice,
                style: const TextStyle(
                fontSize: 22, fontWeight: FontWeight.bold),
              )
      ]))),
    );
  }
}
