import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:telegram/core/utililes/app_strings/app_strings.dart';

class ErrorDialog extends StatelessWidget {
  const ErrorDialog(
      {super.key, required this.message, required this.action});

  final String message;
  final Widget action;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      // backgroundColor: AppColors.,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Lottie.asset(AppStrings.errorLottiePath,
              height: 100, repeat: false, frameRate: const FrameRate(90)),
          const Text(
            AppStrings.error,
          ),
          const SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: double.infinity,
              child: Center(
                child: Text(
                  message,
                  style: const TextStyle(
                    // color: AppColors.,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Outfit',
                  ),
                ),
              ),
            ),
          ),
          action
        ],
      ),
    );
  }
}
