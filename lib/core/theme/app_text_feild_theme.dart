import 'package:flutter/material.dart';
import 'package:telegram/core/utililes/app_colors/app_colors.dart';

class TAppTextFieldTheme {
  TAppTextFieldTheme._();
  //light theme

  static InputDecorationTheme lightTheme = InputDecorationTheme(
    errorMaxLines: 3,
    labelStyle: const TextStyle().copyWith(color:AppColors.primaryColor, fontSize: 14),
    hintStyle: const TextStyle().copyWith(color: AppColors.hintTextColor, fontSize: 14),
    errorStyle: const TextStyle().copyWith(color: Colors.red, fontSize: 12),
    floatingLabelStyle: const TextStyle()
        .copyWith(color: Colors.black.withOpacity(.8), fontSize: 14),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(color: AppColors.hintTextColor, width: 1),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(color: AppColors.primaryColor, width: 1),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(color: AppColors.primaryColor, width: 1),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(color: AppColors.errorColor, width: 1),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(color:AppColors.orangeColor, width: 1),
    ),
  );

  //dark theme
  static InputDecorationTheme darkTheme = InputDecorationTheme(
    errorMaxLines: 3,
    labelStyle: const TextStyle().copyWith(color: AppColors.primaryColor, fontSize: 14),
    hintStyle: const TextStyle().copyWith(color:  AppColors.hintTextColor, fontSize: 14),
    errorStyle: const TextStyle().copyWith(color: Colors.red, fontSize: 12),
    floatingLabelStyle: const TextStyle()
        .copyWith(color: Colors.white.withOpacity(.8), fontSize: 14),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(color: AppColors.hintTextColor, width: 1),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(color:AppColors.primaryColor, width: 1),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(color:AppColors.primaryColor, width: 1),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(color:   AppColors.errorColor, width: 1),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(color:AppColors.orangeColor, width: 1),
    ),
  );
}
