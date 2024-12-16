import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:telegram/core/component/Capp_bar.dart';
import 'package:telegram/core/routes/app_router.dart';
import 'package:telegram/core/utililes/app_assets/assets_strings.dart';
import 'package:telegram/core/utililes/app_colors/app_colors.dart';
import 'package:telegram/core/utililes/app_sizes/app_sizes.dart';
import 'package:telegram/core/utililes/app_strings/app_strings.dart';

class PreVerifyScreen extends StatelessWidget {
  const PreVerifyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CAppBar(
        showBackButton: true,
        onLeadingTap: () {
          GoRouter.of(context).pop();
        },
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.padding * 2),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image: AssetImage(AppAssetsStrings.verifyMail),
                height: 400,
              ),
              SizedBox(
                height: AppSizes.md,
              ),
              Text(
                AppStrings.chooseVerifyMethodTitle,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              SizedBox(
                height: AppSizes.md,
              ),
              Text(
                AppStrings.chooseVerifyMethodSubTitle,
                style: Theme.of(context).textTheme.bodySmall,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: AppSizes.md,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => GoRouter.of(context)
                      .push(AppRouter.kVerifyMail, extra: {'method': 'email'}),
                  child: Text(AppStrings.verifyByMail),
                ),
              ),
              SizedBox(
                height: AppSizes.md,
              ),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => GoRouter.of(context)
                      .push(AppRouter.kVerifyMail, extra: {'method': 'phone'}),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(
                        color: AppColors.primaryColor), // Set the border color
                  ),
                  child: Text(
                    AppStrings.verifyByPhone,
                    style: TextStyle(color: AppColors.primaryColor),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
