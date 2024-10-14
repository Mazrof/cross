import 'package:flutter/material.dart';
import 'package:telegram/core/utililes/app_colors/app_colors.dart';

class TAppChipTheme {
  TAppChipTheme._();
  // Light Theme
  static ChipThemeData lightChipTheme = ChipThemeData(
    disabledColor:   AppColors.grey.withOpacity(.4),
    labelStyle: const TextStyle(
      color:  AppColors.blackColor,
    ),
    selectedColor: AppColors.primaryColor,
    padding: const EdgeInsets.all(12),
    checkmarkColor: AppColors.whiteColor,
  );

  // Dark Theme

  static ChipThemeData darkChipTheme = ChipThemeData(
    disabledColor:AppColors.grey.withOpacity(.4),
    labelStyle: const TextStyle(
      color: AppColors.whiteColor,
    ),
    selectedColor: AppColors.primaryColor,
    padding: const EdgeInsets.all(12),
    checkmarkColor: AppColors.whiteColor,
  );
}
