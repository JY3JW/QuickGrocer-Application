import 'package:flutter/material.dart';
import 'package:quickgrocer_application/src/constants/image_strings.dart';
import 'package:quickgrocer_application/src/constants/text_strings.dart';

class LoginHeaderWidget extends StatelessWidget {
  const LoginHeaderWidget({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image(
          image: AssetImage(welcomeScreenImage),
          height: size.height * 0.2,
        ),
        Text(loginTitle, style: Theme.of(context).textTheme.headlineLarge),
        Text(loginSubtitle, style: Theme.of(context).textTheme.bodyLarge),
      ],
    );
  }
}
