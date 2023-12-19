import 'package:flutter/material.dart';
import 'package:quickgrocer_application/src/constants/text_strings.dart';

class SalesReportScreen extends StatefulWidget {
  const SalesReportScreen({super.key});

  @override
  State<SalesReportScreen> createState() => _SalesReportScreenState();
}

class _SalesReportScreenState extends State<SalesReportScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            salesReport,
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
                  storeId,
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                Text(
                  salesReportID,
                  style: Theme.of(context).textTheme.labelMedium,
                )
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  storeName,
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                Text(
                  salesReportType,
                  style: Theme.of(context).textTheme.labelMedium,
                )
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  storeAddress,
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                Text(
                  salesReportDate,
                  style: Theme.of(context).textTheme.labelMedium,
                )
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  salesGeneratedDate,
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
                  child: Text(
                    salesReport,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    )
                  ),
                ),
              ],
            )
          ],
        ),
      )
    );
  }
}