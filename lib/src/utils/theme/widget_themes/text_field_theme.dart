import 'package:flutter/material.dart';
import 'package:quickgrocer_application/src/constants/colors.dart';

class TextFormFieldTheme {
  TextFormFieldTheme._();

  static InputDecorationTheme lightInputDecorationTheme =
      const InputDecorationTheme(
        border: OutlineInputBorder(),
        prefixIconColor: AppColors.mainPineColor,
        floatingLabelStyle: TextStyle(color: AppColors.mainPineColor),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 2, color: AppColors.mainPineColor),
        ),
      );

  static InputDecorationTheme darkInputDecorationTheme =
      const InputDecorationTheme(
        border: OutlineInputBorder(),
        prefixIconColor: AppColors.subPistachioColor,
        floatingLabelStyle: TextStyle(color: AppColors.subPistachioColor),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 2, color: AppColors.subPistachioColor),
        ),
      );
}
