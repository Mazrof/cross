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
import 'package:telegram/feature/settings/Presentation/Screen/autodelete_messages.dart';
import 'package:telegram/feature/settings/Presentation/Screen/block_user.dart';
import 'package:telegram/feature/settings/Presentation/Screen/blocked_users.dart';
import 'package:telegram/feature/settings/Presentation/Screen/edit_profile.dart';
import 'package:telegram/feature/settings/Presentation/Screen/lastseen_online.dart';
import 'package:telegram/feature/settings/Presentation/Screen/privacy_security.dart';
import 'package:telegram/feature/settings/Presentation/Screen/profile_photo_security.dart';
import 'package:telegram/feature/settings/Presentation/Widget/radio_tile.dart';
import 'package:telegram/feature/splash_screen/presentation/controller/splash_cubit.dart';
import 'package:telegram/feature/splash_screen/presentation/screen/splash_screen.dart';
import 'package:telegram/feature/settings/Presentation/Screen/settings.dart';

class AppRouter {
  static const String kLogin = '/login';
  static const String kSplash = '/splash';
  static const String kSignUp = '/sign_up';
  static const String kHome = '/home';
  static const String kOnboarding = '/onboarding';
  static const String kSuccess = '/success';

  static const String konboarding = '/onboarding';
  static const String kverifyMail = '/verify_mail';
  static const String kMessaging = '/messaging';
  static const String ksettings = '/settings';
  static const String kprivacyAndSecurity = '/privacy_security';
  static const String kblockedUsers = '/blocked_users';
  static const String kprofilePhotoSecurity = '/profile_photo_security';
  static const String keditProfile = '/edit_profile';
  static const String klastSeenOnline = '/last_seen_online';
  static const String kautoDeleteMessages = '/auto_delete_messages';
  static const String kblockUser = '/block_user';
  static const String kOnBoarding = '/onboarding';
  static const String kVerifyMail = '/verify_mail';
  static const String kLogoLoader = '/chat';

  static String buildRoute({required String base, required String route}) {
    return "$base/$route";
  }
}

final route = GoRouter(initialLocation: AppRouter.kSplash, routes: [
  GoRoute(
    path: AppRouter.kOnBoarding,
    builder: (context, state) {
      return BlocProvider<OnBordingCubit>(
        create: (context) => sl<OnBordingCubit>(),
        child: const OnBordingScreen(),
      );
    },
  ),
  GoRoute(
      path: AppRouter.kSplash,
      builder: (context, state) {
        return BlocProvider<SplashCubit>.value(
            value: sl<SplashCubit>()..checkAuthentication(),
            child: const SplashScreen());
      }),
  GoRoute(
    path: AppRouter.kSplash,
    builder: (context, state) {
      return BlocProvider(
        create: (context) => SplashCubit()..startAnimation(),
        child: const SplashScreen(),
      );
    },
  ),
  GoRoute(
    path: AppRouter.kLogin,
    builder: (context, state) {
      return BlocProvider.value(
        value: sl<LoginCubit>(),
        child: const LoginScreen(),
      );
    },
  ),
  GoRoute(
    path: AppRouter.kSignUp,
    builder: (context, state) {
      return BlocProvider.value(
        value: sl<SignUpCubit>(),
        child: const SignUpScreen(),
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
    path: AppRouter.kVerifyMail,
    builder: (context, state) {
      return const VerifyMailScreen(
        email: 'mariam@gmail.com',
      );
    },
  ),
  GoRoute(
    path: AppRouter.ksettings,
    builder: (context, state) {
      return const SettingsScreen(
        screenName: "Ahmed",
        userName: "user",
        phoneNumber: '1234',
        bio: "Hello",
        status: "Online",
      );
    },
  ),
  GoRoute(
    path: AppRouter.kprivacyAndSecurity,
    builder: (context, state) {
      return const PrivacySecurityScreen(readReceiptStatus: true);
    },
  ),
  GoRoute(
    path: AppRouter.kautoDeleteMessages,
    builder: (context, state) {
      return const AutodelMessages(selectedTimer: AutoDelOption.oneDay);
    },
  ),
  GoRoute(
    path: AppRouter.keditProfile,
    builder: (context, state) {
      return const EditProfileScreen();
    },
  ),
  GoRoute(
    path: AppRouter.klastSeenOnline,
    builder: (context, state) {
      return const LastseenOnlineScreen(selectedOption: PrivacyOption.everybody);
    },
  ),
  GoRoute(
    path: AppRouter.kblockedUsers,
    builder: (context, state) {
      return BlockedUsersScreen(
        blockedUsers: List.generate(10, (index) => 'Blocked User ${index + 1}'),
      );
    },
  ),
  GoRoute(
    path: AppRouter.kprofilePhotoSecurity,
    builder: (context, state) {
      return const ProfilePhotoSecurityScreen(
          selectedOption: PrivacyOption.myContacts);
    },
  ),
  GoRoute(
    path: AppRouter.kblockUser,
    builder: (context, state) {
      return const BlockUserScreen();
    },
  ),
  GoRoute(
    path: AppRouter.kLogoLoader,
    builder: (context, state) {
      return const LogoLoader();
    },
  ),
]);
