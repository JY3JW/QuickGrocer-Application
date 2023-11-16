import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:quickgrocer_application/src/constants/colors.dart';
import 'package:quickgrocer_application/src/constants/image_strings.dart';
import 'package:quickgrocer_application/src/constants/sizes.dart';
import 'package:quickgrocer_application/src/constants/text_strings.dart';
import 'package:quickgrocer_application/src/features/authentication/models/user_model.dart';
import 'package:quickgrocer_application/src/features/core/controllers/manage_user_controller.dart';
import 'package:quickgrocer_application/src/features/core/controllers/profile_controller.dart';
import 'package:quickgrocer_application/src/features/core/screens/profile/update_profile_screen.dart';
import 'package:quickgrocer_application/src/repository/authentication_repository/authentication_repository.dart';

class ManageUserScreen extends StatelessWidget {
  const ManageUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ManageUserController());
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    var iconColor =
        isDark ? AppColors.mainPineColor : AppColors.subPistachioColor;
    var iconLineColor = isDark ?  Color.fromRGBO(255, 255, 255, 1) : Colors.black;

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
                icon:
                    Icon(isDark ? LineAwesomeIcons.sun : LineAwesomeIcons.moon))
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(17.0),
            child: FutureBuilder(
              future: controller.getUserData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    UserModel user = snapshot.data as UserModel;
                      // Controllers
                      final _email = TextEditingController(text: user.email);
                      final name = TextEditingController(text: user.fullName);
                    
                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              userList,
                              textAlign: TextAlign.right,
                              style: Theme.of(context).textTheme.headlineSmall
                            ),

                            const SizedBox(width: 120.0),

                            Expanded(
                              child: ElevatedButton(
                                onPressed: () => Get.to(() => const []),
                                style: ElevatedButton.styleFrom(
                                  shape: StadiumBorder(),
                                ),
                                child: const Text(addNewUser),
                              ))
                      ]),
                        ListTile(
                          leading: Container(
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(profileImage)
                            ),
                          ),
                          title: Text(user.fullName),
                        )
                    ]);
                  } else if (snapshot.hasError) {
                    return Center(child: Text(snapshot.error.toString()));
                  } else {
                    return const Center(child:Text("Something went wrong"));
                  }
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          )
        )
    );
  }
}