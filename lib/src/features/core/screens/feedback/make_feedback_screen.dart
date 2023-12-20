import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:quickgrocer_application/src/constants/sizes.dart';
import 'package:quickgrocer_application/src/constants/text_strings.dart';
import 'package:quickgrocer_application/src/features/core/controllers/feedback_controller.dart';
import 'package:quickgrocer_application/src/features/core/models/feedback_model.dart';
import 'package:quickgrocer_application/src/features/core/models/order_model.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key, required this.order});

  final OrderModel order;

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  var iconColorWithoutBackground = Get.isDarkMode ? Colors.white : Colors.black;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Scaffold(
        appBar: AppBar(
            leading: IconButton(
                onPressed: () => Get.back(),
                icon: Icon(LineAwesomeIcons.angle_left,
                    color: iconColorWithoutBackground)),
            title: Text(
              feedback,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            backgroundColor: Colors.transparent,
            elevation: 0),
        body: Feedback(order: widget.order),
      ),
    );
  }
}

class Feedback extends StatefulWidget {
  const Feedback({super.key, required this.order});

  final OrderModel order;

  @override
  State<Feedback> createState() => _FeedbackState();
}

class _FeedbackState extends State<Feedback> {
  String selectedValue = activeFeedback;
  List<String> dropdownOptions = [activeFeedback, passiveFeedback];

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final controller = Get.put(FeedbackController());

    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    DropdownButtonFormField<String>(
                      value: selectedValue,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select a feedback category';
                        }
                        return null;
                      },
                      isExpanded: true,
                      borderRadius: BorderRadius.circular(16),
                      items: dropdownOptions.map((String value) {
                        return DropdownMenuItem<String>(
                            value: value, child: Text(value));
                      }).toList(),
                      onChanged: (value) async {
                        setState(() {
                          selectedValue = value!;
                        });
                      },
                    ),
                    const SizedBox(height: formHeight - 20.0),
                    TextFormField(
                      controller: controller.description,
                      maxLines: 8,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the description of your feedback';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        label: Text('Description'),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    const SizedBox(height: formHeight),
                    SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              await controller.createNewFeedback(FeedbackModel(
                                  id: widget.order.id,
                                  orderId: widget.order.id,
                                  email: widget.order.email,
                                  dateTime: DateTime.now(),
                                  category: selectedValue == activeFeedback
                                      ? feedbackTitle
                                      : issueTitle,
                                  description:
                                      controller.description.text.trim()));
                              controller.clearControllers();
                              Navigator.pop(context);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            shape: StadiumBorder(),
                          ),
                          child: const Text("Send Feedback"),
                        )),
                  ],
                ),
              ),
            ])));
  }
}
