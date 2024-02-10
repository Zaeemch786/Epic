import 'package:ecommerce_app/utills/theme/custom_themes/app_bar_theme.dart';
import 'package:ecommerce_app/utills/theme/custom_themes/bottom_sheet_theme.dart';
import 'package:ecommerce_app/utills/theme/custom_themes/check_box_theme.dart';
import 'package:ecommerce_app/utills/theme/custom_themes/chip_theme.dart';
import 'package:ecommerce_app/utills/theme/custom_themes/elevated_button_theme.dart';
import 'package:ecommerce_app/utills/theme/custom_themes/outline_button_theme.dart';
import 'package:ecommerce_app/utills/theme/custom_themes/text_field_theme.dart';
import 'package:ecommerce_app/utills/theme/custom_themes/text_theme.dart';
import 'package:flutter/material.dart';

class TAppTheme {
  TAppTheme._();
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.light,
    primaryColor: Colors.blue,
    scaffoldBackgroundColor: Colors.white,
    textTheme: TTextTheme.lightTextTheme,
    chipTheme: TChipTheme.lightChipTheme,
    appBarTheme: TAppBarTheme.lightAppBarTheme,
    checkboxTheme: TCheckBoxTheme.lightCheckBTheme,
    bottomSheetTheme: TBottomSheetTheme.lightBottomSheetTheme,
    elevatedButtonTheme: TELevatedButtonTheme.lightElevatedButtonTheme,
    outlinedButtonTheme: TOutLineButtonTheme.lightOutLineButtonTheme,
    inputDecorationTheme: TTextFormFieldTheme.lightInputDecorationTheme,
  );
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.dark,
    primaryColor: Colors.blue,
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: TAppBarTheme.darkAppBarTheme,
    textTheme: TTextTheme.darkTextTheme,
    chipTheme: TChipTheme.darkChipTheme,
    checkboxTheme: TCheckBoxTheme.darkCheckBTheme,
    bottomSheetTheme: TBottomSheetTheme.darkBottomSheetTheme,
    outlinedButtonTheme: TOutLineButtonTheme.darkOutLineButtonTheme,
    elevatedButtonTheme: TELevatedButtonTheme.darkElevatedButtonTheme,
    inputDecorationTheme: TTextFormFieldTheme.darkInputDecorationTheme,
  );
}
