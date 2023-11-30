import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickgrocer_application/src/constants/colors.dart';
import 'package:quickgrocer_application/src/constants/image_strings.dart';
import 'package:quickgrocer_application/src/constants/sizes.dart';
import 'package:quickgrocer_application/src/constants/text_strings.dart';
import 'package:quickgrocer_application/src/features/authentication/controllers/adminlogin_controller.dart';
import 'package:quickgrocer_application/src/features/authentication/screens/signup/signup_screen.dart';

class AdminLoginFooterWidget extends StatelessWidget {
  const AdminLoginFooterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AdminLoginController());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text("OR"),
        const SizedBox(
          height: formHeight - 20.0,
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const SignUpScreen()),
            );
          },
          child: Text.rich(TextSpan(
              text: dontHaveAnAccount,
              style: Theme.of(context).textTheme.bodyLarge,
              children: [
                TextSpan(
                    text: signup.toUpperCase(),
                    style: const TextStyle(
                        color: Color.fromARGB(255, 79, 68, 179))),
              ])),
        ),
      ],
    );
  }
}
