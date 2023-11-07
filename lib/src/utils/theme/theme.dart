import 'package:flutter/material.dart';
import 'package:quickgrocer_application/src/utils/colors.dart';
import 'package:quickgrocer_application/src/utils/theme/widget_themes/text_theme.dart';

class AppTheme {
  AppTheme._(); // ._ means it is private Constructor

  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primarySwatch: const MaterialColor(0xFF234E1F, <int, Color>{
      50: Color(0x1A234E1F),
      100: Color(0x33234E1F),
      200: Color(0x4D234E1F),
      300: Color(0x66234E1F),
      400: Color(0x80234E1F),
      500: Color(0xFF234E1F),
      600: Color(0x99234E1F),
      700: Color(0xB3234E1F),
      800: Color(0xCC234E1F),
      900: Color(0xE6234E1F),
    }),
    colorScheme: ColorScheme.fromSeed(seedColor: AppColors.mainPineColor),
    textTheme: TTextTheme.lightTextTheme,
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    textTheme: TTextTheme.darkTextTheme,
  );
}
