import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:telegram/core/component/csnack_bar.dart';
import 'package:telegram/core/component/clogo_loader.dart';
import 'package:telegram/core/di/service_locator.dart';
import 'package:telegram/core/local/hive.dart';
import 'package:telegram/core/routes/app_router.dart';
import 'package:telegram/core/utililes/app_colors/app_colors.dart';
import 'package:telegram/core/utililes/app_sizes/app_sizes.dart';
import 'package:telegram/core/utililes/app_strings/app_strings.dart';
import 'package:telegram/core/validator/app_validator.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:telegram/feature/auth/verify_mail/presetnation/controller/verfiy_mail_cubit.dart';
import 'package:telegram/feature/auth/verify_mail/presetnation/controller/verfiy_mail_state.dart';

class VerifyMailScreen extends StatelessWidget {
  final String method;

  const VerifyMailScreen({super.key, required this.method});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VerifyMailCubit, VerifyMailState>(
        builder: (context, state) {
      if (state.status == VerifyMailStatus.success) {
        CSnackBar.showSuccessSnackBar(
            context, 'Mail Verified', AppStrings.mailVerified);
        context.go(AppRouter.kLogin);
      } else if (state.status == VerifyMailStatus.error) {
        CSnackBar.showErrorSnackBar(context, 'Error', state.errorMessage!);
      } else if (state.status == VerifyMailStatus.optSent) {
        CSnackBar.showSuccessSnackBar(
            context, 'Mail Sent', AppStrings.codeSent);
      } else if (state.status == VerifyMailStatus.loading) {
        return LogoLoader();
      }

      return VerifyMailPage(method: method);
    });
  }
}

class VerifyMailPage extends StatelessWidget {
  const VerifyMailPage({
    required this.method,
    super.key,
  });
  final method;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
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
                padding: const EdgeInsets.all(AppSizes.padding),
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
                // TODO :Get mail from user data
                maskEmail(HiveCash.read<String>(
                    boxName: "register_info", key: method)!),
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
                  onPressed: () {
                    sl<VerifyMailCubit>().verifyMail(context);
                  },
                  child: const Text(AppStrings.verify),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () {
                    if (method == 'email') {
                      final email =
                          HiveCash.read(boxName: "register_info", key: 'email');
                      sl<VerifyMailCubit>().sendVerificationMail(method, email);
                    } else if (method == 'phone') {
                      final phone =
                          HiveCash.read(boxName: "register_info", key: 'phone');
                      sl<VerifyMailCubit>().sendVerificationMail(method, phone);
                    }
                  },
                  child: Text(AppStrings.resendCode,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .apply(color: AppColors.primaryColor)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
