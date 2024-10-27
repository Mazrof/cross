import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:telegram/core/component/capp_bar.dart';
import 'package:telegram/core/routes/app_router.dart';
import 'package:telegram/core/utililes/app_colors/app_colors.dart';
import 'package:telegram/core/utililes/app_sizes/app_sizes.dart';
import 'package:telegram/core/utililes/app_strings/app_strings.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

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
                    TextFormField(
                      // controller: loginCubit.emailController,
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
                    const SizedBox(height: AppSizes.xl),
                    SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            context.go(AppRouter.kResetPassword);
                          
                          },
                          child: const Text(
                            AppStrings.resetPassword,
                          ),
                        )),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
