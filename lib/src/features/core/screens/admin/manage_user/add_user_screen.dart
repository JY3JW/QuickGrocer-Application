import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:quickgrocer_application/src/constants/sizes.dart';
import 'package:quickgrocer_application/src/constants/text_strings.dart';
import 'package:quickgrocer_application/src/features/authentication/models/user_model.dart';
import 'package:quickgrocer_application/src/features/core/controllers/manage_user_controller.dart';

class AddUserScreen extends StatefulWidget {
  const AddUserScreen({super.key});

  @override
  State<AddUserScreen> createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    var iconColorWithoutBackground =
        Get.isDarkMode ? Colors.white : Colors.black;
    final controller = Get.put(ManageUserController());
    final _formKey = GlobalKey<FormState>();

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: Icon(LineAwesomeIcons.angle_left,
                color: iconColorWithoutBackground)),
        title: Text(
          addUser,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(defaultSize),
          child: Column(children: [
            Form(
              key: _formKey,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //fullname
                    TextFormField(
                      controller: controller.fullName,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter the user full name";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        label: Text(fullName),
                        prefixIcon: Icon(Icons.person_outline_rounded),
                      ),
                    ),
                    //email
                    const SizedBox(height: formHeight - 20.0),
                    TextFormField(
                      controller: controller.email,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter the user email";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        label: Text(email),
                        prefixIcon: Icon(Icons.email_outlined),
                      ),
                    ),
                    //phone number
                    const SizedBox(height: formHeight - 20.0),
                    TextFormField(
                      controller: controller.phoneNumber,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter the user phone number";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        label: Text(phoneNum),
                        prefixIcon: Icon(Icons.numbers),
                      ),
                    ),
                    const SizedBox(height: formHeight),
                    Row(
                      children: [
                        Expanded(child: ElevatedButton(onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            final UserInfo = UserModel(
                              fullName: controller.fullName.text.trim(),
                              email: controller.email.text.trim(),
                              phoneNo: controller.phoneNumber.text.trim(),
                              password: controller.password.text.trim(),
                            );

                            Navigator.pop(context);
                          }
                        },
                        child: const Text(addNewUser),
                        ))
                      ],
                    )
                  ]),
            )
          ]),
        ),
      ),
    ));
  }
}
