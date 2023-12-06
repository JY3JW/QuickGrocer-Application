import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:quickgrocer_application/src/constants/sizes.dart';
import 'package:quickgrocer_application/src/constants/text_strings.dart';
import 'package:quickgrocer_application/src/features/core/screens/grocery/update_grocery_stock_screen.dart';

class BarcodeScanningScreen extends StatefulWidget {
  const BarcodeScanningScreen({super.key});

  @override
  State<BarcodeScanningScreen> createState() => _BarcodeScanningScreenState();
}

class _BarcodeScanningScreenState extends State<BarcodeScanningScreen> {
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
    final id = TextEditingController(text: _scanBarcodeResult);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: Icon(LineAwesomeIcons.angle_left,
                color: iconColorWithoutBackground)),
        title: Text(
          scanBarcodeTitle,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Builder(
          builder: (context) => SingleChildScrollView(
                padding: EdgeInsets.all(defaultSize),
                child: Container(
                  child: Column(
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
                            const SizedBox(height: formHeight),
                            Row(children: [
                              Expanded(
                                  child: ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    Get.to(() => UpdateGroceyStockScreen(
                                        groceryId: id.text.trim()));
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  shape: StadiumBorder(),
                                ),
                                child: const Text(next),
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
