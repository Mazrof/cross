import 'package:flutter/material.dart';
import 'package:telegram/core/utililes/app_colors/app_colors.dart';

class AppButtonTheme {
  AppButtonTheme._();

  // Light Theme
  static final ElevatedButtonThemeData lightElevatedButtonTheme =
      ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: AppColors.whiteColor,
      backgroundColor: AppColors.primaryColor,
      disabledBackgroundColor: AppColors.greyColor,
      disabledForegroundColor: AppColors.greyColor,
      side: const BorderSide(color: AppColors.primaryColor),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),

      textStyle: const TextStyle(
        fontSize: 18,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
  );

  // Dark Theme

  static final ElevatedButtonThemeData darkElevatedButtonTheme =
      ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
        elevation: 0,
        foregroundColor: AppColors.whiteColor,
        backgroundColor: AppColors.primaryColor,
        disabledBackgroundColor:  AppColors.greyColor,
        disabledForegroundColor:  AppColors.greyColor,
        side: const BorderSide(color: AppColors.primaryColor),
        padding: const EdgeInsets.symmetric(horizontal: 18,vertical: 12),

        textStyle: const TextStyle(
          fontSize: 18,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        )),
  );
}
