  import 'package:flutter/material.dart';
  import 'package:flutter/services.dart';
  import 'package:flutter_bloc/flutter_bloc.dart';
  import 'package:go_router/go_router.dart';
  import 'package:telegram/core/component/capp_bar.dart';
  import 'package:telegram/core/component/csnack_bar.dart';
  import 'package:telegram/core/component/clogo_loader.dart';
  import 'package:telegram/core/di/service_locator.dart';
  import 'package:telegram/core/local/hive.dart';
  import 'package:telegram/core/routes/app_router.dart';
  import 'package:telegram/core/utililes/app_colors/app_colors.dart';
  import 'package:telegram/core/utililes/app_sizes/app_sizes.dart';
  import 'package:telegram/core/utililes/app_strings/app_strings.dart';
  import 'package:pin_code_fields/pin_code_fields.dart';
  import 'package:telegram/core/validator/app_validator.dart';
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
          Future.delayed(Duration.zero, () {
            CSnackBar.showSuccessSnackBar(
                context, 'Mail Verified', AppStrings.mailVerified);
            context.go(AppRouter.kLogin);
          });
        } else if (state.status == VerifyMailStatus.error) {
          Future.delayed(Duration.zero, () {
            CSnackBar.showErrorSnackBar(context, 'Error', state.errorMessage!);
          });
        } else if (state.status == VerifyMailStatus.optSent) {
          Future.delayed(Duration.zero, () {
            CSnackBar.showSuccessSnackBar(
                context, 'Mail Sent', AppStrings.codeSent);
          });
        } else if (state.status == VerifyMailStatus.loading) {
          return LogoLoader();
        }

        return VerifyMailPage(method: method);
      });
    }
  }

  class VerifyMailPage extends StatefulWidget {
    const VerifyMailPage({
      required this.method,
      super.key,
    });
    final String method;

    @override
    _VerifyMailPageState createState() => _VerifyMailPageState();
  }

  class _VerifyMailPageState extends State<VerifyMailPage> {
    late TextEditingController _otpController;

    @override
    void initState() {
      super.initState();
      _otpController = TextEditingController();
    }

    @override
    void dispose() {
      _otpController.dispose();
      super.dispose();
    }

    @override
    Widget build(BuildContext context) {
      final mail =
          HiveCash.read<String>(boxName: "register_info", key: widget.method)!;

      return Scaffold(
        
        appBar: CAppBar(
          title: Text(''),
          leadingIcon: Icons.arrow_back,
          onLeadingTap: () {
            context.go(AppRouter.kPreVerify);
          },
        ),
        //wrap with form 

        
        body: Form(
          key: sl<VerifyMailCubit>().formKey,

          child: Padding(
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
                    child: Column(
                      children: [
                        if (widget.method == 'email')
                          Text(
                            AppStrings.verifyByMail,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        if (widget.method == 'phone')
                          Text(
                            AppStrings.verifyByPhone,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                      ],
                    ),
                  ),
                  if (widget.method == 'email')
                    Text(
                      AppStrings.weSentYouAnEmail,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  if (widget.method == 'phone')
                    Text(
                      AppStrings.weSentYouAnSms,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  Text(
                    widget.method == 'email' ? maskEmail(mail) : '',
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .apply(color: AppColors.grey),
                  ),
                  Container(
                    margin: const EdgeInsets.all(AppSizes.verifyPadding),
                    child: PinCodeTextField(
                      appContext: context,
                      length: 6,
                      controller: _otpController,
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius:
                            BorderRadius.circular(AppSizes.borderRadiusMd),
                        inactiveColor: AppColors.grey.withOpacity(.8),
                        selectedColor: AppColors.primaryColor,
                      ),
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      onChanged: (value) {
                        print(value);
                      },
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        final otpCode = _otpController.text.trim();
                        if (otpCode.isEmpty) {
                          CSnackBar.showErrorSnackBar(
                              context, 'Error', 'Please enter the OTP code.');
                          return;
                        }
                        sl<VerifyMailCubit>().verifyOtp(
                          widget.method,
                          mail,
                          otpCode,
                        );
                      },
                      child: const Text(AppStrings.verify),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      onPressed: () {
                        sl<VerifyMailCubit>()
                            .sendVerificationMail(widget.method, mail);
                      },
                      child: Text(AppStrings.resendCode,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .apply(color: AppColors.primaryColor)),
                    ),
                  ),
                  SizedBox(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        BlocBuilder<VerifyMailCubit, VerifyMailState>(
                          builder: (context, state) {
                            return Text(
                              state.remainingTime.toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .apply(color: AppColors.primaryColor),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
  }
