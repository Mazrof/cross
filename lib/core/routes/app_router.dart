import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:telegram/core/component/logo_loader.dart';
import 'package:telegram/core/di/service_locator.dart';
import 'package:telegram/feature/auth/login/presentation/controller/login_cubit.dart';
import 'package:telegram/feature/auth/login/presentation/screen/login_screen.dart';
import 'package:telegram/feature/auth/on_bording/presentation/Controller/on_bording_bloc.dart';
import 'package:telegram/feature/auth/on_bording/presentation/screen/on_bording_screen.dart';
import 'package:telegram/feature/auth/signup/presentation/controller/signup_cubit.dart';
import 'package:telegram/feature/auth/signup/presentation/screen/signup_screen.dart';
import 'package:telegram/feature/auth/signup/presentation/screen/success_screen.dart';
import 'package:telegram/feature/auth/verfiy_mail/presentation/screen/verify_mail.dart';
import 'package:telegram/feature/splash_screen/presentation/controller/splash_cubit.dart';
import 'package:telegram/feature/splash_screen/presentation/screen/splash_screen.dart';

class AppRouter {
  static const String kLogin = '/login';
  static const String kSplash = '/splash';
  static const String kSignUp = '/sign_up';
  static const String kHome = '/home';
  static const String kOnboarding = '/onboarding';
  static const String kSuccess = '/success';
  static const String kOnBoarding = '/onboarding';
  static const String kVerifyMail = '/verify_mail';
  static const String kLogoLoader = '/chat';


  static String buildRoute({required String base, required String route}) {
    return "$base/$route";
  }
}

final route = GoRouter(initialLocation: AppRouter.kSplash,
routes: [
  GoRoute(path: AppRouter.kOnBoarding,
    builder: (context, state) {
      return BlocProvider<OnBordingCubit>(
        create: (context) => sl<OnBordingCubit>(),
        child: OnBordingScreen(),
      );
    },
  ),
   GoRoute(
    path: AppRouter.kSplash,
    builder: (context, state) {
      return BlocProvider(
        create: (context) => SplashCubit()
          ..startAnimation(),
        child: const SplashScreen(),
      );
    },
  ),
  GoRoute(
    path: AppRouter.kLogin,
    builder: (context, state) {
       return BlocProvider.value(
            value: sl<LoginCubit>(),
            child:  LoginScreen(),
          );
    },
  ),
  GoRoute(
    path: AppRouter.kSignUp,
    builder: (context, state) {
      return BlocProvider.value(
        value: sl<SignUpCubit>(),
        child: SignUpScreen(),
      );
    },
  ),
  GoRoute(
    path: AppRouter.kSuccess,
    builder: (context, state) =>  SuccessScreen(title: 'You Successfully Registered', subtitle: 'tap on continue to go to login in', onButtonPressed: () { },),
  ),
  GoRoute(path: AppRouter.kVerifyMail,
    builder: (context, state) {
      return VerifyMailScreen(
        email:'mariam@gmail.com',
      );
    },
  ),
  GoRoute(
    path: AppRouter.kLogoLoader,
    builder: (context, state) {
      return const LogoLoader();
    },
  ),


]);
