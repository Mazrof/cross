import 'package:flutter/material.dart';
import 'package:telegram/core/utililes/app_assets/assets_strings.dart';
import 'package:telegram/core/utililes/app_sizes/app_sizes.dart';
import 'package:telegram/core/utililes/app_strings/app_strings.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: AppSizes.sm),
        Image.asset(AppAssetsStrings.loginLogo, width: 150, height: 150),
        const SizedBox(height: AppSizes.sm),
        Text(AppStrings.loginTitle,
            style: Theme.of(context).textTheme.headlineLarge),
        const SizedBox(height: AppSizes.sm),
        Text(AppStrings.loginSubTitle,
            style: Theme.of(context).textTheme.bodyMedium),
      ],
    );
  }
}
