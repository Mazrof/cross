import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:telegram/core/component/clogo_loader.dart';
import 'package:telegram/core/utililes/app_assets/assets_strings.dart'; // Adjust as necessary
import 'package:telegram/core/utililes/app_colors/app_colors.dart'; // Adjust as necessary
import 'package:telegram/feature/splash_screen/presentation/controller/splash_cubit.dart';
import 'package:telegram/feature/splash_screen/presentation/controller/splash_state.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/routes/app_router.dart'; // Import GoRouter

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocBuilder<SplashCubit, SplashState>(
          builder: (context, state) {
            if (state is SplashInitial || state is SplashLoading) {
              return const LogoLoader ();
            } else if (state is SplashFirstTime) {
              // Navigate to onboarding screen
              WidgetsBinding.instance.addPostFrameCallback((_) {
                context.go(AppRouter.kOnBoarding);
              });
              return Container();
            } else if (state is SplashAuthenticated) {
              // Navigate to authenticated screen
              WidgetsBinding.instance.addPostFrameCallback((_) {
                context.go(AppRouter.kHome);
              });
              return Container();
            } else if (state is SplashUnauthenticated) {
              // Navigate to unauthenticated screen
              WidgetsBinding.instance.addPostFrameCallback((_) {
                context.go(AppRouter.kLogin);
              });
              return Container();
            } else if (state is SplashEmailVerificationRequired) {
              // Navigate to email verification screen
              WidgetsBinding.instance.addPostFrameCallback((_) {
                context.go(AppRouter.kVerifyMail);
              });
              return Container();
            } else if (state is AnimationInProgress ||
                state is AnimationMoved ||
                state is AnimationEnded ||
                state is TypewriterEffectInProgress ||
                state is TypewriterEffectCompleted) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedOpacity(
                    opacity: state is AnimationMoved ||
                            state is AnimationEnded ||
                            state is TypewriterEffectInProgress ||
                            state is TypewriterEffectCompleted
                        ? 1.0
                        : 0.0,
                    duration: const Duration(milliseconds: 2000),
                    child: Image.asset(
                      AppAssetsStrings.loginLogo, // Replace with your logo path
                      width: 350.w,
                      height:350.h,
                    ),
                  ),
                  SizedBox(height: 50.h),
                  Text(
                    state is TypewriterEffectInProgress
                        ? state.displayedText
                        : 'Your World is Just One Chat Away',
                    style: Theme.of(context).textTheme.bodyMedium!.apply(color: AppColors.primaryColor),
                    textAlign: TextAlign.center,
                  ),
                ],
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
