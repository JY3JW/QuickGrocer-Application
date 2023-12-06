import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_helper_utils/flutter_helper_utils.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:quickgrocer_application/src/constants/sizes.dart';
import 'package:quickgrocer_application/src/constants/text_strings.dart';
import 'package:quickgrocer_application/src/features/core/controllers/grocery_controller.dart';
import 'package:quickgrocer_application/src/features/core/models/grocery_model.dart';

class UpdateGroceyStockScreen extends StatefulWidget {
  const UpdateGroceyStockScreen({super.key, required this.groceryId});

  final String groceryId;

  @override
  State<UpdateGroceyStockScreen> createState() =>
      _UpdateGroceyStockScreenState();
}

class _UpdateGroceyStockScreenState extends State<UpdateGroceyStockScreen> {
  @override
  Widget build(BuildContext context) {
    var iconColorWithoutBackground =
        Get.isDarkMode ? Colors.white : Colors.black;
    final _formKey = GlobalKey<FormState>();
    final controller = Get.put(GroceryController());
    final quantityIn = TextEditingController(text: '0');
    final quantityOut = TextEditingController(text: '0');

    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () => Get.back(),
              icon: Icon(LineAwesomeIcons.angle_left,
                  color: iconColorWithoutBackground)),
          title: Text(
            updateGroceryStockTitle,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(defaultSize),
          child: Container(
              child: FutureBuilder(
                  future: controller.getGroceryData(widget.groceryId),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasData) {
                        GroceryModel grocery = snapshot.data as GroceryModel;
                        final id =
                            TextEditingController(text: widget.groceryId);
                        final name = TextEditingController(text: grocery.name);
                        final image = grocery.imageUrl;
                        final quantity = TextEditingController(
                            text: grocery.quantity.toString());
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                                width: 150,
                                height: 150,
                                child: Image.network(image)),
                            SizedBox(height: 20),
                            Form(
                              key: _formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextFormField(
                                    controller: id,
                                    enabled: false,
                                    decoration: const InputDecoration(
                                      label: Text(groceryId),
                                      prefixIcon: Icon(
                                        Icons.shopping_cart,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: formHeight - 10.0),
                                  TextFormField(
                                    controller: name,
                                    enabled: false,
                                    decoration: const InputDecoration(
                                      label: Text(groceryName),
                                      prefixIcon: Icon(
                                        Icons.local_grocery_store_rounded,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: formHeight - 10.0),
                                  TextFormField(
                                    controller: quantity,
                                    enabled: false,
                                    decoration: const InputDecoration(
                                      label: Text(groceryQuantity),
                                      prefixIcon: Icon(
                                        Icons.numbers_rounded,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: formHeight - 10.0),
                                  TextFormField(
                                    controller: quantityIn,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(
                                          RegExp('[0-9.]')),
                                    ],
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter the stock in quantity';
                                      }
                                      return null;
                                    },
                                    decoration: const InputDecoration(
                                      label: Text(stockInQuantity),
                                      prefixIcon: Icon(
                                        LineAwesomeIcons.plus,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: formHeight - 10.0),
                                  TextFormField(
                                    controller: quantityOut,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(
                                          RegExp('[0-9.]')),
                                    ],
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter the stock out quantity';
                                      }
                                      return null;
                                    },
                                    decoration: const InputDecoration(
                                      label: Text(stockOutQuantity),
                                      hintMaxLines: 10,
                                      prefixIcon: Icon(
                                        LineAwesomeIcons.minus,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: formHeight),
                                  Row(children: [
                                    Expanded(
                                        child: ElevatedButton(
                                      onPressed: () async {
                                        if (_formKey.currentState!.validate()) {
                                          await controller.updateGroceryStock(
                                              id.text.trim(),
                                              toInt(quantityIn.text.trim()) -
                                                  toInt(
                                                      quantityOut.text.trim()));
                                          Navigator.pop(context);
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                        shape: StadiumBorder(),
                                      ),
                                      child:
                                          const Text(updateGroceryStockButton),
                                    )),
                                  ]),
                                ],
                              ),
                            )
                          ],
                        );
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text("Grocery Does Not Exists"),
                        );
                      } else {
                        return Center(child: Text("Something went wrong"));
                      }
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  })),
        ));
  }
}
