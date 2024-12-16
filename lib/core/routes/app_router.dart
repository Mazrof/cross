import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:telegram/core/component/clogo_loader.dart';
import 'package:telegram/core/di/service_locator.dart';
import 'package:telegram/core/local/hive.dart';
import 'package:telegram/core/utililes/app_enum/app_enum.dart';
import 'package:telegram/feature/auth/forget_password/presentataion/controller/forgegt_password_controller/forget_password_cubit.dart';
import 'package:telegram/feature/auth/forget_password/presentataion/controller/reset_passwrod_controller/reset_password_cubit.dart';
import 'package:telegram/feature/auth/forget_password/presentataion/screen/forget_password_screen.dart';
import 'package:telegram/feature/auth/forget_password/presentataion/screen/reset_password_screen.dart';
import 'package:telegram/feature/auth/login/presentation/controller/login_cubit.dart';
import 'package:telegram/feature/auth/login/presentation/screen/login_screen.dart';
import 'package:telegram/feature/channels/create_channel/presentatin/controller/add_channel_cubit.dart';
import 'package:telegram/feature/channels/create_channel/presentatin/screen/add_new_subscribers_screen.dart';
import 'package:telegram/feature/groups/add_new_group/data/model/groups_model.dart';
import 'package:telegram/feature/groups/add_new_group/presentation/controller/add_group_cubit.dart';
import 'package:telegram/feature/groups/add_new_group/presentation/screens/group_info.dart';
import 'package:telegram/feature/groups/add_new_group/presentation/screens/group_screen.dart';
import 'package:telegram/feature/groups/group_setting/data/model/group_setting_model.dart';
import 'package:telegram/feature/groups/group_setting/data/model/membership_model.dart';
import 'package:telegram/feature/groups/group_setting/presentation/controller/add_members_cubit.dart';
import 'package:telegram/feature/groups/group_setting/presentation/controller/permision_cubit.dart';
import 'package:telegram/feature/groups/group_setting/presentation/screen/add_new_members_screen.dart';
import 'package:telegram/feature/groups/group_setting/presentation/screen/group_setting_screen.dart';
import 'package:telegram/feature/groups/group_setting/presentation/screen/permision_screen.dart';

import 'package:telegram/feature/home/presentation/controller/home/home_cubit.dart';
import 'package:telegram/feature/bottom_nav/presentaion/controller/nav_controller.dart';
import 'package:telegram/feature/bottom_nav/presentaion/screen/Bottom_nav_bar.dart';
import 'package:telegram/feature/on_bording/presentation/Controller/on_bording_bloc.dart';
import 'package:telegram/feature/on_bording/presentation/screen/on_bording_screen.dart';
import 'package:telegram/feature/auth/signup/presentation/controller/signup_cubit.dart';
import 'package:telegram/feature/auth/signup/presentation/screen/signup_screen.dart';

import 'package:telegram/feature/messaging/presentation/controller/chat_bloc.dart';
import 'package:telegram/feature/messaging/presentation/screen/chat_screen.dart';

import 'package:telegram/feature/profile/presentation/screen/profile_screen.dart';

import 'package:telegram/feature/channels/create_channel/presentatin/screen/new_channel_screen.dart';
import 'package:telegram/feature/groups/add_new_group/presentation/screens/new_group_screen.dart';

import 'package:telegram/feature/auth/verify_mail/presetnation/controller/verfiy_mail_cubit.dart';
import 'package:telegram/feature/auth/verify_mail/presetnation/screen/preverify.dart';
import 'package:telegram/feature/auth/verify_mail/presetnation/screen/verify_mail.dart';
import 'package:telegram/feature/home/presentation/screen/home_screen.dart';

import 'package:telegram/feature/search/Presentation/Screen/global_search.dart';

import 'package:telegram/feature/settings/presentationsettings/controller/user_settings_cubit.dart';
import 'package:telegram/feature/settings/presentationsettings/screen/autodelete_messages.dart';
import 'package:telegram/feature/settings/presentationsettings/screen/block_user.dart';
import 'package:telegram/feature/settings/presentationsettings/screen/blocked_users.dart';
import 'package:telegram/feature/settings/presentationsettings/screen/edit_profile.dart';
import 'package:telegram/feature/settings/presentationsettings/screen/lastseen_online.dart';
import 'package:telegram/feature/settings/presentationsettings/screen/privacy_security.dart';
import 'package:telegram/feature/settings/presentationsettings/screen/profile_photo_security.dart';
import 'package:telegram/feature/settings/presentationsettings/screen/settings.dart';
import 'package:telegram/feature/splash_screen/presentation/controller/splash_cubit.dart';
import 'package:telegram/feature/splash_screen/presentation/screen/splash_screen.dart';
import 'package:telegram/feature/voice/Presentation/Screen/call_contact.dart';
import 'package:telegram/feature/voice/Presentation/Screen/call_log.dart';
import 'package:telegram/feature/voice/Presentation/Screen/voice_call.dart';

