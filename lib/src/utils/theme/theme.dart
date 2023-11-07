import 'package:flutter/material.dart';
import 'package:quickgrocer_application/src/constants/colors.dart';
import 'package:quickgrocer_application/src/utils/theme/widget_themes/text_field_theme.dart';
import 'package:quickgrocer_application/src/utils/theme/widget_themes/text_theme.dart';

class AppTheme {
  AppTheme._(); // ._ means it is private Constructor

  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSeed(seedColor: AppColors.mainPineColor),
    textTheme: TTextTheme.lightTextTheme,
    //elevatedButtonTheme: TElevatedButtonTheme.lightElevatedButtonTheme,
    //outlinedButtonTheme: TOutlinedButtonTheme.lightOutlinedButtonTheme,
    inputDecorationTheme: TextFormFieldTheme.lightInputDecorationTheme,
  );

  static ThemeData darkTheme = ThemeData(
    colorScheme: ColorScheme.fromSwatch().copyWith(secondary: AppColors.subPistachioColor, 
              brightness: Brightness.dark),
    textTheme: TTextTheme.darkTextTheme,
    //elevatedButtonTheme: TElevatedButtonTheme.darkElevatedButtonTheme,
    //outlinedButtonTheme: TOutlinedButtonTheme.darkOutlinedButtonTheme,
    inputDecorationTheme: TextFormFieldTheme.darkInputDecorationTheme,
  );
}
