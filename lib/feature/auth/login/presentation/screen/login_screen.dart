import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:telegram/core/component/capp_divider.dart';
import 'package:telegram/core/component/csnack_bar.dart';
import 'package:telegram/core/component/csocial_icons.dart';
import 'package:telegram/core/component/clogo_loader.dart';
import 'package:telegram/core/di/service_locator.dart';
import 'package:telegram/core/local/hive.dart';
import 'package:telegram/core/routes/app_router.dart';
import 'package:telegram/core/utililes/app_enum/app_enum.dart';
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
        if (state.state == LoginStatusEnum.loading) {
          // return const LogoLoader();

          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.go(AppRouter.kHome);
          });
        } else if (state.state == LoginStatusEnum.success) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (HiveCash.read(boxName: 'register_info', key: 'user_type') ==
                'user') {
              context.go(AppRouter.kHome);
            } else {
              // context.go(AppRouter.kHome);
            }
          });
          return const LogoLoader();
        } else if (state.state == LoginStatusEnum.error) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            CSnackBar.showErrorSnackBar(context, 'Error', state.error!);
          });
          return LoginPage(state: state);
        } else if (state.state == LoginStatusEnum.suspended) {
          return Scaffold(
            body: Center(
              child: Text(
                'Too many attempts. Please wait ${state.secondsRemaining} seconds.',
                style: const TextStyle(color: Colors.red),
              ),
            ),
          );
        } else if (state.state == LoginStatusEnum.suspendedComplete) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            CSnackBar.showSuccessSnackBar(
                context, 'Try Again', 'you can try Login Again now');
          });
          return LoginPage(state: state);
        }
        return LoginPage(state: state);
      },
    );
  }
}

class LoginPage extends StatelessWidget {
  final LoginState state;

  const LoginPage({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            top: AppSizes.appBarPadding,
            left: AppSizes.padding,
            right: AppSizes.padding,
            bottom: AppSizes.padding,
          ),
          child: Column(
            children: [
              const LoginHeader(),
              const SizedBox(height: AppSizes.md),
              LoginForm(state: state),
              const CreateAccount(),
              const SizedBox(height: AppSizes.spaceBetweenInputField / 2),
              const CAppDivider(title: AppStrings.or),
              const SizedBox(height: AppSizes.spaceBetweenInputField),
              CSocialIcons(
                onPressedGoogle: sl<LoginCubit>().signInWithGoogle,
                onPressedGithub: () =>
                    sl<LoginCubit>().signInWithGithub(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
