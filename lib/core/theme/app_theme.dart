import 'package:flutter/material.dart';
import 'package:telegram/core/theme/app_bottom_sheet_theme.dart';
import 'package:telegram/core/theme/app_check_box_theme.dart';
import 'package:telegram/core/theme/app_chip_theme.dart';
import 'package:telegram/core/theme/app_text_feild_theme.dart';
import 'package:telegram/core/theme/app_text_theme.dart';
import 'app_button_theme.dart';
import 'app_bar_theme.dart';
import 'app_outlined_button_theme.dart';

class TAppTheme {
  TAppTheme._();

  ///--- Light and Dark Themes
  ///--- Light Theme

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Roboto',
    brightness: Brightness.light,
    scaffoldBackgroundColor: const Color(0xffF4F4F4),
    primaryColor: const Color(0xff27A7E7),
    textTheme: AppTextTheme.lightTextTheme,
    elevatedButtonTheme: AppButtonTheme.lightElevatedButtonTheme,
    inputDecorationTheme: TAppTextFieldTheme.lightTheme,
    appBarTheme: TAppBarTheme.lightAppBarTheme,
    bottomSheetTheme: TAppBottomSheetTheme.lightBottomSheetTheme,
    checkboxTheme: TAppCheckBoxTheme.lightCheckBoxTheme,
    outlinedButtonTheme: AppOutlinedButtonTheme.lightOutlinedButtonThemeData,
    chipTheme: TAppChipTheme.lightChipTheme,
  );

  ///--- Dark Theme
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Roboto',
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.black,
    primaryColor: const Color(0xff27A7E7),
    textTheme: AppTextTheme.darkTextTheme,
    elevatedButtonTheme: AppButtonTheme.darkElevatedButtonTheme,
    inputDecorationTheme: TAppTextFieldTheme.darkTheme,
    appBarTheme: TAppBarTheme.darkAppBarTheme,
    bottomSheetTheme: TAppBottomSheetTheme.darkBottomSheetTheme,
    checkboxTheme: TAppCheckBoxTheme.darkCheckBoxTheme,
    outlinedButtonTheme: AppOutlinedButtonTheme.darkOutlinedButtonThemeData,
    chipTheme: TAppChipTheme.darkChipTheme,
  );
}
