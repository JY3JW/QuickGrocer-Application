import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quickgrocer_application/src/constants/text_strings.dart';

class StoreModel {
  final String? id;
  final bool status;

  const StoreModel({
    this.id = storeId,
    required this.status,
  });

  toJson() {
    return {
      "id": id,
      "status": status,
    };
  }
  
  // map user fetched from Firebase to UserModel
  factory StoreModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return StoreModel(
      id: document.id,
      status: data["status"],
    );
  }
}
