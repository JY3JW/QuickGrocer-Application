import 'dart:io';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:quickgrocer_application/src/constants/text_strings.dart';
import 'package:quickgrocer_application/src/features/core/models/stock_report_model.dart';
import 'package:quickgrocer_application/src/features/core/screens/report/pdf_api.dart';
import 'package:pdf/widgets.dart' as pw;

class PdfStockReportApi {
  static Future<File> generate(StockReportModel report) async {
    final pdf = Document();

    pdf.addPage(MultiPage(
      build: (context) => [
        buildHeader(report),
        SizedBox(height: 2 * PdfPageFormat.cm),
        buildTitle(report),
        buildStockReport(report),
      ],
      footer: (context) => buildFooter(report),
    ));

    String pdfName = DateTime.now().millisecondsSinceEpoch.toString() + '.pdf';

    return PdfApi.saveDocument(name: pdfName, pdf: pdf);
  }

  static Widget buildHeader(StockReportModel report) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 1 * PdfPageFormat.cm),
          Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildStoreAddress(report),
                buildReportId(report),
              ]),
          SizedBox(height: 1 * PdfPageFormat.cm),
          buildGeneratedDate(report),
          SizedBox(height: 1 * PdfPageFormat.cm),
        ],
      );

  static Widget buildReportId(StockReportModel report) => Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(stocksReportID, style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 1 * PdfPageFormat.mm),
          Text(report.reportId),
        ],
      );

  static Widget buildStoreAddress(StockReportModel report) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(report.storeName, style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 1 * PdfPageFormat.mm),
          Text(report.storeAddress),
        ],
      );

  static Widget buildGeneratedDate(StockReportModel report) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(stocksGeneratedDate,
              style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 1 * PdfPageFormat.mm),
          Text(report.generatedDate.toString().substring(0, 19)),
        ],
      );

  static Widget buildTitle(StockReportModel report) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'STOCKS REPORT',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 0.8 * PdfPageFormat.cm),
        ],
      );

  static Widget buildStockReport(StockReportModel report) {
    final headers = [
      'Id',
      'Name',
      'Category',
      'Price',
      'Quantity',
    ];
    final data = report.grocery.map((item) {
      return [
        item.id,
        item.name,
        item.category,
        '\RM ${item.price.toStringAsFixed(2)}',
        item.quantity,
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
        3: FixedColumnWidth(1.5 * PdfPageFormat.cm),
        4: FixedColumnWidth(1.5 * PdfPageFormat.cm),
      },
      cellAlignments: {
        0: Alignment.centerLeft,
        1: Alignment.centerLeft,
        2: Alignment.centerLeft,
        3: Alignment.centerRight,
        4: Alignment.centerRight,
      },
    );
  }

  static Widget buildFooter(StockReportModel report) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Divider(),
          SizedBox(height: 2 * PdfPageFormat.mm),
          buildSimpleText(
              title: 'Total number of grocery: ',
              value: report.grocery.length.toString()),
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
