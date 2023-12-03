import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:quickgrocer_application/src/common_widgets/form/form_header_widget.dart';
import 'package:quickgrocer_application/src/constants/sizes.dart';
import 'package:quickgrocer_application/src/constants/image_strings.dart';
import 'package:quickgrocer_application/src/constants/text_strings.dart';
import 'package:quickgrocer_application/src/features/authentication/controllers/login_controller.dart';

class ResetPasswordScreen extends StatefulWidget {
  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final controller = Get.put(LoginController());
  final _formKey = GlobalKey<FormState>();
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
        child: Container(
            padding: const EdgeInsets.all(defaultSize),
            child: Column(
              children: [
                SizedBox(height: defaultSize * 4),
                FormHeaderWidget(
                  image: resetPasswordImage,
                  title: forgetPasswordTitle,
                  subTitle: emailVerification,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  heightBetween: 30.0,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: formHeight),
                Form(
                  key: _formKey,
                  child: Column(children: [
                    TextFormField(
                      controller: controller.email,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        label: Text(email),
                        hintText: email,
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            controller.resetPassword(controller.email.text.trim());
                          }
                        },
                        child: const Text(sendRequest),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    SizedBox(
                      width: double.infinity,
                      child: TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                  LineAwesomeIcons.alternate_long_arrow_left),
                              const SizedBox(width: 5),
                              Text(backToLogin.toLowerCase()),
                            ],
                          )),
                    ),
                  ]),
                ),
              ],
            )),
      )),
    );
  }
}
