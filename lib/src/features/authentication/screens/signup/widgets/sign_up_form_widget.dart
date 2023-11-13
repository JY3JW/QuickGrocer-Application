import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickgrocer_application/src/constants/sizes.dart';
import 'package:quickgrocer_application/src/constants/text_strings.dart';
import 'package:quickgrocer_application/src/features/authentication/controllers/signup_controller.dart';
import 'package:quickgrocer_application/src/features/authentication/models/user_model.dart';
import 'package:quickgrocer_application/src/features/authentication/screens/forget_password/forget_password_otp/otp_screen.dart';

class SignUpFormWidget extends StatelessWidget {
  const SignUpFormWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignUpController());
    final _formKey = GlobalKey<FormState>();

    return Container(
      padding: const EdgeInsets.symmetric(vertical: formHeight - 10.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: controller.name,
              decoration: const InputDecoration(
                label: Text(fullName),
                prefixIcon: Icon(
                  Icons.person_outline_rounded,
                ),
              ),
            ),
            const SizedBox(height: formHeight - 20.0),
            TextFormField(
              controller: controller.email,
              decoration: const InputDecoration(
                label: Text(email),
                prefixIcon: Icon(
                  Icons.email_outlined,
                ),
              ),
            ),
            const SizedBox(height: formHeight - 20.0),
            TextFormField(
              controller: controller.phone,
              decoration: const InputDecoration(
                label: Text(phoneNum),
                prefixIcon: Icon(
                  Icons.numbers,
                ),
              ),
            ),
            const SizedBox(height: formHeight - 20.0),
            TextFormField(
              controller: controller.password,
              obscureText: true,
              decoration: const InputDecoration(
                label: Text(password),
                prefixIcon: Icon(
                  Icons.fingerprint,
                ),
                suffixIcon: IconButton(
                      onPressed: null, icon: Icon(Icons.remove_red_eye_sharp))),
            ),
            const SizedBox(height: formHeight - 10.0),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                  //Email & password Authentication
                  //SignUpController.instance.registerUser(controller.email.text.trim(), controller.password.text.trim());

                  //Phone Authentication
                  //SignUpController.instance.phoneAuthentication(controller.phone.text.trim());
                  //Get.to(() => const OTPScreen());

                  // Get user and pass it to controller
                  final user = UserModel(
                    email: controller.email.text.trim(),
                    password: controller.password.text.trim(),
                    fullName: controller.name.text.trim(),
                    phoneNo: controller.phone.text.trim(),
                  );
                  SignUpController.instance.createUser(user);
                  }
                },
                child: Text(signup.toUpperCase()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
