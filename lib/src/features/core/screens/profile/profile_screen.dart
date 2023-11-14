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

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());

    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    var iconColor =
        isDark ? AppColors.mainPineColor : AppColors.subPistachioColor;
    var iconLineColor = isDark ? Colors.white : Colors.black;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          profile,
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
                          width: 35,
                          height: 35,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: iconColor),
                          child: Icon(
                            LineAwesomeIcons.alternate_pencil,
                            color: iconLineColor,
                            size: 20,
                          )))
                ],
              ),
              const SizedBox(height: 20),
              Container (
                child: FutureBuilder(
                  future: controller.getUserData(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasData) {
                        UserModel user = snapshot.data as UserModel;
                        return Column(
                          children: [
                            Text(user.fullName,style: Theme.of(context).textTheme.headlineSmall),
                            Text(user.email, style: Theme.of(context).textTheme.bodyLarge),],
                        );
                      } else if (snapshot.hasError) {
                        return Center(child: Text(snapshot.error.toString()));
                      } else {
                        return const Center(child: Text("Something went wrong"));
                      }
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  }
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    onPressed: () => Get.to(() => UpdateProfileScreen()),
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
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Logout'),
                      content: Text('Confirm to log out of your account?'),
                      actions: [
                        ElevatedButton(
                          child: Text('NO'),
                          onPressed: () => Navigator.pop(context),
                        ),
                        ElevatedButton(
                          child: Text('YES'),
                          onPressed: () => AuthenticationRepository.instance.logout(),
                        ),
                      ]
                    )
                  );
                },
                leading: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: iconColor.withOpacity(0.3),
                  ),
                  child: Icon(LineAwesomeIcons.alternate_sign_out,
                      color: iconColor),
                ),
                title: Text(logout,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.apply(color: Colors.red)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
