import 'package:flutter/material.dart';
import 'package:quickgrocer_application/src/constants/sizes.dart';

class FormHeaderWidget extends StatelessWidget {
  const FormHeaderWidget({
    super.key,
    required this.image,
    required this.title,
    required this.subTitle,
  });

  final String image, title, subTitle;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SizedBox(
      width: double.infinity,
      child:
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image(
              image: AssetImage(image),
              height: size.height * 0.2,
            ),
            const SizedBox(height: formHeight - 10.0,),
            Text(title, style: Theme.of(context).textTheme.headlineLarge),
            Text(subTitle, style: Theme.of(context).textTheme.bodyLarge),
          ],
        ),
    );
  }
}
