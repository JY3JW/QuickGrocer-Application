import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickgrocer_application/src/common_widgets/form/form_header_widget.dart';
import 'package:quickgrocer_application/src/constants/sizes.dart';
import 'package:quickgrocer_application/src/constants/image_strings.dart';
import 'package:quickgrocer_application/src/constants/text_strings.dart';
import 'package:quickgrocer_application/src/features/authentication/controllers/login_controller.dart';
import 'package:quickgrocer_application/src/repository/authentication_repository/authentication_repository.dart';

class ResetPasswordScreen extends StatefulWidget {
  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final controller = Get.put(LoginController());
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
                  child: Column(children: [
                    TextFormField(
                      controller: controller.email,
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
                          AuthenticationRepository.instance.resetPasswordEmail(controller.email.text.trim());
                          Navigator.of(context).pop();
                        },
                        child: const Text(sendRequest),
                      ),
                    ),
                  ]),
                ),
              ],
            )),
      )),
    );
  }
}
