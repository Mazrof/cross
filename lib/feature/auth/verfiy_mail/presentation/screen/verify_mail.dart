import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:telegram/core/component/capp_bar.dart';
import 'package:telegram/core/routes/app_router.dart';
import 'package:telegram/core/utililes/app_colors/app_colors.dart';
import 'package:telegram/core/utililes/app_sizes/app_sizes.dart';
import 'package:telegram/core/utililes/app_strings/app_strings.dart';
import 'package:telegram/core/validator/app_validator.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerifyMailScreen extends StatelessWidget {
  final String email;

  const VerifyMailScreen({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CAppBar(
        onLeadingTap: () {
          context.go(AppRouter.kLogin);
        },
        showBackButton: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSizes.padding),
        child: Center(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(AppSizes.padding),
                child: Icon(
                  Icons.email_outlined,
                  size: 150,
                  color: AppColors.primaryColor,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(AppSizes.padding),
                child: Text(
                  AppStrings.checkYourEmail,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              Text(
                AppStrings.weSentYouAnEmail,
                style: Theme.of(context).textTheme.bodySmall,
              ),
              Text(
                maskEmail(email),
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .apply(color: AppColors.grey),
              ),
              Container(
                width: 250,
                margin: const EdgeInsets.all(AppSizes.verifyPadding),
                child: PinCodeTextField(
                  appContext: context,
                  length: 5,
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius:
                        BorderRadius.circular(AppSizes.borderRadiusMd),
                    inactiveColor: AppColors.grey.withOpacity(.8),
                    selectedColor: AppColors.primaryColor,
                  ),
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  onChanged: (value) {},
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text(AppStrings.verify),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () {},
                  child: Text(AppStrings.resendCode,
                      style: Theme.of(context).textTheme.bodySmall!.apply(color: AppColors.primaryColor)),
                ),
              ),
            ],
          ),
        ),  
      ),
    );
  }
}
