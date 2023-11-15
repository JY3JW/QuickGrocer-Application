import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:quickgrocer_application/src/constants/colors.dart';
import 'package:quickgrocer_application/src/constants/image_strings.dart';
import 'package:quickgrocer_application/src/constants/sizes.dart';
import 'package:quickgrocer_application/src/constants/text_strings.dart';
import 'package:quickgrocer_application/src/features/authentication/models/user_model.dart';
import 'package:quickgrocer_application/src/features/core/controllers/profile_controller.dart';
import 'package:quickgrocer_application/src/features/core/screens/profile/update_profile_screen.dart';
import 'package:quickgrocer_application/src/repository/authentication_repository/authentication_repository.dart';

class ManageUserScreen extends StatelessWidget {
  const ManageUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    var iconColor =
        isDark ? AppColors.mainPineColor : AppColors.subPistachioColor;
    var iconLineColor = isDark ? Colors.white : Colors.black;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          manageUser,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(isDark ? LineAwesomeIcons.sun : LineAwesomeIcons.moon))
        ],
      ),
      body: Row(
        children: [
          Text(
            userList,
            style: Theme.of(context).textTheme.displayMedium,
          ),
          SizedBox(
          width: 150,
          child: ElevatedButton(
            onPressed: () => Get.to(() => const []),
            style: ElevatedButton.styleFrom(
              shape: StadiumBorder(),
            ),
            child: const Text(addNewUser),
          )),
        ]
      )
    );
  }
}