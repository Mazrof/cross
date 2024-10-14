import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:telegram/core/utililes/app_colors/app_colors.dart';
import 'package:telegram/feature/splash_screen/presentation/controller/splash_cubit.dart';
import 'package:telegram/feature/splash_screen/presentation/controller/splash_state.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBackgroundColor,
      body: BlocListener<SplashCubit, SplashState>(
        listener: (context, state) {
          if (state is SplashAuthenticated) {
            // Navigate to authenticated screen
            // Navigator.of(context).pushReplacementNamed('/home');
          } else if (state is SplashUnauthenticated) {
            // Navigate to unauthenticated screen
            // Navigator.of(context).pushReplacementNamed('/login');
          } else if (state is SplashFirstTime) {
            // Navigate to onboarding screen
            // Navigator.of(context).pushReplacementNamed('/onboarding');
          }
        },
        child: BlocBuilder<SplashCubit, SplashState>(
          builder: (context, state) {
            if (state is SplashInitial || state is AnimationInProgress || state is SplashLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is AnimationMoved || state is AnimationEnded || state is TypewriterEffectInProgress || state is TypewriterEffectCompleted) {
              return _buildSplashContent(context, state);
            }

            return Container();
          },
        ),
      ),
    );
  }

  Widget _buildSplashContent(BuildContext context, SplashState state) {
    double imageOpacity = 1.0;
    double sloganOpacity = 0.0;
    String displayedText = '';

    if (state is AnimationEnded) {
      imageOpacity = 1.0;
    } else if (state is TypewriterEffectInProgress) {
      displayedText = state.displayedText;
    } else if (state is TypewriterEffectCompleted) {
      sloganOpacity = 1.0;
    }

    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedOpacity(
              duration: const Duration(seconds: 2),
              opacity: imageOpacity,
              child: Column(
                children: [
                  // Image.asset(
                  //   'assets/images/your_image.png', // Path to your image file
                  //   width: 150.w,
                  //   height: 150.h,
                  // ),
                  Text(
                    'MaZrof',
                    style: Theme.of(context).textTheme.headlineLarge!.apply(
                          color: AppColors.primaryColor,
                          fontSizeFactor: 1.2,
                          fontWeightDelta: -2,
                        ),
                  ),

                ],
              ),
            ),
            SizedBox(height: 20.h),
            _buildTypewriterText(context,displayedText, sloganOpacity),
          ],
        ),
      ),
    );
  }

  Widget _buildTypewriterText(BuildContext context,String displayedText, double opacity) {
    return AnimatedOpacity(
      duration: const Duration(seconds: 2),
      opacity: opacity,
      child: Text(
        displayedText,
        style: Theme.of(context).textTheme.headlineSmall!.apply(
              color: AppColors.primaryColor,
              fontSizeFactor: 1.2,
            ),
        textAlign: TextAlign.center,
      ),
    );
  }
}