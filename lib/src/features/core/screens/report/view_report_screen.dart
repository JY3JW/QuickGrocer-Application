import 'package:flutter/material.dart';
import 'package:quickgrocer_application/src/constants/text_strings.dart';

class ViewReportScreen extends StatefulWidget {
  const ViewReportScreen({super.key});

  @override
  State<ViewReportScreen> createState() => _ViewReportScreenState();
}

class _ViewReportScreenState extends State<ViewReportScreen> {
  String? selectedValue;
  List <String> reportList = <String> ['Sales Report', 'Stocks Report'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            report,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          backgroundColor: Colors.transparent,
          elevation: 0),
      body: Container(
          padding: EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, 
            children: [
              Icon(Icons.picture_as_pdf_rounded),
              Text('Generate Report'),

              SizedBox(height: 50),
              DropdownButtonFormField<String>(
                hint: const Text(' ' + report),
                value: selectedValue,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a report to be generated';
                  }
                  return null;
                },
                isExpanded: true,
                borderRadius: BorderRadius.circular(16),
                items: reportList.map((String value) {
                return DropdownMenuItem<String>(
                  value: value, child: Text(value));
                }).toList(),
                onChanged: (value) async {
                  setState(() {
                    selectedValue = value!;
                  });}
              ),
              

          ])),
    );
  }
}
