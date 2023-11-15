import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:quickgrocer_application/src/constants/colors.dart';
import 'package:quickgrocer_application/src/constants/image_strings.dart';
import 'package:quickgrocer_application/src/constants/sizes.dart';
import 'package:quickgrocer_application/src/constants/text_strings.dart';
import 'package:quickgrocer_application/src/features/authentication/models/user_model.dart';
import 'package:quickgrocer_application/src/features/core/controllers/profile_controller.dart';

class UpdateProfileScreen extends StatelessWidget {
  const UpdateProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());

    var iconColor =
        Get.isDarkMode ? AppColors.subPistachioColor : AppColors.mainPineColor;
    var iconLineColor = Get.isDarkMode ? Colors.black : Colors.white;
    var iconColorWithoutBackground = Get.isDarkMode ? Colors.white : Colors.black;

    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () => Get.back(),
              icon: Icon(LineAwesomeIcons.angle_left, color: iconColorWithoutBackground)),
          title: Text(
            profile,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          backgroundColor: Colors.transparent, elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(defaultSize),
            child: FutureBuilder(
              future: controller.getUserData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    UserModel user = snapshot.data as UserModel;
                      // Controllers
                      final _email = TextEditingController(text: user.email);
                      final _password = TextEditingController(text: user.password);
                      final name = TextEditingController(text: user.fullName);
                      final phone = TextEditingController(text: user.phoneNo);

                    return Column(
                      children: [
                        Stack(
                          children: [
                            SizedBox(
                              width: 120,
                              height: 120,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: const Image(
                                      image: AssetImage(profileImage))),
                            ),
                            Positioned(
                                bottom: 0,
                                right: 0,
                                child: Container(
                                    width: 35,
                                    height: 35,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        color: iconColor),
                                    child: Icon(
                                      LineAwesomeIcons.camera,
                                      color: iconLineColor,
                                      size: 20,
                                    )))
                          ],
                        ),
                        const SizedBox(height: 50),
                        Form(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextFormField(
                                controller: name,
                                decoration: const InputDecoration(
                                  label: Text(fullName),
                                  prefixIcon: Icon(
                                    Icons.person_outline_rounded,
                                  ),
                                ),
                              ),
                              const SizedBox(height: formHeight - 20.0),
                              TextFormField(
                                controller: _email,
                                enabled: false,
                                decoration: const InputDecoration(
                                  label: Text(email),
                                  prefixIcon: Icon(
                                    Icons.email_outlined,
                                  ),
                                ),
                              ),
                              const SizedBox(height: formHeight - 20.0),
                              TextFormField(
                                controller: phone,
                                decoration: const InputDecoration(
                                  label: Text(phoneNum),
                                  prefixIcon: Icon(
                                    Icons.numbers,
                                  ),
                                ),
                              ),
                              const SizedBox(height: formHeight - 20.0),
                              TextFormField(
                                controller: _password,
                                obscureText: true,
                                decoration: InputDecoration(
                                  label: Text(password),
                                  prefixIcon: Icon(
                                    Icons.fingerprint,
                                  ),
                                ),
                              ),
                              const SizedBox(height: formHeight),
                              SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      final userData = UserModel(
                                        email: _email.text.trim(),
                                        password: _password.text.trim(),
                                        phoneNo: phone.text.trim(),
                                        fullName: name.text.trim(),
                                      );

                                      await controller.updateRecord(userData, user.id);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      shape: StadiumBorder(),
                                    ),
                                    child: const Text("Save Profile"),
                                  )),
                            ],
                          ),
                        ),
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return Center(child: Text(snapshot.error.toString()));
                  } else {
                    return const Center(child: Text("Something went wrong"));
                  }
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ));
  }
}
