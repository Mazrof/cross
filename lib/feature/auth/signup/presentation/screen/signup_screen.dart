import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:telegram/core/component/capp_divider.dart';
import 'package:telegram/core/component/csocial_icons.dart';
import 'package:telegram/core/utililes/app_strings/app_strings.dart';
import 'package:telegram/feature/auth/login/presentation/widgets/go_to_login.dart';
import 'package:telegram/feature/auth/signup/presentation/controller/signup_cubit.dart';
import 'package:telegram/feature/auth/signup/presentation/controller/signup_state.dart';
import 'package:telegram/feature/auth/signup/presentation/widget/signup_from.dart';

import '../../../../../core/utililes/app_sizes/app_sizes.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      builder: (context, state) {
    return Scaffold(
     appBar: AppBar(

     ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.padding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // logo &title & subtitle

              Text(
                AppStrings.signUpTitle,
                style: Theme.of(context).textTheme.headlineLarge,
              ),

              const SizedBox(height: AppSizes.spaceBetweenSections),
              // form
              const SignUpForm(),
              //sign in

              const GoToLogIn(),

              const SizedBox(height: AppSizes.spaceBetweenInputField / 2),
              //divider
              const CAppDivider(
                title: AppStrings.or,
              ),
              const SizedBox(height: AppSizes.spaceBetweenInputField),
              //footer
              const CSocialIcons()
            ],
          ),
        ),
      ));
      });
  }
}

