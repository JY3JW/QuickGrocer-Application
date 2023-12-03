import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_helper_utils/flutter_helper_utils.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
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
  String? selectedValue;
  String image = "";
  List<String> categories = [
    'Food & Drinks',
    'Cleaning & Laundry',
    'Beauty & Personal Care',
    'Study & Necessities',
    'Others'
  ];

  Future<void> getImageFromGallery() async {
    //1. pick image
    XFile? pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedImage == null) return;

    String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();

    //2. upload to firebase storage
    // get a reference to storage root
    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirImages = referenceRoot.child('images');
    // create a reference for the image to be stored
    Reference referenceImageToUpload = referenceDirImages.child(uniqueFileName);

    // !!! very important, need to set the metadata for putFile function. else, the file will not have data type
    final metadata = SettableMetadata(
        contentType: 'image/jpeg',
        customMetadata: {'picked-file-path': pickedImage.path});

    // handle errors/success
    try {
      // store the file
      await referenceImageToUpload.putFile(File(pickedImage.path), metadata);
      // success: get the download url
      image = await referenceImageToUpload.getDownloadURL();
    } catch (error) {
      // error occured
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var iconColorWithoutBackground =
        Get.isDarkMode ? Colors.white : Colors.black;
    final controller = Get.put(GroceryController());

    final _formKey = GlobalKey<FormState>();
    final id = widget.grocery.id;
    final name = TextEditingController(text: widget.grocery.name);
    final imageUrl = TextEditingController(text: widget.grocery.imageUrl);
    final url = TextEditingController(text: image);
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
                        hintMaxLines: 10,
                        prefixIcon: Icon(
                          Icons.details_rounded,
                        ),
                      ),
                    ),
                    const SizedBox(height: formHeight - 20.0),
                    TextFormField(
                      controller: image == '' ? imageUrl : url,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the image URL';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        label: Text(groceryImageUrl),
                        prefixIcon: Icon(
                          Icons.link_rounded,
                        ),
                        suffixIcon: IconButton(
                          onPressed: getImageFromGallery,
                          icon: Icon(
                            LineAwesomeIcons.camera,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: formHeight - 20.0),
                    DropdownButtonFormField<String>(
                      hint: const Text('🛍️   ' + groceryCategory),
                      value: selectedValue.isNotNull
                          ? selectedValue
                          : category.text,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select a category';
                        }
                        return null;
                      },
                      isExpanded: true,
                      borderRadius: BorderRadius.circular(16),
                      items: categories.map((String value) {
                        return DropdownMenuItem<String>(
                            value: value, child: Text(value));
                      }).toList(),
                      onChanged: (value) async {
                        setState(() {
                          selectedValue = value!;
                        });
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
                              imageUrl: image == '' ? imageUrl.text.trim() : url.text.trim(),
                              category: selectedValue.isNotNull
                                  ? selectedValue!
                                  : category.text.trim(),
                              price: toDouble(price.text.trim()),
                              quantity: toInt(quantity.text.trim()),
                            );

                            await controller.updateGrocery(groceryData);
                          }
                          Navigator.pop(context);
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
                                            GroceryRepository.instance
                                                .deleteGroceryRecord(
                                                    widget.grocery),
                                            Navigator.pop(context),
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
