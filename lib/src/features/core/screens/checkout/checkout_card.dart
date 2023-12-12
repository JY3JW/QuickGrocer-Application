import 'package:flutter/material.dart';
import 'package:quickgrocer_application/src/constants/text_strings.dart';

class CheckoutCard extends StatefulWidget {
  const CheckoutCard({super.key});

  @override
  State<CheckoutCard> createState() => _CheckoutCardState();
}

class _CheckoutCardState extends State<CheckoutCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
       padding: const EdgeInsets.all(1.5),
       child: Container(
                  child: Card(
                    margin: EdgeInsets.zero,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 50,
                          child: Text(
                            quantity,
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
                                orderItem,
                                style: Theme.of(context).textTheme.bodySmall,
                                textAlign: TextAlign.left,
                              ),
                              Text(
                                price,
                                style: Theme.of(context).textTheme.bodySmall,
                                textAlign: TextAlign.left,
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 80,
                          child: Text(
                            price,
                            style: Theme.of(context).textTheme.bodySmall,
                            textAlign: TextAlign.left,
                          ),
                        )
                      ],
                    )
                ),
              ]
            )
    )
    )
    );
  }
}