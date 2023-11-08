import 'package:flutter/material.dart';
import 'package:quickgrocer_application/src/constants/colors.dart';
import 'package:quickgrocer_application/src/constants/sizes.dart';

class TOutlinedButtonTheme {
  TOutlinedButtonTheme._();

  static final lightOutlinedButtonTheme =
      OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          side:  BorderSide(color: Colors.black),
          padding: EdgeInsets.symmetric(vertical: buttonHeight),
        ),
      );
  
  static final darkOutlinedButtonTheme =
      OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          foregroundColor: Colors.black,
          backgroundColor: AppColors.subPistachioColor,
          side:  BorderSide(color: Colors.black),
          padding: EdgeInsets.symmetric(vertical: buttonHeight),
        ),
      );
}
