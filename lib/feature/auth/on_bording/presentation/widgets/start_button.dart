import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:telegram/core/routes/app_router.dart';
import 'package:telegram/core/utililes/app_colors/app_colors.dart';
import 'package:telegram/core/utililes/app_strings/app_strings.dart';
class StartButton extends StatelessWidget {
  const StartButton({
    super.key,
    required this.width,
  });

  final double width;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: ElevatedButton(

        onPressed: () {
         context.go(AppRouter.kLogin);

        },
        style: ElevatedButton.styleFrom(
          backgroundColor:AppColors.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          padding: (width <= 550)
              ? const EdgeInsets.symmetric(horizontal: 100, vertical: 20)
              : EdgeInsets.symmetric(horizontal: width * 0.2, vertical: 25),
         
        ),
        child: const Text(
          AppStrings.start,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
