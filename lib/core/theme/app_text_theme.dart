import 'package:flutter/material.dart';
import 'package:telegram/core/utililes/app_colors/app_colors.dart';

class AppTextTheme {
  AppTextTheme._();

  // Light Theme
  static const TextTheme lightTextTheme = TextTheme(
    bodyLarge: TextStyle(
        fontSize: 22, color:AppColors.blackColor, fontWeight: FontWeight.bold),
    bodyMedium: TextStyle(
        fontSize: 18, color:AppColors.blackColor, fontWeight: FontWeight.w700),
    bodySmall: TextStyle(
        fontSize: 15, color:AppColors.blackColor, fontWeight: FontWeight.w400),


    headlineLarge: TextStyle(
        fontSize: 30, color:AppColors.blackColor, fontWeight: FontWeight.bold),
    headlineMedium: TextStyle(
        fontSize: 26, color:AppColors.blackColor, fontWeight: FontWeight.w700),
    headlineSmall: TextStyle(
        fontSize: 20, color:AppColors.blackColor, fontWeight: FontWeight.w400),


    titleLarge: TextStyle(
        fontSize: 22, color:AppColors.blackColor, fontWeight: FontWeight.bold),
    titleMedium: TextStyle(
        fontSize: 18, color:AppColors.blackColor, fontWeight: FontWeight.w700),
    titleSmall: TextStyle(
        fontSize: 16, color:AppColors.blackColor, fontWeight: FontWeight.w400),

    labelLarge: TextStyle(
        fontSize: 18, color:AppColors.blackColor, fontWeight: FontWeight.bold),
    labelMedium: TextStyle(
        fontSize: 16, color:AppColors.blackColor, fontWeight: FontWeight.w700),
    labelSmall: TextStyle(
        fontSize: 14, color:AppColors.blackColor, fontWeight: FontWeight.w400),
    displayLarge: TextStyle(
        fontSize: 22, color:AppColors.blackColor, fontWeight: FontWeight.bold),
    displayMedium: TextStyle(
        fontSize: 20, color:AppColors.blackColor, fontWeight: FontWeight.w700),
    displaySmall: TextStyle(
        fontSize: 18, color:AppColors.blackColor, fontWeight: FontWeight.w400),
  );

  // Dark Theme

  static const TextTheme darkTextTheme = TextTheme(
    bodyLarge: TextStyle(
        fontSize: 22, color: AppColors.whiteColor, fontWeight: FontWeight.bold),
    bodyMedium: TextStyle(
        fontSize: 18, color: AppColors.whiteColor, fontWeight: FontWeight.w700),
    bodySmall: TextStyle(
        fontSize: 15, color: AppColors.whiteColor, fontWeight: FontWeight.w400),

    titleLarge: TextStyle(
        fontSize: 22  ,  color: AppColors.whiteColor, fontWeight: FontWeight.bold),
    titleMedium: TextStyle(
        fontSize: 18, color: AppColors.whiteColor, fontWeight: FontWeight.w700),
    titleSmall: TextStyle(
        fontSize: 16, color: AppColors.whiteColor, fontWeight: FontWeight.w300),

    labelLarge: TextStyle(
        fontSize: 18, color: AppColors.whiteColor, fontWeight: FontWeight.bold),
    labelMedium: TextStyle(
        fontSize: 16, color: AppColors.whiteColor, fontWeight: FontWeight.w700),
    labelSmall: TextStyle(
        fontSize: 14, color: AppColors.whiteColor, fontWeight: FontWeight.w400),
    displayLarge: TextStyle(
        fontSize: 22, color: AppColors.whiteColor, fontWeight: FontWeight.bold),
    displayMedium: TextStyle(
        fontSize: 20, color: AppColors.whiteColor, fontWeight: FontWeight.w700),
    displaySmall: TextStyle(
        fontSize: 18, color: AppColors.whiteColor, fontWeight: FontWeight.w400),


    headlineLarge: TextStyle(
      fontSize: 30,
      color: AppColors.whiteColor,
    ),
    headlineMedium: TextStyle(
        fontSize: 26, color: AppColors.whiteColor, fontWeight: FontWeight.w700),
    headlineSmall: TextStyle(
        fontSize: 20, color: AppColors.whiteColor, fontWeight: FontWeight.w400),
  );
}
