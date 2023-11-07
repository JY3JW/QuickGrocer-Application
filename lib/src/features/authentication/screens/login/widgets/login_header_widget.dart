import 'package:flutter/material.dart';
import 'package:quickgrocer_application/src/constants/image_strings.dart';
import 'package:quickgrocer_application/src/constants/sizes.dart';
import 'package:quickgrocer_application/src/constants/text_strings.dart';

class LoginHeaderWidget extends StatelessWidget {
  const LoginHeaderWidget({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child:
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image(
              image: const AssetImage(welcomeScreenImage),
              height: size.height * 0.2,
            ),
            const SizedBox(height: formHeight - 10.0,),
            Text(loginTitle, style: Theme.of(context).textTheme.headlineLarge),
            Text(loginSubtitle, style: Theme.of(context).textTheme.bodyLarge),
          ],
        ),
    );
  }
}
