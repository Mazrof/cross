import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:telegram/core/component/capp_divider.dart';
import 'package:telegram/core/component/csnack_bar.dart';
import 'package:telegram/core/component/csocial_icons.dart';
import 'package:telegram/core/component/clogo_loader.dart';
import 'package:telegram/core/di/service_locator.dart';
import 'package:telegram/core/routes/app_router.dart';
import 'package:telegram/core/utililes/app_enum/app_enum.dart';
import 'package:telegram/core/utililes/app_strings/app_strings.dart';
import 'package:telegram/feature/auth/login/presentation/controller/login_cubit.dart';
import 'package:telegram/feature/auth/login/presentation/widgets/go_to_login.dart';
import 'package:telegram/feature/auth/signup/presentation/controller/sign_up/signup_cubit.dart';
import 'package:telegram/feature/auth/signup/presentation/controller/sign_up/signup_state.dart';
import 'package:telegram/feature/auth/signup/presentation/widget/not_robot.dart';
import 'package:telegram/feature/auth/signup/presentation/widget/signup_from.dart';

import '../../../../../core/utililes/app_sizes/app_sizes.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignupState>(builder: (context, state) {
      if (state.state == CubitState.loading) {
        return const LogoLoader();
      } else if (state.state == CubitState.success) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          context.go(AppRouter.kVerifyMail);
        });
      } else if (state.state == CubitState.failure) {
        // show error message
        WidgetsBinding.instance.addPostFrameCallback((_) {
          CSnackBar.showErrorSnackBar(context, 'Error', state.errorMessage!);
        });
      }
      // Handle other states if necessary

      return SignUpPage(
        state: state,
      );
    });
  }
}

class SignUpPage extends StatelessWidget {
  const SignUpPage({
    required this.state,
    super.key,
  });
  final SignupState state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
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
                SignUpForm(
                  state: state,
                ),
                //sign in

                const GoToLogIn(),

                const SizedBox(height: AppSizes.spaceBetweenInputField / 2),
                //divider
                const CAppDivider(
                  title: AppStrings.or,
                ),
                const SizedBox(height: AppSizes.spaceBetweenInputField),
                //footer
                CSocialIcons(
                  onPressedGoogle: sl<LoginCubit>().signInWithGoogle,
                  onPressedGithub: () =>
                      sl<LoginCubit>().signInWithGithub(context),
                ),
              ],
            ),
          ),
        ));
  }
}
