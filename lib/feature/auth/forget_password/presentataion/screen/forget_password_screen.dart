import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:telegram/core/component/capp_bar.dart';
import 'package:telegram/core/component/clogo_loader.dart';
import 'package:telegram/core/component/csnack_bar.dart';
import 'package:telegram/core/di/service_locator.dart';
import 'package:telegram/core/routes/app_router.dart';
import 'package:telegram/core/utililes/app_colors/app_colors.dart';
import 'package:telegram/core/utililes/app_enum/app_enum.dart';
import 'package:telegram/core/utililes/app_sizes/app_sizes.dart';
import 'package:telegram/core/utililes/app_strings/app_strings.dart';
import 'package:telegram/feature/auth/forget_password/presentataion/controller/forgegt_password_controller/forget_password_cubit.dart';
import 'package:telegram/feature/auth/forget_password/presentataion/controller/forgegt_password_controller/forget_password_state.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ForgetPasswordCubit, ForgetPasswordState>(
      builder: (context, state) {
        if (state.status == CubitState.loading) {
          return const LogoLoader();
        } else if (state.status == CubitState.success) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            CSnackBar.showSuccessSnackBar(
                context, 'Mail Sent', AppStrings.resetPasswordMailSent);
          });
        } else if (state.status == CubitState.failure) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            CSnackBar.showErrorSnackBar(context, 'Error', state.errorMessage!);
          });
        }
        return ForgetPasswordPage();
      },
    );
  }
}

class ForgetPasswordPage extends StatelessWidget {
  const ForgetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CAppBar(
        showBackButton: true,
        onLeadingTap: () {
          context.go(AppRouter.kLogin);
        },
        actions: [],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(AppSizes.padding),
            child: Padding(
              padding: const EdgeInsets.all(AppSizes.padding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: AppSizes.sm),
                      Text(AppStrings.forgetPasswordTitle,
                          style: Theme.of(context).textTheme.headlineLarge),
                      const SizedBox(height: AppSizes.sm),
                      Text(AppStrings.forgetPasswordSubTitle,
                          style: Theme.of(context).textTheme.bodySmall),
                    ],
                  ),
                  const SizedBox(height: AppSizes.spaceBetweenInputField),
                  Form(
                    key: context.read<ForgetPasswordCubit>().formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: 
                              sl<ForgetPasswordCubit>()
                              .emailController,
                          key:   sl<ForgetPasswordCubit>().emailKey,
                          style: Theme.of(context).textTheme.bodySmall,
                          decoration: InputDecoration(
                            hintStyle: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .apply(color: AppColors.grey),
                            labelText: AppStrings.email,
                            hintText: AppStrings.email,
                            prefixIcon: const Icon(Iconsax.direct_right),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: AppSizes.xl),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                               sl<ForgetPasswordCubit>()
                                  .sendResetLink();
                            },
                            child: const Text(
                              AppStrings.resetPassword,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
