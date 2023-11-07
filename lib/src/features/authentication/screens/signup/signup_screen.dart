import 'package:flutter/material.dart';
import 'package:quickgrocer_application/src/common_widgets/form/form_header_widget.dart';
import 'package:quickgrocer_application/src/constants/image_strings.dart';
import 'package:quickgrocer_application/src/constants/sizes.dart';
import 'package:quickgrocer_application/src/constants/text_strings.dart';
import 'package:quickgrocer_application/src/utils/colors.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(defaultSize),
            child: Column(
              children: [
                const FormHeaderWidget(
                    image: welcomeScreenImage,
                    title: signUpTitle,
                    subTitle: signUpSubtitle),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: formHeight - 10.0),
                  child: Form(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          decoration: const InputDecoration(
                            label: Text("Full Name"),
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(
                              Icons.person_outline_rounded,
                              color: Colors.black,
                            ),
                            labelStyle: TextStyle(color: Colors.black),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 2.0, color: AppColors.mainPineColor),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
