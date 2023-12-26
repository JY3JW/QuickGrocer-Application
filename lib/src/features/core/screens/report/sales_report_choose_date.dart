import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:quickgrocer_application/src/constants/sizes.dart';
import 'package:quickgrocer_application/src/constants/text_strings.dart';
import 'package:quickgrocer_application/src/features/core/controllers/order_controller.dart';
import 'package:quickgrocer_application/src/features/core/models/order_model.dart';
import 'package:quickgrocer_application/src/features/core/models/sales_report_model.dart';
import 'package:quickgrocer_application/src/features/core/screens/report/pdf_api.dart';
import 'package:quickgrocer_application/src/features/core/screens/report/pdf_salesreport_api.dart';

class SalesReportChooseDateScreen extends StatefulWidget {
  const SalesReportChooseDateScreen({super.key});

  @override
  State<SalesReportChooseDateScreen> createState() =>
      _SalesReportChooseDateScreenState();
}

class _SalesReportChooseDateScreenState
    extends State<SalesReportChooseDateScreen> {
  DateTime? startDate = DateTime.now();
  DateTime? endDate = DateTime.now();
  String selectedValue = sortByDateAsc;
  List<String> dropdownOptions = [sortByDateAsc, sortByDateDec];

  @override
  Widget build(BuildContext context) {
    var iconColorWithoutBackground =
        Get.isDarkMode ? Colors.white : Colors.black;
    final orderController = Get.put(OrderController());
    final _formKey = GlobalKey<FormState>();
    TextEditingController start =
        TextEditingController(text: startDate.toString().substring(0, 10));
    TextEditingController end =
        TextEditingController(text: endDate.toString().substring(0, 10));

    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
              onPressed: () => Get.back(),
              icon: Icon(LineAwesomeIcons.angle_left,
                  color: iconColorWithoutBackground)),
          title: Text(
            salesReport,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          backgroundColor: Colors.transparent,
          elevation: 0),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please choose the start duration';
                          } else if (startDate!.isAfter(endDate!) == true) {
                            return 'Start duration must be earlier than end duration';
                          }
                          return null;
                        },
                        controller: start,
                        decoration: InputDecoration(
                            labelText: "Start Duration",
                            prefixIcon: Icon(Icons.date_range_outlined)),
                        onTap: () async {
                          var date = await showDatePicker(
                              context: context,
                              initialDate: startDate,
                              firstDate: DateTime(2023, 01, 01),
                              lastDate: DateTime(2033, 01, 01));

                          if (date != null) {
                            setState(() {
                              startDate = date;
                            });
                          }
                        },
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please choose the end duration';
                          } else if (startDate!.isAfter(endDate!) == true) {
                            return 'Start duration must be earlier than end duration';
                          }
                          return null;
                        },
                        controller: end,
                        decoration: InputDecoration(
                            labelText: "End Duration",
                            prefixIcon: Icon(Icons.date_range_outlined)),
                        onTap: () async {
                          var date = await showDatePicker(
                              context: context,
                              initialDate: endDate,
                              firstDate: DateTime(2023, 01, 01),
                              lastDate: DateTime(2033, 01, 01));

                          if (date != null) {
                            setState(() {
                              endDate = date;
                            });
                          }
                        },
                      ),
                      SizedBox(height: 10),
                      DropdownButtonFormField<String>(
                        value: selectedValue,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select a sorting option';
                          }
                          return null;
                        },
                        isExpanded: true,
                        borderRadius: BorderRadius.circular(16),
                        items: dropdownOptions.map((String value) {
                          return DropdownMenuItem<String>(
                              value: value, child: Text(value));
                        }).toList(),
                        onChanged: (value) async {
                          setState(() {
                            selectedValue = value!;
                          });
                        },
                      ),
                    ],
                  )),
              SizedBox(
                height: formHeight,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      List<OrderModel> order = (selectedValue == sortByDateAsc
                          ? await orderController.getAllOrderBetweenDurationAsc(
                              startDate!, endDate!)
                          : await orderController.getAllOrderBetweenDuration(
                              startDate!, endDate!));
                      SalesReportModel stockReport = SalesReportModel(
                          reportStartDuration: startDate!,
                          reportEndDuration: endDate!,
                          order: order);
                      final pdfFile =
                          await PdfSalesReportApi.generate(stockReport);

                      PdfApi.openFile(pdfFile);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    shape: StadiumBorder(),
                  ),
                  child: const Text('Generate Report'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
