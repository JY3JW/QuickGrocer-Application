import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quickgrocer_application/src/constants/text_strings.dart';

class SupportModel {
  final String? id;
  final String mode;
  final String contact;

  const SupportModel({
    this.id = storeId,
    required this.mode,
    required this.contact,
  });

  toJson() {
    return {
      "id": id,
      "contact": contact,
      "mode": mode,
    };
  }

  // map user fetched from Firebase to UserModel
  factory SupportModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return SupportModel(
      id: document.id,
      mode: data["mode"],
      contact: data["contact"],
    );
  }
}
