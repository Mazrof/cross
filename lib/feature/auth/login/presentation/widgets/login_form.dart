import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:telegram/core/routes/app_router.dart';
import 'package:telegram/core/utililes/app_colors/app_colors.dart';
import 'package:telegram/core/utililes/app_sizes/app_sizes.dart';
import 'package:telegram/core/utililes/app_strings/app_strings.dart';
import 'package:telegram/feature/auth/login/presentation/controller/login_cubit.dart';
import 'package:telegram/feature/auth/login/presentation/controller/login_state.dart';
import 'package:telegram/core/di/service_locator.dart';

class LoginForm extends StatelessWidget {
  final LoginState state;

  const LoginForm({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    final loginCubit = sl<LoginCubit>();

    return Form(
      key: loginCubit.formKey,
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.padding),
        child: Column(
          children: [
            // email
            TextFormField(
              controller: loginCubit.emailController,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall, // Set the text style here
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
            const SizedBox(height: AppSizes.spaceBetweenInputField),

            // password
            TextFormField(
              controller: loginCubit.passwordController,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall, // Set the text style here
              obscureText: state.obscureText,
              decoration: InputDecoration(
                hintStyle: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .apply(color: AppColors.grey),
                labelText: AppStrings.password,
                hintText: AppStrings.passwordHint,
                prefixIcon: const Icon(Iconsax.password_check),
                suffixIcon: IconButton(
                  onPressed: loginCubit.togglePasswordVisibility,
                  icon: Icon(
                    state.obscureText ? Iconsax.eye_slash : Iconsax.eye,
                  ),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password';
                }
                return null;
              },
            ),
            const SizedBox(height: AppSizes.spaceBetweenInputField / 2),

            // remember me
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Checkbox(
                      value: state.rememberMe,
                      onChanged: (value) {
                        loginCubit.toggleRememberMe(value);
                      },
                    ),
                    Text(AppStrings.rememberMe,
                        style: Theme.of(context).textTheme.bodySmall),
                  ],
                ),
                TextButton(
                  onPressed: () {
                   GoRouter.of(context).push(AppRouter.kForgetPassword);
                  },
                  child: const Text(
                    AppStrings.forgetPassword,
                    style:
                        TextStyle(fontSize: 14, color: AppColors.primaryColor),
                  ),
                )
              ],
            ),
            const SizedBox(height: AppSizes.spaceBetweenInputField),
            SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: loginCubit.login,
                  child: const Text(
                    AppStrings.login,
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
