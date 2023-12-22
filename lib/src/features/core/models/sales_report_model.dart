import 'package:quickgrocer_application/src/constants/text_strings.dart';
import 'package:quickgrocer_application/src/features/core/models/order_model.dart';

class SalesReportModel {
  String storeName = storeNameInfo;
  String storeAddress = storeAddressInfo;
  String reportId;
  String reportType;
  String reportDuration;
  DateTime generatedDate;
  List<OrderModel> order;

  SalesReportModel({required this.reportId, required this.reportType, required this.reportDuration, required this.generatedDate, required this.order});
}
