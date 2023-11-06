import 'package:flutter/material.dart';
import 'package:quickgrocer_application/src/constants/image_strings.dart';
import 'package:quickgrocer_application/src/constants/sizes.dart';
import 'package:quickgrocer_application/src/constants/text_strings.dart';
import 'package:quickgrocer_application/src/features/authentication/screens/login/login_screen.dart';
import 'package:quickgrocer_application/src/utils/colors.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var height = mediaQuery.size.height;
    var brightness = mediaQuery.platformBrightness;
    final isDarkMode = brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? AppColors.subPistachioColor : AppColors.mainPineColor,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(defaultSize),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Hero(
                tag: 'quickgrocer_logo_tag',
                child: Image(
                  image: const AssetImage(welcomeScreenImage),
                  height: height * 0.6),),
              Column(
                children: [
                  Text(welcomeTitle, style: Theme.of(context).textTheme.displaySmall),
                  Text(welcomeSubtitle,
                      style: Theme.of(context).textTheme.bodyLarge,
                      textAlign: TextAlign.center),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => const LoginScreen()),
                        );
                        print("pushed");
                      },
                      child: Text(login.toUpperCase()),
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text(signup.toUpperCase()),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
