import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_helper_utils/flutter_helper_utils.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:quickgrocer_application/src/constants/sizes.dart';
import 'package:quickgrocer_application/src/constants/text_strings.dart';
import 'package:quickgrocer_application/src/features/core/controllers/grocery_controller.dart';

class UpdateGroceyStockScreen extends StatefulWidget {
  const UpdateGroceyStockScreen({super.key});

  @override
  State<UpdateGroceyStockScreen> createState() =>
      _UpdateGroceyStockScreenState();
}

class _UpdateGroceyStockScreenState extends State<UpdateGroceyStockScreen> {
  late String _scanBarcodeResult = "";

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

  @override
  Widget build(BuildContext context) {
    var iconColorWithoutBackground =
        Get.isDarkMode ? Colors.white : Colors.black;
    final _formKey = GlobalKey<FormState>();
    final controller = Get.put(GroceryController());
    final id = TextEditingController(text: _scanBarcodeResult);
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
      body: Builder(
          builder: (context) => SingleChildScrollView(
                padding: EdgeInsets.all(defaultSize),
                child: Expanded(
                  child: Flex(
                    direction: Axis.vertical,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
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
                                  return 'Please scan the barcode of the grocery';
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
                                            toInt(quantityOut.text.trim()));
                                    Navigator.pop(context);
                                  }
                                },
                                child: const Text(updateGroceryStockButton),
                              )),
                            ]),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )),
    );
  }
}
