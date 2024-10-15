import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:telegram/core/component/capp_divider.dart';
import 'package:telegram/core/component/csocial_icons.dart';
import 'package:telegram/core/utililes/app_sizes/app_sizes.dart';
import 'package:telegram/core/utililes/app_strings/app_strings.dart';
import 'package:telegram/feature/auth/login/presentation/controller/login_cubit.dart';
import 'package:telegram/feature/auth/login/presentation/controller/login_state.dart';
import 'package:telegram/feature/auth/login/presentation/widgets/create_account.dart';
import 'package:telegram/feature/auth/login/presentation/widgets/login_form.dart';
import 'package:telegram/feature/auth/login/presentation/widgets/login_header.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
    return  const Scaffold(
      body: SingleChildScrollView(
          child: Padding(
              padding: EdgeInsets.only(
                top: AppSizes.appBarPadding,
                left: AppSizes.padding,
                right: AppSizes.padding,
                bottom: AppSizes.padding,
              ),
              child: Column(
                children: [
                  // logo &title & subtitle
                  LoginHeader(),
                  SizedBox(height: AppSizes.md),
                  // form
                  LoginForm(),

                  //create account
                  CreateAccount(),
                  SizedBox(height: AppSizes.spaceBetweenInputField / 2),
                  //divider
                  CAppDivider(title: AppStrings.or),
                  SizedBox(height: AppSizes.spaceBetweenInputField),
                  //footer

                  CSocialIcons(),

                ],
              ))));
              }
    );
  }
}
