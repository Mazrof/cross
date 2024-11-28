import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:telegram/core/di/service_locator.dart';
import 'package:telegram/core/utililes/app_colors/app_colors.dart';
import 'package:telegram/core/utililes/app_sizes/app_sizes.dart';
import 'package:telegram/core/utililes/app_strings/app_strings.dart';
import 'package:telegram/core/validator/app_validator.dart';
import 'package:telegram/feature/auth/signup/presentation/controller/signup_cubit.dart';
import 'package:telegram/feature/auth/signup/presentation/controller/signup_state.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({super.key, required this.state});
  final SignupState state;

  @override
  Widget build(BuildContext context) {
    // Initialize the SignupController
    final SignUpCubit signupController = sl<SignUpCubit>();

    return Form(
      key: signupController.formKey,
      child: Column(
        children: [
          TextFormField(
            style: Theme.of(context)
                .textTheme
                .bodySmall, // Set the text style here
            key: signupController.usernameKey,
            controller: signupController.usernameController,
            decoration: InputDecoration(
              hintStyle: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .apply(color: AppColors.grey),
              hintText: AppStrings.username,
              labelText: AppStrings.username,
              prefixIcon: const Icon(Iconsax.user),
            ),
            validator:

                // validate username
                (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your username';
              }
              return null;
            },
          ),
          const SizedBox(height: AppSizes.spaceBetweenInputField),
          TextFormField(
            style: Theme.of(context)
                .textTheme
                .bodySmall, // Set the text style here
            key: signupController.emailKey,
            controller: signupController.emailController,
            decoration: InputDecoration(
              hintStyle: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .apply(color: AppColors.grey),
              hintText: AppStrings.emailHint,
              labelText: AppStrings.email,
              prefixIcon: const Icon(Iconsax.direct_right),
            ),
            validator: validateEmail,
          ),
          const SizedBox(height: AppSizes.spaceBetweenInputField),
          TextFormField(
            style: Theme.of(context)
                .textTheme
                .bodySmall, // Set the text style here
            key: signupController.phoneKey,
            controller: signupController.phoneController,
            decoration: InputDecoration(
              hintStyle: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .apply(color: AppColors.grey),
              hintText: AppStrings.phone,
              labelText: AppStrings.phone,
              prefixIcon: const Icon(Icons.phone),
            ),
            validator: validatePhoneNumber,
          ),
          const SizedBox(height: AppSizes.spaceBetweenInputField),
          TextFormField(
            style: Theme.of(context)
                .textTheme
                .bodySmall, // Set the text style here
            key: signupController.passwordKey,
            controller: signupController.passwordController,
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
                onPressed: signupController.togglePasswordVisibility,
                icon: Icon(
                    state.isPasswordVisible ? Iconsax.eye : Iconsax.eye_slash),
              ),
            ),
            validator: validatePassword,
          ),
          const SizedBox(height: AppSizes.spaceBetweenInputField),
          TextFormField(
            style: Theme.of(context)
                .textTheme
                .bodySmall, // Set the text style here
            key: signupController.confirmPasswordKey,
            controller: signupController.confirmPasswordController,
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
                onPressed: signupController.toggleConfirmPasswordVisibility,
                icon: Icon(state.isConfirmPasswordVisible
                    ? Iconsax.eye
                    : Iconsax.eye_slash),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please confirm your password';
              }
              if (value != signupController.passwordController.text) {
                return 'Passwords do not match';
              }
              return null;
            },
          ),
          const SizedBox(height: AppSizes.spaceBetweenInputField),
          // terms and conditions checkbox
          Row(
            children: [
              SizedBox(
                width: 24,
                height: 24,
                child: Checkbox(
                  value: state.isPrivacyPolicyAccepted,
                  onChanged: (value) {
                    signupController.togglePrivacyPolicyAcceptance();
                  },
                ),
              ),
              Text.rich(
                TextSpan(
                  text: AppStrings.iAgreeToThe,
                  style: Theme.of(context).textTheme.bodySmall,
                  children: [
                    TextSpan(
                      text: AppStrings.termsAndUse,
                      style: Theme.of(context).textTheme.bodySmall!.apply(
                          color: AppColors.primaryColor,
                          decoration: TextDecoration.underline),
                    ),
                    TextSpan(
                        text: ' and ',
                        style: Theme.of(context).textTheme.bodySmall),
                    TextSpan(
                      text: AppStrings.privacyPolicy,
                      style: Theme.of(context).textTheme.bodySmall!.apply(
                          color: AppColors.primaryColor,
                          fontSizeFactor: .8,
                          decoration: TextDecoration.underline),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSizes.spaceBetweenInputField),
          // submit button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                if (signupController.formKey.currentState!.validate()) {
                  signupController.signUp();
                }
              },
              child: const Text(AppStrings.signUp),
            ),
          ),
        ],
      ),
    );
  }
}
