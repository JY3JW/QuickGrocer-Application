import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_helper_utils/flutter_helper_utils.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:quickgrocer_application/src/constants/colors.dart';
import 'package:quickgrocer_application/src/constants/sizes.dart';
import 'package:quickgrocer_application/src/constants/text_strings.dart';
import 'package:quickgrocer_application/src/features/core/controllers/grocery_controller.dart';
import 'package:quickgrocer_application/src/features/core/models/grocery_model.dart';
import 'package:quickgrocer_application/src/repository/grocery_repository/grocery_repository.dart';

class UpdateGroceryScreen extends StatefulWidget {
  final GroceryModel grocery;

  const UpdateGroceryScreen({super.key, required this.grocery});

  @override
  State<UpdateGroceryScreen> createState() => _UpdateGroceryScreenState();
}

class _UpdateGroceryScreenState extends State<UpdateGroceryScreen> {
  @override
  Widget build(BuildContext context) {
    var iconColorWithoutBackground =
        Get.isDarkMode ? Colors.white : Colors.black;
    final controller = Get.put(GroceryController());

    final _formKey = GlobalKey<FormState>();

    final id = widget.grocery.id;
    final name = TextEditingController(text: widget.grocery.name);
    final imageUrl = TextEditingController(text: widget.grocery.imageUrl);
    final description = TextEditingController(text: widget.grocery.description);
    final category = TextEditingController(text: widget.grocery.category);
    final price =
        TextEditingController(text: widget.grocery.price.toStringAsFixed(2));
    final quantity =
        TextEditingController(text: widget.grocery.quantity.toString());

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () => Get.back(),
              icon: Icon(LineAwesomeIcons.angle_left,
                  color: iconColorWithoutBackground)),
          title: Text(
            updateGroceryDetailsTitle,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(defaultSize),
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 220,
                    height: 220,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.greyColor2,
                    ),
                    child: Image.network(widget.grocery.imageUrl,
                        fit: BoxFit.cover),
                  ),
                ],
              ),
              const SizedBox(height: 36),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: name,
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
                      controller: description,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the description';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        label: Text(groceryDescription),
                        prefixIcon: Icon(
                          Icons.details_rounded,
                        ),
                      ),
                    ),
                    const SizedBox(height: formHeight - 20.0),
                    TextFormField(
                      controller: imageUrl,
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
                    TextFormField(
                      controller: category,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the category';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        label: Text(groceryCategory),
                        prefixIcon: Icon(
                          Icons.category_rounded,
                        ),
                      ),
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
                      controller: price,
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
                      controller: quantity,
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
                                id: id,
                                name: name.text.trim(),
                                description: description.text.trim(),
                                imageUrl: imageUrl.text.trim(),
                                category: category.text.trim(),
                                price: toDouble(price.text.trim()),
                                quantity: toInt(quantity.text.trim()),
                              );
                              
                              await controller.updateGrocery(groceryData);
                            }
                          },
                        child: const Text(updateGroceryButton),
                      )),
                      const SizedBox(width: formHeight),
                      Expanded(
                          child: ElevatedButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                      title: Text('Delete Grocery'),
                                      content: Text(
                                          'Confirm to delete this grocery?'),
                                      actions: [
                                        ElevatedButton(
                                          child: Text('NO'),
                                          onPressed: () =>
                                              Navigator.pop(context),
                                        ),
                                        ElevatedButton(
                                          child: Text('YES'),
                                          onPressed: () => {
                                            setState(() {
                                              GroceryRepository.instance
                                                  .deleteGroceryRecord(
                                                      widget.grocery);
                                            }),
                                            Navigator.pop(context),
                                          },
                                        ),
                                      ]));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          side: BorderSide(color: Colors.red),
                        ),
                        child: const Text(deleteGroceryButton),
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
