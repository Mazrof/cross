import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:telegram/core/di/service_locator.dart';
import 'package:telegram/core/utililes/app_colors/app_colors.dart';
import 'package:telegram/core/utililes/app_sizes/app_sizes.dart';
import 'package:telegram/core/utililes/app_strings/app_strings.dart';
import 'package:telegram/feature/auth/login/presentation/controller/login_cubit.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
        return Form(
          key: sl<LoginCubit>().formKey,
          child: Padding(
            padding: const EdgeInsets.all(AppSizes.padding),
            child: Column(
              children: [
                // email
                TextFormField(
                  controller: sl<LoginCubit>().emailController,
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
                  obscureText: sl<LoginCubit>().obscureText,
                  decoration: InputDecoration(
                    hintStyle: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .apply(color: AppColors.grey),
                    labelText: AppStrings.password,
                    hintText: AppStrings.passwordHint,
                    prefixIcon: const Icon(Iconsax.password_check),
                    suffixIcon: IconButton(
                      onPressed: sl<LoginCubit>().togglePasswordVisibility,
                      icon: Icon(
                        sl<LoginCubit>().obscureText
                            ? Iconsax.eye_slash
                            : Iconsax.eye,
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
                          value: sl<LoginCubit>().rememberMe,
                          onChanged: (value) {
                            sl<LoginCubit>().toggleRememberMe(value);
                          },
                        ),
                        Text(AppStrings.rememberMe,
                            style: Theme.of(context).textTheme.bodySmall),
                      ],
                    ),
                    TextButton(
                      onPressed: () {
                        // Navigator.pushNamed(context, AppRoutes.forgetPassword);
                      },
                      child: const Text(
                        AppStrings.forgetPassword,
                        style: TextStyle(
                            fontSize: 14, color: AppColors.primaryColor),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: AppSizes.spaceBetweenInputField),
                SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: ()=> sl<LoginCubit>().login,
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
