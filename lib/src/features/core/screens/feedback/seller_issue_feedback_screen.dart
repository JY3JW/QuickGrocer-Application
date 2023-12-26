import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickgrocer_application/src/features/core/controllers/feedback_controller.dart';
import 'package:quickgrocer_application/src/features/core/models/feedback_model.dart';
import 'package:quickgrocer_application/src/features/core/screens/feedback/feedback_card.dart';

class FeedbackIssueScreen extends StatefulWidget {
  const FeedbackIssueScreen({super.key});

  @override
  State<FeedbackIssueScreen> createState() =>
      _FeedbackIssueScreenState();
}

class _FeedbackIssueScreenState extends State<FeedbackIssueScreen> {
  @override
  Widget build(BuildContext context) {
    final feedbackController = Get.put(FeedbackController());

    return Scaffold(
        body: RefreshIndicator(
      onRefresh: () async {
        setState(() {});
        await Future.delayed(const Duration(seconds: 1));
      },
      child: Container(
        margin: const EdgeInsets.all(10),
        child: Column(
          children: [
            Container(
              child: FutureBuilder(
                  future: feedbackController.getAllFeedbackIssues(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasData) {
                        List<FeedbackModel> feed =
                            snapshot.data as List<FeedbackModel>;
                        return Expanded(
                            child: ListView.builder(
                              itemCount: feed.length,
                              itemBuilder: (context, index) {
                                return FeedbackCard(feedbackModel: feed[index]);
                              },
                            ));
                      } else if (snapshot.hasError) {
                        return Center(child: Text(snapshot.error.toString()));
                      } else {
                        return const Center(
                            child: Text("Something went wrong"));
                      }
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  }),
            ),
          ],
        ),
      ),
    ));
  }
}
