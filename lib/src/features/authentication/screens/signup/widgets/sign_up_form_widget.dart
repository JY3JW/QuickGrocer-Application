import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickgrocer_application/src/constants/sizes.dart';
import 'package:quickgrocer_application/src/constants/text_strings.dart';
import 'package:quickgrocer_application/src/features/authentication/controllers/signup_controller.dart';

class SignUpFormWidget extends StatelessWidget {
  const SignUpFormWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignUpController());
    final _formKey = GlobalKey<FormState>();

    return Container(
      key: _formKey,
      padding: const EdgeInsets.symmetric(vertical: formHeight - 10.0),
      child: Form(
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
              decoration: const InputDecoration(
                label: Text(password),
                prefixIcon: Icon(
                  Icons.fingerprint,
                ),
              ),
            ),
            const SizedBox(height: formHeight - 10.0),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    SignUpController.instance.registerUser(controller.email.text.trim(), controller.password.text.trim());
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
