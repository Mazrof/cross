import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:telegram/core/component/csnack_bar.dart';
import 'package:telegram/core/component/clogo_loader.dart';
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
  const ResetPasswordScreen({super.key, required this.token, required this.id});
  final String token;
  final String id;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ResetPasswordCubit, ResetPasswordState>(
      builder: (context, state) {
        if (state.state == CubitState.loading) {
          return const LogoLoader();
        } else if (state.state == CubitState.success) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.go(AppRouter.kLogin);
          });
        } else if (state.state == CubitState.failure) {
          // show error message
          WidgetsBinding.instance.addPostFrameCallback((_) {
            CSnackBar.showErrorSnackBar(context, 'Error', state.errorMessage!);
          });
        }
        // Handle other states if necessary
        return ResetPasswordPage(state: state, token: token, id: id);
      },
    );
  }
}

class ResetPasswordPage extends StatelessWidget {
  const ResetPasswordPage({
    required this.state,
    super.key,
    required this.id,
    required this.token,
  });
  final state;
  final String token;
  final String id;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(AppSizes.padding),
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(AppSizes.padding),
              child: Form(
                key: sl<ResetPasswordCubit>().formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 8),
                        Text(AppStrings.resetPasswordTitle,
                            style: Theme.of(context).textTheme.headlineLarge),
                        const SizedBox(height: 8),
                      ],
                    ),
                    const SizedBox(height: AppSizes.xl),
                    TextFormField(
                      style: Theme.of(context).textTheme.bodySmall,
                      key: sl<ResetPasswordCubit>().passwordKey,
                      controller: sl<ResetPasswordCubit>().passwordController,
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
                          onPressed:
                              sl<ResetPasswordCubit>().togglePasswordVisibility,
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
                      key: sl<ResetPasswordCubit>().confirmPasswordKey,
                      controller:
                          sl<ResetPasswordCubit>().confirmPasswordController,
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
                          onPressed: sl<ResetPasswordCubit>()
                              .toggleConfirmPasswordVisibility,
                          icon: Icon(state.isConfirmPasswordVisible
                              ? Iconsax.eye
                              : Iconsax.eye_slash),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please confirm your password';
                        }
                        if (value !=
                            sl<ResetPasswordCubit>().passwordController.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        if (sl<ResetPasswordCubit>()
                            .formKey
                            .currentState!
                            .validate()) {
                          sl<ResetPasswordCubit>().resetPassword(token, int.parse(id));
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
  }
}
