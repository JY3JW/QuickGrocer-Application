import 'package:flutter/material.dart';
import 'package:quickgrocer_application/src/constants/colors.dart';
import 'package:quickgrocer_application/src/features/core/models/feedback_model.dart';
import 'package:quickgrocer_application/src/features/core/screens/feedback/view_feedback_details.dart';

class FeedbackCard extends StatefulWidget {
  const FeedbackCard({super.key, required this.feedbackModel});

  final FeedbackModel feedbackModel;

  @override
  State<FeedbackCard> createState() => _FeedbackCardState();
}

class _FeedbackCardState extends State<FeedbackCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
              builder: (context) => ViewFeedbackDetailsScreen(
                    feedbackModel: widget.feedbackModel,
                  )),
        );
      },
      child: Card(
        color: Colors.white,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.network(
                    "https://cdn-icons-png.flaticon.com/512/4481/4481095.png",
                    width: 60,
                    height: 60,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 3 / 7,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.feedbackModel.id,
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.w500)),
                        const SizedBox(height: 5),
                        Text(
                            widget.feedbackModel.dateTime
                                .toString()
                                .substring(0, 19),
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.w500)),
                        const SizedBox(height: 5),
                        Text(widget.feedbackModel.email,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.w400)),
                      ],
                    ),
                  ),
                  Container(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => ViewFeedbackDetailsScreen(
                                    feedbackModel: widget.feedbackModel,
                                  )),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        backgroundColor: AppColors.subDarkerLimeColor,
                        side: BorderSide(color: AppColors.subDarkerLimeColor),
                        foregroundColor: Colors.white,
                        shape: StadiumBorder(),
                      ),
                      child: const Text("Details"),
                    ),
                  ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
