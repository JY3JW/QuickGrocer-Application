import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickgrocer_application/src/features/core/models/feedback_model.dart';

class FeedbackRepository extends GetxController {
  static FeedbackRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  createFeedback(FeedbackModel feedback) async {
    await _db
        .collection("feedbacks")
        .doc(feedback.id)
        .set(feedback.toJson())
        .whenComplete(() => {})
        .catchError((error, stackTrace) {
      Get.snackbar("Error", "Something went wrong. Try again",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent.withOpacity(0.1),
          colorText: Colors.red);
      print(error.toString());
    });
  }

  // Fetch feedback details
  Future<FeedbackModel> getFeedbackDetailsByOrderId(String orderId) async {
    var snapshot =
        await _db.collection("feedbacks").where("order id", isEqualTo: orderId).get();
    final feedbackData =
        snapshot.docs.map((e) => FeedbackModel.fromSnapshot(e)).single;
    return feedbackData;
  }

  Future<List<FeedbackModel>> getAllBuyersFeedbacks() async {
    var snapshot = await _db
        .collection("feedbacks")
        .orderBy('date time', descending: true)
        .get();
    final feedbackData =
        snapshot.docs.map((e) => FeedbackModel.fromSnapshot(e)).toList();
    return feedbackData;
  }
}
