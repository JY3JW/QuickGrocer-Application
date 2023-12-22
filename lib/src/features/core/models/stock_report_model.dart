import 'package:quickgrocer_application/src/constants/text_strings.dart';
import 'package:quickgrocer_application/src/features/core/models/grocery_model.dart';

class StockReportModel {
  String storeName = storeNameInfo;
  String storeAddress = storeAddressInfo;
  String reportId = DateTime.now().millisecondsSinceEpoch.toString();
  DateTime generatedDate = DateTime.now();
  List<GroceryModel> grocery;

  StockReportModel({required this.grocery});
}
