import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_helper_utils/flutter_helper_utils.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
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

  late String _scanBarcodeResult = "";
  String imageUrl = "";

  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      debugPrint(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
    setState(() {
      _scanBarcodeResult = barcodeScanRes;
    });
  }

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
      imageUrl = await referenceImageToUpload.getDownloadURL();
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
    final id = TextEditingController(text: _scanBarcodeResult);
    final url = TextEditingController(text: imageUrl);

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
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(defaultSize),
            child: Column(children: [
              SizedBox(
                width: 150,
                height: 150,
                child: OutlinedButton(
                    onPressed: scanBarcodeNormal,
                    child: Image.network(
                        'https://static.vecteezy.com/system/resources/previews/014/720/616/original/scan-bar-code-label-icon-barcode-tag-scanner-pictogram-product-information-identification-sign-digital-scanning-technology-isolated-illustration-vector.jpg')),
              ),
              SizedBox(height: 20),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: id,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the grocery id or scan the barcode';
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
                      controller: url,
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
                      value: selectedValue,
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
                              id: id.text.trim(),
                              name: controller.name.text.trim(),
                              description: controller.description.text.trim(),
                              imageUrl: url.text.trim(),
                              category: selectedValue!,
                              price: toDouble(controller.price.text.trim()),
                              quantity: toInt(controller.quantity.text.trim()),
                            );

                            await controller.createNewGrocery(groceryData);
                            Navigator.pop(context);
                            setState(() {});
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
