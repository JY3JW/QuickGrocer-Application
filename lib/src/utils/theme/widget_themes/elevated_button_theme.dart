import 'package:flutter/material.dart';
import 'package:quickgrocer_application/src/constants/colors.dart';
import 'package:quickgrocer_application/src/constants/sizes.dart';

class TElevatedButtonTheme {
  TElevatedButtonTheme._();

  static final lightElevatedButtonTheme =
      ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          foregroundColor: Colors.white,
          backgroundColor: AppColors.mainPineColor,
          side:  BorderSide(color: const Color.fromARGB(255, 32, 71, 27)),
          padding: EdgeInsets.symmetric(vertical: buttonHeight),
        ),
      );
  
  static final darkElevatedButtonTheme =
      ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          foregroundColor: AppColors.subPistachioColor,
          backgroundColor: Colors.black,
          side:  BorderSide(color: Colors.black),
          padding: EdgeInsets.symmetric(vertical: buttonHeight),
        ),
      );
}
