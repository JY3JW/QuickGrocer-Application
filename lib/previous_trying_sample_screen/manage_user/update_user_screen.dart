import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:quickgrocer_application/src/constants/sizes.dart';
import 'package:quickgrocer_application/src/constants/text_strings.dart';
import 'package:quickgrocer_application/src/features/authentication/models/user_model.dart';
import 'package:quickgrocer_application/previous_trying_sample_screen/manage_user_controller.dart';

class UpdateUserScreen extends StatefulWidget {
  const UpdateUserScreen({super.key, required this.user});

  final UserModel user;

  @override
  State<UpdateUserScreen> createState() => _UpdateUserScreenState();
}

class _UpdateUserScreenState extends State<UpdateUserScreen> {
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    var iconColorWithoutBackground =
        Get.isDarkMode ? Colors.white : Colors.black;
    final controller = Get.put(ManageUserController());
    final _formKey = GlobalKey<FormState>();

    final id = widget.user.id;
    final name = TextEditingController(text: widget.user.fullName);
    final _email = TextEditingController(text: widget.user.email);
    final phone = TextEditingController(text: widget.user.phoneNo);
    final _password = TextEditingController(text: widget.user.password);

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: Icon(LineAwesomeIcons.angle_left,
                color: iconColorWithoutBackground)),
        title: Text(
          updateUser,
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
                      controller: name,
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
                      controller: _email,
                      enabled: false,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp('[0-9a-zA-Z@.]')),
                      ],
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
                      controller: phone,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp('[0-9+]')),
                      ],
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
                    const SizedBox(height: formHeight - 20.0),
                    //password
                    TextFormField(
                      controller: _password,
                      enabled: false,
                      inputFormatters: [
                        FilteringTextInputFormatter.deny(RegExp('[ ]')),
                      ],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                      obscureText: true,
                      decoration: InputDecoration(
                          label: Text(password),
                          prefixIcon: Icon(
                            Icons.fingerprint,
                          ),
                      ),
                    ),
                    const SizedBox(height: formHeight - 20.0),
                    Row(
                      children: [
                        Expanded(child: ElevatedButton(onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            final newUser = UserModel(
                              fullName: name.text.trim(),
                              email: _email.text.trim(),
                              phoneNo: phone.text.trim(),
                              password: _password.text.trim(),
                            );
                            controller.updateUserRecord(newUser, id);

                            Navigator.pop(context);
                          }
                        },
                        child: const Text(saveUserDetails),
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
