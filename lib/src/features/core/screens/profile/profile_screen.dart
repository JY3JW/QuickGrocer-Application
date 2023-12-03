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
import 'package:quickgrocer_application/src/utils/theme/theme.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());

    var iconColor =
        Get.isDarkMode ? AppColors.subPistachioColor : AppColors.mainPineColor;
    var iconColorWithoutBackground =
        Get.isDarkMode ? Colors.white : Colors.black;

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
              onPressed: () {
                Get.isDarkMode
                    ? Get.changeTheme(AppTheme.lightTheme)
                    : Get.changeTheme(AppTheme.darkTheme);
              },
              icon: Icon(
                Get.isDarkMode ? LineAwesomeIcons.sun : LineAwesomeIcons.moon,
                color: iconColorWithoutBackground,
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(defaultSize),
          child: Column(
            children: [
              Container(
                child: FutureBuilder(
                    future: controller.getUserData(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasData) {
                          UserModel user = snapshot.data as UserModel;
                          return Column(
                            children: [
                              Stack(
                                children: [
                                  SizedBox(
                                    width: 120,
                                    height: 120,
                                    child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        child: Image(
                                            image: AssetImage(profileImage))),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              Text(user.fullName,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall),
                              const SizedBox(height: 10),
                              Text(user.email,
                                  style: Theme.of(context).textTheme.bodyLarge),
                            ],
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
                              content:
                                  Text('Confirm to log out of your account?'),
                              actions: [
                                ElevatedButton(
                                  child: Text('NO'),
                                  onPressed: () => Navigator.pop(context),
                                ),
                                ElevatedButton(
                                  child: Text('YES'),
                                  onPressed: () => AuthenticationRepository
                                      .instance
                                      .logout(),
                                ),
                              ]));
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
              ),
              const SizedBox(height: 10),
              ListTile(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                              title: Text('Delete Account'),
                              content: Text('Confirm to delete your account?'),
                              actions: [
                                ElevatedButton(
                                  child: Text('NO'),
                                  onPressed: () => Navigator.pop(context),
                                ),
                                ElevatedButton(
                                  child: Text('YES'),
                                  onPressed: () => {
                                    AuthenticationRepository.instance
                                        .deleteUserAccount()
                                  },
                                ),
                              ]));
                },
                leading: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: iconColor.withOpacity(0.3),
                  ),
                  child: Icon(Icons.delete_forever_rounded, color: iconColor),
                ),
                title: Text(deleteAccount,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.apply(color: Colors.red)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
