import 'package:flutter/material.dart';
import 'package:quickgrocer_application/src/constants/image_strings.dart';
import 'package:quickgrocer_application/src/constants/sizes.dart';
import 'package:quickgrocer_application/src/constants/text_strings.dart';

class LoginFooterWidget extends StatelessWidget {
  const LoginFooterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text("OR"),
        const SizedBox(height: formHeight - 20.0,),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
              icon: const Image(image: AssetImage(googleLogoImage), width: 20.0,),
              onPressed: () {}, 
              label: const Text(signInWithGoogle),
            ),
        ),
        const SizedBox(height: formHeight - 20.0,),
        TextButton(
          onPressed: () {},
          child: Text.rich(
            TextSpan(
              text: dontHaveAnAccount,
              style: Theme.of(context).textTheme.bodyLarge,
              children: const [
                TextSpan(
                  text: signup,
                  style: TextStyle(color: Colors.blue)
                ),
              ]
            )
          ),
        ),
      ],
    );
  }
}