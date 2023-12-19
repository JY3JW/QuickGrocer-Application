import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickgrocer_application/src/features/core/controllers/feedback_controller.dart';
import 'package:quickgrocer_application/src/features/core/models/feedback_model.dart';
import 'package:quickgrocer_application/src/features/core/screens/feedback/feedback_card.dart';

class FeedbackNormalScreen extends StatefulWidget {
  const FeedbackNormalScreen({super.key});

  @override
  State<FeedbackNormalScreen> createState() =>
      _FeedbackNormalScreenState();
}

class _FeedbackNormalScreenState extends State<FeedbackNormalScreen> {
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
                  future: feedbackController.getAllFeedbackNormal(),
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
