import 'package:flutter/material.dart';
import 'package:telegram/core/utililes/app_colors/app_colors.dart';

class TAppBarTheme {
  TAppBarTheme._();

  // Light Theme

  static AppBarTheme lightAppBarTheme = const AppBarTheme(
    centerTitle: false,
    scrolledUnderElevation: 0,
    backgroundColor: Colors.transparent,
    titleSpacing: 0,
    elevation: 0,
    titleTextStyle: TextStyle(
        fontSize: 18, color: AppColors.whiteColor, fontWeight: FontWeight.w600),
    iconTheme: IconThemeData(
      color: AppColors.whiteColor,
      size: 24,
    ),
    actionsIconTheme: IconThemeData(
      color: Colors.white,
      size: 24,
    ),
  );

// Dark Theme

  static AppBarTheme darkAppBarTheme = const AppBarTheme(
    centerTitle: false,
    scrolledUnderElevation: 0,
    backgroundColor: Colors.transparent,
    titleSpacing: 0,
    elevation: 0,
    titleTextStyle: TextStyle(
        fontSize: 18, color: AppColors.whiteColor, fontWeight: FontWeight.w600),
    iconTheme: IconThemeData(
      color: AppColors.whiteColor,
      size: 24,
    ),
    actionsIconTheme: IconThemeData(
      color: Colors.white,
      size: 24,
    ),
  );
}
