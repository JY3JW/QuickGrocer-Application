import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:quickgrocer_application/src/constants/text_strings.dart';

class StocksReportScreen extends StatefulWidget {
  const StocksReportScreen({super.key});

  @override
  State<StocksReportScreen> createState() => _StocksReportScreenState();
}

class _StocksReportScreenState extends State<StocksReportScreen> {
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
              stocksReport,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            backgroundColor: Colors.transparent,
            elevation: 0),
        body: Container(
          padding: EdgeInsets.all(32),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    storeName,
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  Text(
                    stocksGeneratedDate,
                    style: Theme.of(context).textTheme.labelMedium,
                  )
                ],
              ),
              const SizedBox(height: 30),
              const Divider(),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 30,
                    child: Text(stocksReport,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        )),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
