import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:telegram/core/di/service_locator.dart';
import 'package:telegram/feature/auth/login/presentation/controller/login_cubit.dart';
import 'package:telegram/feature/auth/login/presentation/screen/login_screen.dart';
import 'package:telegram/feature/auth/on_bording/presentation/Controller/on_bording_bloc.dart';
import 'package:telegram/feature/auth/on_bording/presentation/screen/on_bording_screen.dart';
import 'package:telegram/feature/auth/signup/presentation/controller/signup_cubit.dart';
import 'package:telegram/feature/auth/signup/presentation/screen/signup_screen.dart';
import 'package:telegram/feature/auth/signup/presentation/screen/success_screen.dart';
import 'package:telegram/feature/auth/verfiy_mail/presentation/screen/verify_mail.dart';
import 'package:telegram/feature/messaging/presentation/screen/messaging_screen.dart';
import 'package:telegram/feature/splash_screen/presentation/controller/splash_cubit.dart';
import 'package:telegram/feature/splash_screen/presentation/screen/splash_screen.dart';

class AppRouter {
  static const String kLogin = '/login';
  static const String kSPlash = '/splash';
  static const String kSignUp = '/sign_up';
  static const String kHome = '/home';
  static const String kOnboarding = '/onboarding';
  static const String kSuccess = '/success';
  static const String konboarding = '/onboarding';
  static const String kverifyMail = '/verify_mail';
  static const String kMessaging = '/messaging';

  static String buildRoute({required String base, required String route}) {
    return "$base/$route";
  }
}

final route = GoRouter(initialLocation: AppRouter.kMessaging, routes: [
  GoRoute(
    path: AppRouter.konboarding,
    builder: (context, state) {
      return BlocProvider<OnBordingCubit>(
        create: (context) => sl<OnBordingCubit>(),
        child: const OnBordingScreen(),
      );
    },
  ),
  GoRoute(
    path: AppRouter.kMessaging,
    builder: (context, state) => MessagingScreen(),
  ),
  GoRoute(
      path: AppRouter.kSPlash,
      builder: (context, state) {
        return BlocProvider<SplashCubit>.value(
            value: sl<SplashCubit>()..checkAuthentication(),
            child: const SplashScreen());
      }),
  GoRoute(
    path: AppRouter.kLogin,
    builder: (context, state) {
      return BlocProvider.value(
        value: sl<LoginCubit>(),
        child: LoginScreen(),
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
    builder: (context, state) => SuccessScreen(
      title: 'You Successfully Registered',
      subtitle: 'tap on continue to go to login in',
      onButtonPressed: () {},
    ),
  ),
  GoRoute(
    path: AppRouter.kverifyMail,
    builder: (context, state) {
      return VerifyMailScreen(
        email: 'mariam@gmail.com',
      );
    },
  ),
]);