import '../../feature/groups/group_setting/presentation/controller/group_cubit.dart';

class AppRouter {
  static const String kSplash = '/splash';
  static const String kHome = '/home';
  static const String kOnBoarding = '/onboarding';
  //auth
  static const String kLogin = '/login';
  static const String kSignUp = '/sign_up';
  static const String kprivacyAndSecurity = '/privacy_security';
  static const String kVerifyMail = '/verify_mail';
  static const String kPreVerify = '/pre_verify';
  static const String kForgetPassword = '/forget_password';
  static const String kResetPassword = '/reset';

  static const String kprofilePhotoSecurity = '/profile_photo_security';
  static const String keditProfile = '/edit_profile';
  static const String klastSeenOnline = '/last_seen_online';
  static const String kautoDeleteMessages = '/auto_delete_messages';
  static const String kblockUser = '/block_user';
  static const String kLogoLoader = '/chat';
  static const String kProfile = '/profile';

  static const String kglobalSearch = '/global_search';

  static const String kMessaging = '/messaging';

  // My Contacts Routes
  static const String kContacts = '/contacts';

  static const String kNotRobot = '/not_robot';
  static const String kblockedUsers = '/blocked_users';
  static const String ksettings = '/settings';
  static const String kcallLog = '/call_log';
  static const String kvoiceCall = '/voice_call';
  static const String kcallContact = '/call_contact';
  static const String kNavBar = '/nav_bar';

  //groups
  static const String kNewGroup = '/new_group';
  static const String kGroupInfo = '/group_info';
  static const String kGroupSetting = '/group_setting';
  static const String kUserPermission = '/user-permission';
  static const String kGroupScreen = '/group_screen';
  static const String kAddmembers = '/add_members';

  //channels
  static const String kNewChannel = '/new_channel';
  static const String kAddSubscribers = '/add_sub';
  static const String kChannelScreen = '/channel_screen';
  static const String KChannelSetting = 'channel_setting';

  static String buildRoute({required String base, required String route}) {
    return "$base/$route";
  }
}

