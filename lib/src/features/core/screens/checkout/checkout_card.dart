import 'package:flutter/material.dart';
import 'package:quickgrocer_application/src/features/core/models/cart_item_model.dart';

class CheckoutCard extends StatefulWidget {
  const CheckoutCard({super.key, required this.cartItem});

  final CartItemModel cartItem;

  @override
  State<CheckoutCard> createState() => _CheckoutCardState();
}

class _CheckoutCardState extends State<CheckoutCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      color: Colors.white,
      child: Padding(
          padding: const EdgeInsets.all(1.5),
          child: Container(
              child: Column(children: [
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 50,
                      child: Text(
                        widget.cartItem.quantity.toString(),
                        style: Theme.of(context).textTheme.bodySmall,
                        textAlign: TextAlign.left,
                      ),
                    ),
                    SizedBox(
                      width: 200,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.cartItem.name,
                            style: Theme.of(context).textTheme.bodySmall,
                            textAlign: TextAlign.left,
                          ),
                          Text(
                            '\RM' '${widget.cartItem.price.toStringAsFixed(2)}',
                            style: Theme.of(context).textTheme.bodySmall,
                            textAlign: TextAlign.left,
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 80,
                      child: Text(
                        '\RM' '${widget.cartItem.cost.toStringAsFixed(2)}',
                        style: Theme.of(context).textTheme.bodySmall,
                        textAlign: TextAlign.left,
                      ),
                    )
                  ],
                )),
          ]))),
    );
  }
}
