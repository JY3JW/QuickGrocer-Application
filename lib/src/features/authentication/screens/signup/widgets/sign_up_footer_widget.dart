import 'package:flutter/material.dart';
import 'package:quickgrocer_application/src/constants/colors.dart';
import 'package:quickgrocer_application/src/constants/image_strings.dart';
import 'package:quickgrocer_application/src/constants/sizes.dart';
import 'package:quickgrocer_application/src/constants/text_strings.dart';
import 'package:quickgrocer_application/src/features/authentication/screens/login/login_screen.dart';

class SignUpFooterWidget extends StatelessWidget {
  const SignUpFooterWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text("OR"),
        const SizedBox(height: formHeight - 20.0,),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: () {}, 
            icon: const Image(image: AssetImage(googleLogoImage), width: 20.0,),
            label: const Text(signInWithGoogle),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const LoginScreen()),
            );
          },
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: alreadyHaveAnAccount, style: Theme.of(context).textTheme.bodyLarge,
                ),
                TextSpan(
                  text: login.toUpperCase(), 
                  style: const TextStyle(color: AppColors.subDarkerLimeColor)
                ),
              ]
            )
          ),
        ),
      ]
    );
  }
}
