import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:quickgrocer_application/src/constants/colors.dart';
import 'package:quickgrocer_application/src/constants/sizes.dart';
import 'package:quickgrocer_application/src/constants/text_strings.dart';
import 'package:quickgrocer_application/src/features/core/controllers/order_controller.dart';
import 'package:quickgrocer_application/src/features/core/models/order_model.dart';
import 'package:quickgrocer_application/src/features/core/screens/checkout/checkout_card.dart';
import 'package:quickgrocer_application/src/features/core/models/cart_model.dart';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen(
      {super.key, required this.cartModel, required this.total});

  final CartModel cartModel;
  final double total;

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  @override
  Widget build(BuildContext context) {
    var iconColorWithoutBackground =
        Get.isDarkMode ? Colors.white : Colors.black;
    final orderController = Get.put(OrderController());

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: Icon(LineAwesomeIcons.angle_left,
                color: iconColorWithoutBackground)),
        title: Text(
          placeOrder,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: Container(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      orderSummary,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    SizedBox(height: formHeight - 20.0),
                    SizedBox(
                        height: MediaQuery.of(context).size.height * 7.5 / 12,
                        child: ListView.separated(
                          itemCount: widget.cartModel.cart.length,
                          separatorBuilder: (context, index) {
                            return Divider(
                                thickness: 1.0, height: 0, endIndent: 0);
                          },
                          itemBuilder: (context, index) {
                            return CheckoutCard(
                                cartItem: widget.cartModel.cart[index]);
                          },
                        )),
                    SizedBox(
                      height: formHeight,
                    ),
                    TextField(
                      controller: orderController.remarks,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(), labelText: 'Remark...'),
                    )
                  ])),
        ),
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
                      '\Total (RM' '${widget.total.toStringAsFixed(2)})',
                      style: const TextStyle(
                          fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    ElevatedButton.icon(
                      onPressed: () async {
                        bool pay = await initPayment(
                            email: FirebaseAuth.instance.currentUser?.email
                                as String,
                            amount: widget.total * 100,
                            country: 'MY',
                            context: context);

                        if (pay) {
                          await orderController.createNewOrder(new OrderModel(
                              id: DateTime.now()
                                  .millisecondsSinceEpoch
                                  .toString(),
                              cart: widget.cartModel.cart,
                              email: FirebaseAuth.instance.currentUser?.email
                                  as String,
                              totalPrice: widget.total,
                              remarks: orderController.remarks.text.trim(),
                              status: 'accepted'));
                          Navigator.pop(context);
                          setState(() {});
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 40),
                          backgroundColor: AppColors.mainPineColor,
                          side: BorderSide(color: AppColors.mainPineColor),
                          foregroundColor: Colors.white,
                          shape: StadiumBorder()),
                      icon: Icon(Icons.payment_rounded),
                      label: Text('Pay'),
                    )
                  ]))),
    );
  }
}

Future<bool> initPayment(
    {required String email,
    required double amount,
    required String country,
    required BuildContext context}) async {
  try {
    final response = await http.post(
        Uri.parse(
            'https://us-central1-appdev-a0da7.cloudfunctions.net/stripePaymentIntentRequest'),
        body: {
          'email': email.toString(),
          'amount': amount.toString(),
        });

    final jsonResponse = jsonDecode(response.body);
    log(jsonResponse.toString());

    final billingAddress = country == 'MY'
        ? Address(
            city: '',
            country: 'MY', // Malaysia country code
            line1: '',
            line2: '',
            postalCode: '',
            state: '')
        : null;

    await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
      paymentIntentClientSecret: jsonResponse['paymentIntent'],
      merchantDisplayName: 'QuickGrocer',
      customerId: jsonResponse['customer'],
      customerEphemeralKeySecret: jsonResponse['ephemeralKey'],
      billingDetails: BillingDetails(
        address: billingAddress,
      ),
      //googlePay: const PaymentSheetGooglePay(
      //  merchantCountryCode: 'MY',
      //  testEnv: true,
      //),
    ));

    await Stripe.instance.presentPaymentSheet();
    Get.snackbar(
      "Payment Success",
      'Order placed, check at Order History',
      backgroundColor: Colors.green.withOpacity(0.1),
      colorText: Colors.green,
    );

    return true;
  } catch (errorr) {
    if (errorr is StripeException) {
      Get.snackbar("Payment Failed",
          'An error occurred ${errorr.error.localizedMessage}');
    } else {
      Get.snackbar("Payment Failed", 'An error occurred $errorr');
    }

    return false;
  }
}
