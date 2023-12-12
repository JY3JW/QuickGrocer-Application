import 'package:cloud_firestore/cloud_firestore.dart';

class FeedbackModel {
  static const ID = "id";
  static const ORDERID = "order id";
  static const EMAIL = "buyer email";
  static const DATETIME = "date time";
  static const CATEGORY = "category";
  static const DESCRIPTION = "description";

  String id;
  String orderId;
  String email;
  DateTime dateTime;
  String category;
  String description;

  FeedbackModel({required this.id, required this.orderId, required this.email, required this.dateTime, required this.category, required this.description});

  factory FeedbackModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return FeedbackModel(
      id: data[ID],
      orderId: data[ORDERID],
      email: data[EMAIL],
      dateTime: (data[DATETIME] as Timestamp).toDate(),
      category: data[CATEGORY],
      description: data[DESCRIPTION],
    );
  }

  toJson() {
    return {
      ID: id,
      ORDERID: orderId,
      EMAIL: email,
      DATETIME: FieldValue.serverTimestamp(),
      CATEGORY: category,
      DESCRIPTION: description,
    };
  }
}
