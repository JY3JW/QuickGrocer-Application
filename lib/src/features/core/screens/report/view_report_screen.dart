import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:quickgrocer_application/src/constants/sizes.dart';
import 'package:quickgrocer_application/src/constants/text_strings.dart';
import 'package:quickgrocer_application/src/features/core/screens/report/sales_report_screen.dart';
import 'package:quickgrocer_application/src/features/core/screens/report/stocks_report_screen.dart';

class ViewReportScreen extends StatefulWidget {
  const ViewReportScreen({super.key});

  @override
  State<ViewReportScreen> createState() => _ViewReportScreenState();
}

class _ViewReportScreenState extends State<ViewReportScreen> {
  String? selectedValue;
  List<String> reportList = <String>['Sales Report', 'Stocks Report'];

  @override
  Widget build(BuildContext context) {
    var iconColorWithoutBackground =
        Get.isDarkMode ? Colors.white : Colors.black;

    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
              onPressed: () => Get.back(),
              icon: Icon(LineAwesomeIcons.angle_left,
                  color: iconColorWithoutBackground)),
          title: Text(
            report,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          backgroundColor: Colors.transparent,
          elevation: 0),
      body: Center(
        child: Container(
            padding: EdgeInsets.all(32),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(
                Icons.picture_as_pdf_rounded,
                size: 50,
              ),
              SizedBox(
                height: 10,
              ),
              Text('Generate Report',
                  style: Theme.of(context).textTheme.titleMedium),
              SizedBox(height: 50),
              SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Get.to(() => SalesReportScreen()),
                    child: Text(reportList[0]),
                  )),
              SizedBox(
                height: formHeight,
              ),
              SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Get.to(() => StocksReportScreen()),
                    child: Text(reportList[1]),
                  )),
            ])),
      ),
    );
  }
}
