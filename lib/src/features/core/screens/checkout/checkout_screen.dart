import 'package:flutter/material.dart';
import 'package:quickgrocer_application/src/constants/colors.dart';
import 'package:quickgrocer_application/src/constants/text_strings.dart';
import 'package:quickgrocer_application/src/features/core/screens/checkout/checkout_card.dart';
import 'package:quickgrocer_application/src/features/core/models/cart_model.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key, required this.cartModel, required this.total});

  final CartModel cartModel;
  final double total;

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          placeOrder,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        child: Padding(
            padding: const EdgeInsets.all(15.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                orderSummary,
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
              SizedBox(
                height: 400,
                child: ListView.builder(
                  itemCount: widget.cartModel.cart.length,
                  itemBuilder: (context, index) {
                    return CheckoutCard(cartItem: widget.cartModel.cart[index]);
                  },
              )),
              SizedBox(
                height: 50,
              ),
              TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Remark...'),
              )
            ])),
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
                      '\RM' '${widget.total.toStringAsFixed(2)}',
                      style: const TextStyle(
                          fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    ElevatedButton.icon(
                      onPressed: () => {},
                      style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          backgroundColor: AppColors.mainPineColor,
                          shape: StadiumBorder()),
                      icon: Icon(Icons.payment_rounded),
                      label: Text('Pay'),
                    )
                  ]))),
    );
  }
}
