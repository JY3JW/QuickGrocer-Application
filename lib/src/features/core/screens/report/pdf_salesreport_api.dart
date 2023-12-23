import 'dart:io';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:quickgrocer_application/src/constants/text_strings.dart';
import 'package:quickgrocer_application/src/features/core/models/sales_report_model.dart';
import 'package:quickgrocer_application/src/features/core/screens/report/pdf_api.dart';
import 'package:pdf/widgets.dart' as pw;

class PdfSalesReportApi {
  static Future<File> generate(SalesReportModel report) async {
    final pdf = Document();

    pdf.addPage(MultiPage(
      build: (context) => [
        buildHeader(report),
        SizedBox(height: 2 * PdfPageFormat.cm),
        buildTitle(report),
        buildStockReport(report),
        Divider(),
        buildGrandTotal(report),
      ],
      footer: (context) => buildFooter(report),
    ));

    String pdfName = DateTime.now().millisecondsSinceEpoch.toString() + '.pdf';

    return PdfApi.saveDocument(name: pdfName, pdf: pdf);
  }

  static Widget buildHeader(SalesReportModel report) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 1 * PdfPageFormat.cm),
          Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildStoreAddress(report),
                Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                  buildReportId(report),
                  SizedBox(height: 1 * PdfPageFormat.cm),
                  buildReportDuration(report),
                ])
              ]),
          SizedBox(height: 1 * PdfPageFormat.cm),
          buildGeneratedDate(report),
          SizedBox(height: 1 * PdfPageFormat.cm),
        ],
      );

  static Widget buildReportId(SalesReportModel report) => Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(salesReportID, style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 1 * PdfPageFormat.mm),
          Text(report.reportId),
        ],
      );

  static Widget buildReportDuration(SalesReportModel report) => Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(salesReportDate, style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 1 * PdfPageFormat.mm),
          Text(report.reportStartDuration.toString().substring(0, 10) +
              ' - ' +
              report.reportEndDuration.toString().substring(0, 10)),
        ],
      );

  static Widget buildStoreAddress(SalesReportModel report) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(report.storeName, style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 1 * PdfPageFormat.mm),
          Text(report.storeAddress),
        ],
      );

  static Widget buildGeneratedDate(SalesReportModel report) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(stocksGeneratedDate,
              style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 1 * PdfPageFormat.mm),
          Text(report.generatedDate.toString().substring(0, 19)),
        ],
      );

  static Widget buildTitle(SalesReportModel report) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'SALES REPORT',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 0.8 * PdfPageFormat.cm),
        ],
      );

  static Widget buildStockReport(SalesReportModel report) {
    final headers = [
      'Id',
      'Date Time',
      'Buyer Email',
      'Grocery Purchased',
      'Total',
    ];
    final data = report.order.map((item) {
      return [
        item.id,
        item.dateTime.toString().substring(0, 19),
        item.email,
        item.getListedCartItems(),
        '\RM ${item.totalPrice.toStringAsFixed(2)}',
      ];
    }).toList();

    return TableHelper.fromTextArray(
      headers: headers,
      data: data,
      border: null,
      headerStyle: TextStyle(fontWeight: FontWeight.bold),
      headerDecoration: BoxDecoration(color: PdfColors.grey300),
      cellHeight: 30,
      columnWidths: {
        0: FixedColumnWidth(1.5 * PdfPageFormat.cm),
        1: FixedColumnWidth(2 * PdfPageFormat.cm),
        2: FixedColumnWidth(2 * PdfPageFormat.cm),
        3: FixedColumnWidth(3.5 * PdfPageFormat.cm),
        4: FixedColumnWidth(1.5 * PdfPageFormat.cm),
      },
      headerAlignments: {
        0: Alignment.centerLeft,
        1: Alignment.centerLeft,
        2: Alignment.centerLeft,
        3: Alignment.centerLeft,
        4: Alignment.centerRight,
      },
      cellAlignments: {
        0: Alignment.topLeft,
        1: Alignment.topLeft,
        2: Alignment.topLeft,
        3: Alignment.topLeft,
        4: Alignment.topRight,
      },
    );
  }

  static Widget buildGrandTotal(SalesReportModel report) {
    return Container(
      alignment: Alignment.centerRight,
      child: Row(
        children: [
          Spacer(flex: 6),
          Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Divider(),
                buildText(
                  title: 'Grand Total',
                  titleStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  value: '\RM ${report.getGrandTotal().toStringAsFixed(2)}',
                  unite: true,
                ),
                SizedBox(height: 2 * PdfPageFormat.mm),
                Container(height: 1, color: PdfColors.grey400),
                SizedBox(height: 0.5 * PdfPageFormat.mm),
                Container(height: 1, color: PdfColors.grey400),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Widget buildFooter(SalesReportModel report) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Divider(),
          SizedBox(height: 2 * PdfPageFormat.mm),
          buildSimpleText(
              title: 'Total number of order: ',
              value: report.order.length.toString()),
        ],
      );

  static buildSimpleText({
    required String title,
    required String value,
  }) {
    final style = TextStyle(fontWeight: FontWeight.bold);

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: pw.CrossAxisAlignment.end,
      children: [
        Text(title, style: style),
        SizedBox(width: 2 * PdfPageFormat.mm),
        Text(value),
      ],
    );
  }

  static buildText({
    required String title,
    required String value,
    double width = double.infinity,
    TextStyle? titleStyle,
    bool unite = false,
  }) {
    final style = titleStyle ?? TextStyle(fontWeight: FontWeight.bold);

    return Container(
      width: width,
      child: Row(
        children: [
          Expanded(child: Text(title, style: style)),
          Text(value, style: unite ? style : null),
        ],
      ),
    );
  }
}
