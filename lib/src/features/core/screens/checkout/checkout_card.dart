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
    return SizedBox(
      height: 57.5,
      child: ListTile(
        visualDensity: VisualDensity(vertical: -4),
        leading: Text(
          widget.cartItem.quantity.toString() + 'x',
          style: Theme.of(context).textTheme.bodyMedium,
          textAlign: TextAlign.left,
        ),
        title: Text(
          widget.cartItem.name,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          '\RM'
          '${widget.cartItem.price.toStringAsFixed(2)}',
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        trailing: Text(
          '\RM' '${widget.cartItem.cost.toStringAsFixed(2)}',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
    );
  }
}
