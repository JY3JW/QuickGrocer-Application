import 'package:flutter/material.dart';
import 'package:quickgrocer_application/src/constants/colors.dart';
import 'package:quickgrocer_application/src/constants/sizes.dart';

class TElevatedButtonTheme {
  TElevatedButtonTheme._();

  static final lightElevatedButtonTheme =
      ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(),
          foregroundColor: Colors.white,
          backgroundColor: Colors.black,
          side:  BorderSide(color: Colors.black),
          padding: EdgeInsets.symmetric(vertical: buttonHeight),
        ),
      );
  
  static final darkElevatedButtonTheme =
      ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(),
          foregroundColor: AppColors.subPistachioColor,
          backgroundColor: Colors.black,
          side:  BorderSide(color: Colors.black),
          padding: EdgeInsets.symmetric(vertical: buttonHeight),
        ),
      );
}
