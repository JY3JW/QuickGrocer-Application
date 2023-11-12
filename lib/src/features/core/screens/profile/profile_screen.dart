import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:quickgrocer_application/src/constants/colors.dart';
import 'package:quickgrocer_application/src/constants/image_strings.dart';
import 'package:quickgrocer_application/src/constants/sizes.dart';
import 'package:quickgrocer_application/src/constants/text_strings.dart';
import 'package:quickgrocer_application/src/features/core/screens/profile/update_profile_screen.dart';
import 'package:quickgrocer_application/src/repository/authentication_repository/authentication_repository.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    var iconColor =
        isDark ? AppColors.mainPineColor : AppColors.subPistachioColor;
    var iconLineColor =
        isDark ? Colors.white : Colors.black;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          profile,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        backgroundColor: Colors.transparent, elevation: 0,
        actions: [
          IconButton(
              onPressed: () {

              },
              icon: Icon(isDark ? LineAwesomeIcons.sun : LineAwesomeIcons.moon))
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(defaultSize),
          child: Column(
            children: [
              Stack(
                children: [
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: const Image(image: AssetImage(profileImage))),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 35, height: 35,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), color: iconColor),
                      child: Icon(LineAwesomeIcons.alternate_pencil, color: iconLineColor, size: 20,)
                    )
                  )
                ],
              ),
              const SizedBox(height: 20),
              Text("username",
                  style: Theme.of(context).textTheme.headlineSmall),
              Text("email", style: Theme.of(context).textTheme.bodyLarge),
              const SizedBox(height: 20),
              SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    onPressed: () => Get.to(() => const UpdateProfileScreen()),
                    style: ElevatedButton.styleFrom(
                      shape: StadiumBorder(),
                    ),
                    child: const Text(editProfile),
                  )),
              const SizedBox(height: 30),
              const Divider(),
              const SizedBox(height: 10),
              ListTile(
                onTap: () {
                  AuthenticationRepository.instance.logout();
                },
                leading: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: iconColor.withOpacity(0.1),
                  ),
                  child: Icon(LineAwesomeIcons.alternate_sign_out,
                      color: iconColor),
                ),
                title: Text(logout,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.apply(color: Colors.red)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
