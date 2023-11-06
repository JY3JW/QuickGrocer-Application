import 'package:flutter/material.dart';
import 'package:quickgrocer_application/src/constants/sizes.dart';
import 'package:quickgrocer_application/src/constants/text_strings.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: formHeight - 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person_outline_outlined),
                  labelText: email,
                  hintText: email,
                  border: OutlineInputBorder()),
            ),
            const SizedBox(height: formHeight),
            TextFormField(
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.fingerprint),
                  labelText: password,
                  hintText: password,
                  border: OutlineInputBorder(),
                  suffixIcon: IconButton(
                      onPressed: null,
                      icon: Icon(Icons.remove_red_eye_sharp))),
            ),
            const SizedBox(height: formHeight),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {},
                child: Text(forgetPassword),
              ),
            ),
            SizedBox(
              child: ElevatedButton(
                onPressed: () {},
                child: Text(login.toUpperCase()),
              ),
            )
          ],
        ),
      ),
    );
  }
}