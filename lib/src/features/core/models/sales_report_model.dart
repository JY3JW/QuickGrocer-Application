import 'package:quickgrocer_application/src/constants/text_strings.dart';
import 'package:quickgrocer_application/src/features/core/models/order_model.dart';

class SalesReportModel {
  String storeName = storeNameInfo;
  String storeAddress = storeAddressInfo;
  String reportId = DateTime.now().millisecondsSinceEpoch.toString();
  DateTime reportStartDuration;
  DateTime reportEndDuration;
  DateTime generatedDate = DateTime.now();
  List<OrderModel> order;

  SalesReportModel(
      {required this.reportStartDuration,
      required this.reportEndDuration,
      required this.order});

  double getGrandTotal() {
    double grand = 0;

    for (int i = 0; i < order.length; i++) {
      grand += order[i].totalPrice;
    }
    
    return grand;
  }
}
