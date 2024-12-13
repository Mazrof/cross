import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:telegram/core/utililes/app_colors/app_colors.dart';

class CSnackBar {
  static void showSuccessSnackBar(
      BuildContext context, String title, String message) {
    final snackBar = SnackBar(
      content: Row(
        children: [
          const Icon(Icons.check_circle, color: Colors.white),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              '$title: $message',
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      backgroundColor: AppColors.primaryColor.withOpacity(0.5),
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static void showErrorSnackBar(
      BuildContext context, String title, String message) {
    final snackBar = SnackBar(
      content: Row(
        children: [
          const Icon(Icons.error, color: Colors.white),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              '$title: $message',
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.red.withOpacity(0.5),
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static void showErrorDialog(
      BuildContext context, String message, Function onConfirm) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).textTheme.bodyLarge!.color ==
                  AppColors.whiteColor
              ? AppColors.blackColor
              : AppColors.whiteColor,
          title: Text('Error',
              style: Theme.of(context).textTheme.bodyLarge!.apply(
                    color: AppColors.errorColor,
                  )),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.error,
                color: Theme.of(context).textTheme.bodyLarge!.color,
                size: 40,
              ),
              const SizedBox(height: 10),
              Text(
                message,
                style: Theme.of(context).textTheme.bodySmall,
                textAlign: TextAlign.center,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                GoRouter.of(context).pop(); // Close the dialog
              },
              child: const Text('Close',
                  style: TextStyle(color: AppColors.primaryColor)),
            ),
            TextButton(
              onPressed: () {
                onConfirm();
                GoRouter.of(context).pop(); // Close the dialog
                GoRouter.of(context).pop(); // Close the dialog
              },
              child: const Text('Confirm',
                  style: TextStyle(color: AppColors.primaryColor)),
            ),
          ],
        );
      },
    );
  }
}
