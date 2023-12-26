import 'package:flutter/material.dart';
import 'package:quickgrocer_application/src/constants/text_strings.dart';
import 'package:quickgrocer_application/src/features/core/screens/feedback/seller_issue_feedback_screen.dart';
import 'package:quickgrocer_application/src/features/core/screens/feedback/seller_normal_feedback_screen.dart';

class ViewFeedbackScreen extends StatefulWidget {
  const ViewFeedbackScreen({super.key});

  @override
  State<ViewFeedbackScreen> createState() => _ViewFeedbackScreenState();
}

class _ViewFeedbackScreenState extends State<ViewFeedbackScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.feedback_outlined, color: Colors.green),
                    Text(feedbackTitle,
                        style: Theme.of(context).textTheme.bodyLarge),
                  ],
                )),
                Tab(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.report_problem_outlined, color: Colors.red),
                    Text(issueTitle,
                        style: Theme.of(context).textTheme.bodyLarge),
                  ],
                )),
              ],
            ),
            title: const Text(viewFeedbackScreenTitle),
          ),
          body: const TabBarView(
            children: [
              FeedbackNormalScreen(),
              FeedbackIssueScreen(),
            ],
          ),
        ),
      ),
    );
  }
}
