import 'package:flutter/material.dart';
import 'package:quickgrocer_application/src/constants/sizes.dart';
import 'package:quickgrocer_application/src/constants/text_strings.dart';

class SignUpFormWidget extends StatelessWidget {
  const SignUpFormWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          const EdgeInsets.symmetric(vertical: formHeight - 10.0),
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              decoration: const InputDecoration(
                label: Text(fullName),
                prefixIcon: Icon(Icons.person_outline_rounded,),
              ),
            ),
            const SizedBox(height: formHeight - 20.0),
            TextFormField(
              decoration: const InputDecoration(
                label: Text(email),
                prefixIcon: Icon(Icons.email_outlined,),
              ),
            ),
            const SizedBox(height: formHeight - 20.0),
            TextFormField(
              decoration: const InputDecoration(
                label: Text(phoneNum),
                prefixIcon: Icon(Icons.numbers,),
              ),
            ),
            const SizedBox(height: formHeight - 20.0),
            TextFormField(
              decoration: const InputDecoration(
                label: Text(password),
                prefixIcon: Icon(Icons.fingerprint,),
              ),
            ),
            const SizedBox(height: formHeight - 10.0),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                child: Text(signup.toUpperCase()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
