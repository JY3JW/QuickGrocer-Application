import 'package:flutter/material.dart';
import 'package:quickgrocer_application/src/constants/colors.dart';

class TextFormFieldTheme {
  TextFormFieldTheme._();

  static InputDecorationTheme lightInputDecorationTheme =
      InputDecorationTheme(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(100)),
        prefixIconColor: AppColors.mainPineColor,
        floatingLabelStyle: TextStyle(color: AppColors.mainPineColor),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100),
          borderSide: BorderSide(width: 2, color: AppColors.mainPineColor),
        ),
      );

  static InputDecorationTheme darkInputDecorationTheme =
      InputDecorationTheme(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(100)),
        prefixIconColor: AppColors.subPistachioColor,
        floatingLabelStyle: TextStyle(color: AppColors.subPistachioColor),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100),
          borderSide: BorderSide(width: 2, color: AppColors.subPistachioColor),
        ),
      );
}
