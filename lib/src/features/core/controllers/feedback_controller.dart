import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickgrocer_application/src/constants/text_strings.dart';
import 'package:quickgrocer_application/src/features/core/models/feedback_model.dart';
import 'package:quickgrocer_application/src/repository/feedback_repository/feedback_repository.dart';

class FeedbackController extends GetxController {
  static FeedbackController get instance => Get.find();

  final _feedbackRepo = Get.put(FeedbackRepository());

  //TextField Controllers to get data from TextFields
  final description = TextEditingController();

  clearControllers() {
    description.clear();
  }

  // create new feedback
  createNewFeedback(FeedbackModel feedbackModel) async {
    try {
      await _feedbackRepo.createFeedback(feedbackModel);
    } catch (e) {
      Get.snackbar("Feedback Creation Failed", e.toString(),
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 5));
    }
  }

  // get the feedback for the respective order
  Future<FeedbackModel> getBuyerFeedbackByOrderId(String orderId) async {
    final feedback = await _feedbackRepo.getFeedbackDetailsByOrderId(orderId);
    return feedback;
  }

  // get all feedbacks from all buyers
  Future<List<FeedbackModel>> getAllBuyerFeedback() async {
    final feedback = await _feedbackRepo.getAllBuyersFeedbacks();
    return feedback;
  }

  Future<List<FeedbackModel>> getAllFeedbackIssues() async {
    final feedback = await _feedbackRepo.getAllBuyersFeedbacksByCategory(issueTitle);
    return feedback;
  }

  Future<List<FeedbackModel>> getAllFeedbackNormal() async {
    final feedback = await _feedbackRepo.getAllBuyersFeedbacksByCategory(feedbackTitle);
    return feedback;
  }
}