import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:telegram/core/component/csnack_bar.dart';
import 'package:telegram/core/component/logo_loader.dart';
import 'package:telegram/core/di/service_locator.dart';
import 'package:telegram/core/routes/app_router.dart';
import 'package:telegram/core/utililes/app_colors/app_colors.dart';
import 'package:telegram/core/utililes/app_enum/app_enum.dart';
import 'package:telegram/core/utililes/app_sizes/app_sizes.dart';
import 'package:telegram/core/utililes/app_strings/app_strings.dart';
import 'package:telegram/core/validator/app_validator.dart';
import 'package:telegram/feature/auth/forget_password/presentataion/controller/reset_passwrod_controller/reset_password_cubit.dart';
import 'package:telegram/feature/auth/forget_password/presentataion/controller/reset_passwrod_controller/reset_password_state.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = sl<ResetPasswordCubit>();
    return BlocProvider.value(
      value: controller,
      child: BlocBuilder<ResetPasswordCubit, ResetPasswordState>(
        builder: (context, state) {
          if (state.state == ResetPasswordEnum.loading) {
            return const LogoLoader();
          } else if (state.state == ResetPasswordEnum.success) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              context.go(AppRouter.kLogin);
            });
          } else if (state.state == ResetPasswordEnum.failure) {
            // show error message
            WidgetsBinding.instance.addPostFrameCallback((_) {
              CSnackBar.showErrorSnackBar(
                  context, 'Error', state.errorMessage!);
            });
          }
          // Handle other states if necessary
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(AppSizes.padding),
              child: SingleChildScrollView(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(AppSizes.padding),
                    child: Form(
                      key: controller.formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 8),
                              Text(AppStrings.resetPasswordTitle,
                                  style:
                                      Theme.of(context).textTheme.headlineLarge),
                              const SizedBox(height: 8),
                            
                            ],
                          ),
                          const SizedBox(height: AppSizes.xl),
                          TextFormField(
                            style: Theme.of(context).textTheme.bodySmall,
                            key: controller.passwordKey,
                            controller: controller.passwordController,
                            obscureText: !state.isPasswordVisible,
                            decoration: InputDecoration(
                              hintStyle: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .apply(color: AppColors.grey),
                              hintText: AppStrings.passwordHint,
                              labelText: AppStrings.password,
                              prefixIcon: const Icon(Iconsax.password_check),
                              suffixIcon: IconButton(
                                onPressed: controller.togglePasswordVisibility,
                                icon: Icon(state.isPasswordVisible
                                    ? Iconsax.eye
                                    : Iconsax.eye_slash),
                              ),
                            ),
                            validator: validatePassword,
                          ),
                          const SizedBox(height: AppSizes.spaceBetweenInputField),
                          TextFormField(
                            style: Theme.of(context).textTheme.bodySmall,
                            key: controller.confirmPasswordKey,
                            controller: controller.confirmPasswordController,
                            obscureText: !state.isConfirmPasswordVisible,
                            decoration: InputDecoration(
                              hintStyle: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .apply(color: AppColors.grey),
                              hintText: AppStrings.confirmPassword,
                              labelText: AppStrings.confirmPassword,
                              prefixIcon: const Icon(Iconsax.password_check),
                              suffixIcon: IconButton(
                                onPressed:
                                    controller.toggleConfirmPasswordVisibility,
                                icon: Icon(state.isConfirmPasswordVisible
                                    ? Iconsax.eye
                                    : Iconsax.eye_slash),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please confirm your password';
                              }
                              if (value != controller.passwordController.text) {
                                return 'Passwords do not match';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () {
                              if (controller.formKey.currentState!.validate()) {
                                controller.resetPassword();
                              }
                            },
                            child: const Text(AppStrings.resetPassword),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