final route = GoRouter(
  initialLocation: AppRouter.kSplash,
  routes: [
    GoRoute(
      path: AppRouter.kAddSubscribers,
      builder: (context, state) {
        return AddNewSubscribersScreen();
      },
    ),
    GoRoute(
      path: AppRouter.kPreVerify,
      builder: (context, state) {
        return const PreVerifyScreen();
      },
    ),
    GoRoute(
      path: AppRouter.kAddmembers,
      builder: (context, state) {
        final groupData = state.extra as GroupModel;
        return BlocProvider.value(
          value: sl<MembersCubit>()..fetchGroupDetails(groupData),
          child: AddNewMembersScreen(),
        );
      },
    ),
    GoRoute(
      path: AppRouter.kGroupScreen,
      builder: (context, state) {
        final groupData = state.extra as GroupModel;
        return GroupScreen(
          groupData: groupData,
        );
      },
    ),
    GoRoute(
      path: AppRouter.kUserPermission,
      builder: (context, state) {
        final member = state.extra as MembershipModel;
        return BlocProvider.value(
            value: sl<PermisionCubit>()..addData(member),
            child: EditPermissionsScreen(
              member: member,
            ));
      },
    ),
    GoRoute(
      path: AppRouter.kGroupSetting,
      builder: (context, state) {
        final int groupId = state.extra as int;
        return BlocProvider(
            create: (context) => sl<GroupCubit>()..fetchGroupDetails(groupId),
            child: GroupSettingsScreen(
              groupId: groupId,
            ));
      },
    ),
    GoRoute(
      path: '${AppRouter.kMessaging}/:index/:chatType',
      builder: (context, state) {
        final chatIndex = int.parse(state.pathParameters['index']!);

        final chatType = ChatType.values.firstWhere(
          (e) =>
              e.toString().split('.').last == state.pathParameters['chatType']!,
        );

        return BlocProvider(
          create: (context) => sl<ChatCubit>()
            ..init(
              chatType: chatType,
              chatIndex: chatIndex,
            )
            ..getMessages()
            ..startSocket(),
          child: ChatScreen(),
        );
      },
    ),
    GoRoute(
        path: AppRouter.kResetPassword,
        builder: (context, state) {
          return BlocProvider.value(
            value: sl<ResetPasswordCubit>(),
            child: ResetPasswordScreen(),
          );
        }),
    GoRoute(
      path: AppRouter.kHome,
      builder: (context, state) { 
        return HomeScreen();
      },
    ),
    GoRoute(
      path: AppRouter.kOnBoarding,
      builder: (context, state) {
        return BlocProvider<OnBordingCubit>.value(
          value: sl<OnBordingCubit>(),
          child: const OnBordingScreen(),
        );
      },
    ),
    GoRoute(
      path: AppRouter.kSplash,
      builder: (context, state) {
        return BlocProvider.value(
          value: sl<SplashCubit>()..startAnimation(),
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
      path: AppRouter.kprivacyAndSecurity,
      builder: (context, state) {
        return BlocProvider.value(
          value: sl<UserSettingsCubit>(),
          child: PrivacySecurityScreen(),
        );
      },
    ),
    GoRoute(
      path: AppRouter.kVerifyMail,
      builder: (context, state) {
        final param = state.extra as Map<String, dynamic>;
        return BlocProvider.value(
            value: sl<VerifyMailCubit>()
              ..sendVerificationMail(
                  param['method'] as String,
                  HiveCash.read(
                      boxName: "register_info",
                      key: param['method'] as String)!),
            child: VerifyMailScreen(
              method: param['method'] as String,
            ));
      },
    ),
    GoRoute(
        path: AppRouter.kForgetPassword,
        builder: (context, state) {
          return BlocProvider.value(
              value: sl<ForgetPasswordCubit>(),
              child: const ForgetPasswordScreen());
        }),
    GoRoute(
      path: AppRouter.ksettings,
      builder: (context, state) {
        return BlocProvider.value(
          value: sl<UserSettingsCubit>()..loadSettings(),
          child: SettingsScreen(),
        );
      },
    ),
    GoRoute(
      path: AppRouter.kNewChannel,
      builder: (context, state) {
        return BlocProvider.value(
          value: sl<AddChannelCubit>(),
          child: NewGroupScreen(),
        );
      },
    ),
    GoRoute(
      path: AppRouter.kNewGroup,
      builder: (context, state) {
        return BlocProvider.value(
          value: sl<AddMembersCubit>()..loadMembers(),
          child: NewGroupScreen(),
        );
      },
    ),
    GoRoute(
      path: AppRouter.kGroupInfo,
      builder: (context, state) {
        return BlocProvider.value(
          value: sl<AddMembersCubit>(),
          child: GroupInfo(),
        );
      },
    ),
    GoRoute(
      path: AppRouter.kautoDeleteMessages,
      builder: (context, state) {
        return BlocProvider.value(
          value: sl<UserSettingsCubit>(),
          child: AutodelMessagesScreen(),
        );
      },
    ),
    GoRoute(
      path: AppRouter.keditProfile,
      builder: (context, state) {
        return BlocProvider.value(
          value: sl<UserSettingsCubit>()..loadSettings(),
          child: EditProfileScreen(),
        );
      },
    ),
    GoRoute(
      path: AppRouter.kProfile,
      builder: (context, state) {
        return const ProfileScreen();
      },
    ),
    GoRoute(
      path: AppRouter.klastSeenOnline,
      builder: (context, state) {
        return BlocProvider.value(
          value: sl<UserSettingsCubit>(),
          child: LastseenOnlineScreen(),
        );
      },
    ),
    GoRoute(
      path: AppRouter.kblockedUsers,
      builder: (context, state) {
        return BlocProvider.value(
          value: sl<UserSettingsCubit>(),
          child: BlockedUsersScreen(),
        );
      },
    ),
    GoRoute(
      path: AppRouter.kprofilePhotoSecurity,
      builder: (context, state) {
        return BlocProvider.value(
          value: sl<UserSettingsCubit>(),
          child: ProfilePhotoSecurityScreen(),
        );
      },
    ),
    GoRoute(
      path: AppRouter.kblockUser,
      builder: (context, state) {
        return BlocProvider.value(
          value: sl<UserSettingsCubit>(),
          child: BlockUserScreen(),
        );
      },
    ),
    GoRoute(
      path: AppRouter.kLogoLoader,
      builder: (context, state) {
        return const LogoLoader();
      },
    ),
    GoRoute(
      path: AppRouter.kcallLog,
      builder: (context, state) {
        return CallLogScreen();
      },
    ),
    GoRoute(
      path: AppRouter.kvoiceCall,
      builder: (context, state) {
        return VoiceCallScreen(
          isMuted: false,
          speakerMode: false,
          callStatus: "Waiting",
          contactName: "Caller",
          contactImage: "",
        );
      },
    ),
    GoRoute(
      path: AppRouter.kcallContact,
      builder: (context, state) {
        return CallContactScreen();
      },
    ),
    GoRoute(
      path: AppRouter.kglobalSearch,
      builder: (context, state) {
        return GlobalSearchScreen(isTyping: true);
      },
    ),
    GoRoute(
      path: AppRouter.kNavBar,
      builder: (context, state) {
        return BlocProvider.value(
          value: sl<NavCubit>(),
          child: BottomNavBar(),
        );
      },
    ),
  ],
  observers: [
    GoRouterObserver(),
  ],
);

class GoRouterObserver extends NavigatorObserver {
  @override
  void didPush(Route route, Route? previousRoute) {
    print('Navigated to ${route.settings.name}');
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    print('Returned from ${route.settings.name}');
  }
}
