import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:telegram/core/routes/app_router.dart';
import 'package:telegram/core/utililes/app_colors/app_colors.dart';
import 'package:telegram/core/utililes/app_strings/app_strings.dart';

class CreateAccount extends StatelessWidget {
  const CreateAccount({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(AppStrings.dontHaveAccount,
            style: Theme.of(context).textTheme.bodySmall),
        TextButton(
            onPressed: () {
              context.go(AppRouter.kSignUp);
            },
            child: const Text(
              AppStrings.signUp,
              style: TextStyle(fontSize: 14, color: AppColors.primaryColor),
            )),
      ],
    );
  }
}
