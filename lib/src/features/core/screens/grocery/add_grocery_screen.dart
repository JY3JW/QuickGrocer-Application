import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_helper_utils/flutter_helper_utils.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:quickgrocer_application/src/constants/sizes.dart';
import 'package:quickgrocer_application/src/constants/text_strings.dart';
import 'package:quickgrocer_application/src/features/core/controllers/grocery_controller.dart';
import 'package:quickgrocer_application/src/features/core/models/grocery_model.dart';

class AddGroceryScreen extends StatefulWidget {
  const AddGroceryScreen({super.key});

  @override
  State<AddGroceryScreen> createState() => _AddGroceryScreenState();
}

class _AddGroceryScreenState extends State<AddGroceryScreen> {
  String? selectedValue;
  List<String> categories = [
    'Food & Drinks',
    'Cleaning & Laundry',
    'Beauty & Personal Care',
    'Study & Necessities',
    'Others'
  ];

  @override
  Widget build(BuildContext context) {
    var iconColorWithoutBackground =
        Get.isDarkMode ? Colors.white : Colors.black;
    final controller = Get.put(GroceryController());
    final _formKey = GlobalKey<FormState>();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () => Get.back(),
              icon: Icon(LineAwesomeIcons.angle_left,
                  color: iconColorWithoutBackground)),
          title: Text(
            addGroceryTitle,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            IconButton(
                onPressed: () {/*scan barcode*/},
                icon: Icon(
                  Icons.qr_code_scanner_rounded,
                  color: iconColorWithoutBackground,
                ))
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(defaultSize),
            child: Column(children: [
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: controller.id,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the grocery id';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        label: Text(groceryId),
                        prefixIcon: Icon(
                          Icons.code_rounded,
                        ),
                      ),
                    ),
                    const SizedBox(height: formHeight - 20.0),
                    TextFormField(
                      controller: controller.name,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the grocery name';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        label: Text(groceryName),
                        prefixIcon: Icon(
                          Icons.local_grocery_store_rounded,
                        ),
                      ),
                    ),
                    const SizedBox(height: formHeight - 20.0),
                    TextFormField(
                      controller: controller.description,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the description';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        label: Text(groceryDescription),
                        hintMaxLines: 10,
                        prefixIcon: Icon(
                          Icons.details_rounded,
                        ),
                      ),
                    ),
                    const SizedBox(height: formHeight - 20.0),
                    TextFormField(
                      controller: controller.imageUrl,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the image URL';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        label: Text(groceryImageUrl),
                        prefixIcon: Icon(
                          Icons.link_rounded,
                        ),
                      ),
                    ),
                    const SizedBox(height: formHeight - 20.0),
                    DropdownButtonFormField<String>(
                          hint: const Text('🛍️   ' + groceryCategory),
                          value: selectedValue,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please select a category';
                            }
                            return null;
                          },
                          isExpanded: true,
                          borderRadius: BorderRadius.circular(16),
                          items: categories.
                          map((String value) {
                            return DropdownMenuItem<String>(
                                value: value, child: Text(value));
                          }).toList(),
                          onChanged: (value) async {
                            setState(() {selectedValue = value!;});
                          },
                    ),
                    const SizedBox(height: formHeight - 20.0),
                    TextFormField(
                      inputFormatters: [
                        FilteringTextInputFormatter.deny(RegExp('[a-zA-Z]')),
                        FilteringTextInputFormatter.allow(RegExp('[0-9.]')),
                      ],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the price';
                        }
                        return null;
                      },
                      controller: controller.price,
                      decoration: InputDecoration(
                        label: Text(groceryPrice),
                        prefixIcon: Icon(
                          Icons.money,
                        ),
                      ),
                    ),
                    const SizedBox(height: formHeight - 20.0),
                    TextFormField(
                      inputFormatters: [
                        FilteringTextInputFormatter.deny(RegExp('[a-zA-Z]')),
                        FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                      ],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the quantity';
                        }
                        return null;
                      },
                      controller: controller.quantity,
                      decoration: InputDecoration(
                        label: Text(groceryQuantity),
                        prefixIcon: Icon(
                          Icons.numbers_rounded,
                        ),
                      ),
                    ),
                    const SizedBox(height: formHeight),
                    Row(children: [
                      Expanded(
                          child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            final groceryData = GroceryModel(
                              id: controller.id.text.trim(),
                              name: controller.name.text.trim(),
                              description: controller.description.text.trim(),
                              imageUrl: controller.imageUrl.text.trim(),
                              category: selectedValue!,
                              price: toDouble(controller.price.text.trim()),
                              quantity: toInt(controller.quantity.text.trim()),
                            );

                            await controller.createNewGrocery(groceryData);
                            Navigator.pop(context);
                          }
                        },
                        child: const Text(addGroceryButton),
                      )),
                    ]),
                  ],
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
