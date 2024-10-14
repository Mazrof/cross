import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:telegram/core/routes/app_router.dart';
import 'package:telegram/core/utililes/app_colors/app_colors.dart';
import 'package:telegram/core/utililes/app_strings/app_strings.dart';

class GoToLogIn extends StatelessWidget {
  const GoToLogIn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          AppStrings.alreadyHaveAccount,
          style: Theme.of(context).textTheme.bodySmall,
        ),
        TextButton(
          onPressed: () {
            context.go(AppRouter.kLogin);
          },
          child: const Text(
            AppStrings.login,
            style: TextStyle(fontSize: 14, color: AppColors.primaryColor),
          ),
        ),
      ],
    );
  }
}
