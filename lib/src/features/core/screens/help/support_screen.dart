import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:quickgrocer_application/src/common_widgets/form/form_header_widget.dart';
import 'package:quickgrocer_application/src/constants/colors.dart';
import 'package:quickgrocer_application/src/constants/image_strings.dart';
import 'package:quickgrocer_application/src/constants/sizes.dart';
import 'package:quickgrocer_application/src/constants/text_strings.dart';
import 'package:quickgrocer_application/src/features/core/controllers/support_controller.dart';
import 'package:quickgrocer_application/src/features/core/models/support_model.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var iconColor =
        Get.isDarkMode ? AppColors.subPistachioColor : AppColors.mainPineColor;
    var iconColorWithoutBackground =
        Get.isDarkMode ? Colors.white : Colors.black;
    final supportController = Get.put(SupportController());

    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () => Get.back(),
              icon: Icon(LineAwesomeIcons.angle_left,
                  color: iconColorWithoutBackground)),
          title: Text(
            support,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: SingleChildScrollView(
            child: Container(
          padding: const EdgeInsets.all(defaultSize),
          child: Column(
            children: [
              FormHeaderWidget(
                image: welcomeScreenImage,
                title: supportScreenTitle,
                subTitle: supportScreenSubtitle,
                crossAxisAlignment: CrossAxisAlignment.center,
                heightBetween: 30.0,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: defaultSize),
              Container(
                height: MediaQuery.of(context).size.height / 2,
                child: FutureBuilder(
                    future: supportController.getAllSupportInfo(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasData) {
                          List<SupportModel> support =
                              snapshot.data as List<SupportModel>;

                          return ListView.builder(
                            itemCount: support.length,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  supportCard(
                                      iconColor: iconColor,
                                      icon: support[index].mode == 'email'
                                          ? Icons.email_outlined
                                          : Icons.support_agent_outlined,
                                      label: support[index].contact),
                                  const SizedBox(height: 10),
                                ],
                              );
                            },
                          );
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
        )));
  }
}

class supportCard extends StatelessWidget {
  const supportCard({
    super.key,
    required this.iconColor,
    required this.icon,
    required this.label,
  });

  final Color iconColor;
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: iconColor.withOpacity(0.3),
        ),
        child: Icon(icon, color: iconColor),
      ),
      title: Text(label, style: Theme.of(context).textTheme.titleMedium),
    );
  }
}
