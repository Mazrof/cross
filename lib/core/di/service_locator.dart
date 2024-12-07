import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:telegram/core/error/internet_check.dart';
import 'package:telegram/core/local/cache_helper.dart';
import 'package:telegram/core/local/hive.dart';
import 'package:telegram/core/network/api/api_service.dart';
import 'package:telegram/core/network/network_manager.dart';

import 'package:telegram/core/network/socket/socket_service.dart';

import 'package:telegram/core/validator/app_validator.dart';
import 'package:telegram/feature/auth/forget_password/data/data_source/forget_password_data_source.dart';
import 'package:telegram/feature/auth/forget_password/data/repo/forget_password_repo_imp.dart';
import 'package:telegram/feature/auth/forget_password/domain/repo/forget_password_repo.dart';
import 'package:telegram/feature/auth/forget_password/domain/usecase/forget_password_use_case.dart';
import 'package:telegram/feature/auth/forget_password/domain/usecase/log_out_use_case.dart';
import 'package:telegram/feature/auth/forget_password/domain/usecase/reset_password_use_case.dart';
import 'package:telegram/feature/auth/forget_password/presentataion/controller/forgegt_password_controller/forget_password_cubit.dart';
import 'package:telegram/feature/auth/forget_password/presentataion/controller/reset_passwrod_controller/reset_password_cubit.dart';
import 'package:telegram/feature/auth/login/data/data_source/login_data_source.dart';
import 'package:telegram/feature/auth/login/data/repositories/login_repo.dart';
import 'package:telegram/feature/auth/login/domain/repositories/base_repo.dart';
import 'package:telegram/feature/auth/login/domain/use_cases/login_use_case.dart';
import 'package:telegram/feature/auth/login/domain/use_cases/login_with_github_use_case.dart';
import 'package:telegram/feature/auth/login/domain/use_cases/login_with_google_use_case.dart';

import 'package:telegram/feature/auth/login/presentation/controller/login_cubit.dart';
import 'package:telegram/feature/auth/signup/domain/use_cases/check_recaptcha_tocken.dart';
import 'package:telegram/feature/auth/signup/presentation/widget/not_robot.dart';
import 'package:telegram/feature/groups/add_new_group/data/data_source/data_source.dart';
import 'package:telegram/feature/groups/add_new_group/data/repository/create_group_imp.dart';
import 'package:telegram/feature/groups/add_new_group/domain/use_case/add_members_use_case.dart';
import 'package:telegram/feature/groups/add_new_group/domain/use_case/create_group_use_case.dart';
import 'package:telegram/feature/groups/add_new_group/presentation/controller/add_group_cubit.dart';
import 'package:telegram/feature/groups/group_setting/data/data_source/group_setting_data_srouce.dart';
import 'package:telegram/feature/groups/group_setting/data/repository/group_setting.dart';
import 'package:telegram/feature/groups/group_setting/domain/use_case/delete_group_use_case.dart';
import 'package:telegram/feature/groups/group_setting/domain/use_case/fetch_group_details_use_case.dart';
import 'package:telegram/feature/groups/group_setting/domain/use_case/fetch_group_members_use_case.dart';
import 'package:telegram/feature/groups/group_setting/domain/use_case/remove_member_user.dart';
import 'package:telegram/feature/groups/group_setting/domain/use_case/update_group_use_case.dart';
import 'package:telegram/feature/groups/group_setting/domain/use_case/update_member_role.dart';
import 'package:telegram/feature/groups/group_setting/presentation/controller/group_cubit.dart';
import 'package:telegram/feature/groups/group_setting/presentation/controller/permision_cubit.dart';

import 'package:telegram/feature/home/presentation/controller/home/home_cubit.dart';
import 'package:telegram/feature/home/presentation/controller/story/add_story_cubit.dart';
import 'package:telegram/feature/home/presentation/controller/story/stroy_cubit.dart';

import 'package:telegram/feature/bottom_nav/presentaion/controller/nav_controller.dart';
import 'package:telegram/feature/dashboard/data/data_source/remote_data_source/dashboard_data_source.dart';
import 'package:telegram/feature/dashboard/data/repository/dashboard_remote_repo.dart';
import 'package:telegram/feature/dashboard/domain/repository/dashboard_repo.dart';
import 'package:telegram/feature/dashboard/domain/use_cases/remote_use_case/apply_filter.dart';
import 'package:telegram/feature/dashboard/domain/use_cases/remote_use_case/ban_user.dart';
import 'package:telegram/feature/dashboard/domain/use_cases/remote_use_case/get_groups.dart';
import 'package:telegram/feature/dashboard/domain/use_cases/remote_use_case/get_users.dart';
import 'package:telegram/feature/dashboard/domain/use_cases/remote_use_case/unban_user.dart';
import 'package:telegram/feature/dashboard/presentation/controller/banned_users_controller.dart';
import 'package:telegram/feature/dashboard/presentation/controller/group_controller.dart';
import 'package:telegram/feature/dashboard/presentation/controller/user_controller.dart';
import 'package:telegram/feature/on_bording/presentation/Controller/on_bording_bloc.dart';
import 'package:telegram/feature/auth/signup/data/data_source/local_data/sign_up_local_data_source.dart';
import 'package:telegram/feature/auth/signup/data/data_source/remote_data/sign_up_remote_data_source.dart';
import 'package:telegram/feature/auth/signup/data/repositories/sign_up_repo_impl.dart';
import 'package:telegram/feature/auth/signup/domain/repositories/sign_up_repo.dart';
import 'package:telegram/feature/auth/signup/domain/use_cases/register_use_case.dart';
import 'package:telegram/feature/auth/signup/domain/use_cases/save_register_info_use_case.dart';
import 'package:telegram/feature/auth/signup/presentation/controller/signup_cubit.dart';

import 'package:telegram/feature/messaging/presentation/controller/chat_bloc.dart';

import 'package:telegram/feature/auth/verify_mail/data/data_source/verify_mail_remot_data_source.dart';
import 'package:telegram/feature/auth/verify_mail/data/repo/verfiy_mail_imp.dart';
import 'package:telegram/feature/auth/verify_mail/domain/repo/verify_mail_base_repo.dart';
import 'package:telegram/feature/auth/verify_mail/domain/use_case/send_otp_use_case.dart';
import 'package:telegram/feature/auth/verify_mail/domain/use_case/verify_otp_use_case.dart';
import 'package:telegram/feature/auth/verify_mail/presetnation/controller/verfiy_mail_cubit.dart';
import 'package:telegram/feature/settings/datasettings/datasource/remotedata/user_settings_remote_data_source.dart';
import 'package:telegram/feature/settings/datasettings/repos/user_settings_repo_impl.dart';
import 'package:telegram/feature/settings/domainsettings/repos/user_settings_repo.dart';
import 'package:telegram/feature/settings/domainsettings/usecases/fetch_settings_use_case.dart';
import 'package:telegram/feature/settings/domainsettings/usecases/update_settings_use_case.dart';
import 'package:telegram/feature/settings/presentationsettings/controller/user_settings_cubit.dart';
import 'package:telegram/feature/splash_screen/presentation/controller/splash_cubit.dart';
import 'package:telegram/feature/night_mode/presentation/controller/night_mode_cubit.dart';

import '../../feature/groups/add_new_group/domain/repository/create_group_repo.dart';

final sl = GetIt.instance;

class ServiceLocator {
  static void init() {
    CacheHelper.init();
    HiveCash.init();

    registerSingletons();
    registerDataSources();
    registerRepositories();
    registerUseCases();
    registerCubits();
  }

  static void registerCubits() {
    //login

    sl.registerLazySingleton(() => LoginCubit(
          loginWithGoogleUseCase: sl(),
          loginWithGithubUseCase: sl(),
          appValidator: sl(),
          networkManager: sl(),
          loginUseCase: sl(),
        ));
    //signup
    sl.registerLazySingleton(() => SignUpCubit(
          registerUseCase: sl(),
          saveRegisterInfoUseCase: sl(),
          appValidator: sl(),
          networkManager: sl(),
          recaptchaService: sl(),
          checkRecaptchaTocken: sl(),
        ));

    //splash
    sl.registerLazySingleton(() => SplashCubit());
    //onboarding
    sl.registerLazySingleton(() => OnBordingCubit());
    sl.registerLazySingleton(() => ChatCubit());

    // night mode cubit
    sl.registerLazySingleton<NightModeCubit>(() => NightModeCubit());

    //reset password
    sl.registerLazySingleton(() => ResetPasswordCubit(
        resetPasswordUsecase: sl(),
        logOutUseCase: sl(),
        networkManager: sl(),
        appValidator: sl()));

    //verify mail
    sl.registerLazySingleton(() => VerifyMailCubit(
          sl(),
          sl(),
          sl(),
        ));

    //forget password
    sl.registerLazySingleton(() => ForgetPasswordCubit(
          appValidator: sl(),
          networkManager: sl(),
          forgetPasswordUseCase: sl(),
        ));

    //home
    sl.registerLazySingleton(() => AddStoryCubit());
    sl.registerFactory(() => StoryViewerCubit());
    sl.registerLazySingleton(() => HomeCubit());

    // nav bar
    sl.registerLazySingleton(() => NavCubit());

    //user dashboard cubit
    sl.registerLazySingleton(() => UsersCubit(
          networkManager: sl(),
          getUsersUseCase: sl(),
          banUserUseCase: sl(),
        ));

    // banned users cubit
    sl.registerLazySingleton(() => BannedUsersCubit(
          getUsersUseCase: sl(),
          unBanUserUseCase: sl(),
          networkManager: sl(),
        ));

    // group cubit
    sl.registerLazySingleton(() => GroupsCubit(
          networkManager: sl(),
          getGroupsUseCase: sl(),
          applyFilterUseCase: sl(),
        ));

    //settings
    sl.registerLazySingleton(() => UserSettingsCubit(
          fetchSettingsUseCase: sl(),
          updateSettingsUseCase: sl(),
          appValidator: sl(),
          networkManager: sl(),
        ));

    //groups and channels

    sl.registerLazySingleton(() => AddMembersCubit(
          sl(),
          sl(),
          sl(),
        ));

    sl.registerLazySingleton(() => GroupCubit(
          sl(),
          sl(),
          sl(),
          sl(),
          sl(),
          sl(),
          sl(),
          sl(),
        ));

    sl.registerLazySingleton(() => PermisionCubit());
  }

  static void registerUseCases() {
    //login
    sl.registerLazySingleton(() => LoginUseCase(loginRepository: sl()));
    sl.registerLazySingleton(
        () => LoginWithGoogleUseCase(loginRepository: sl()));
    sl.registerLazySingleton(
        () => LoginWithGithubUseCase(loginRepository: sl()));

    //signup
    sl.registerLazySingleton(() => RegisterUseCase(sl()));
    sl.registerLazySingleton(() => SaveRegisterInfoUseCase(sl()));
    sl.registerLazySingleton(() => CheckRecaptchaTocken(sl()));

    //verify mail
    sl.registerLazySingleton(() => SendOtpUseCase(sl()));
    sl.registerLazySingleton(() => VerifyOtpUseCase(sl()));

    //forget password
    sl.registerLazySingleton(() => (ForgetPasswordUseCase(sl())));

    //reset password
    sl.registerLazySingleton(() => ResetPasswordUseCase(
          sl(),
        ));
    sl.registerLazySingleton(() => LogOutUseCase(sl()));

    //dashboard
    sl.registerLazySingleton(() => GetGroupsUseCase(sl()));
    sl.registerLazySingleton(() => GetUsersUseCase(sl()));
    sl.registerLazySingleton(() => BanUserUseCase(sl()));
    sl.registerLazySingleton(() => UnBanUserUseCase(sl()));
    sl.registerLazySingleton(() => ApplyFilterUseCase(sl()));

    //settings
    sl.registerLazySingleton(() => FetchSettingsUseCase(
          sl(),
        ));
    sl.registerLazySingleton(() => UpdateSettingsUseCase(
          sl(),
        ));

    /// groups and channels
    sl.registerLazySingleton(() => AddMembersUseCase(sl()));
    sl.registerLazySingleton(() => CreateGroupUseCase(sl()));

    //

    sl.registerLazySingleton(() => RemoveMemberUseCase(sl()));
    sl.registerLazySingleton(() => UpdateGroupDetailsUseCase(sl()));
    sl.registerLazySingleton(() => DeleteGroupUseCase(sl()));
    sl.registerLazySingleton(() => FetchGroupDetailsUseCase(sl()));
    sl.registerLazySingleton(() => FetchGroupMembersUseCase(sl()));
    sl.registerLazySingleton(() => UpdateMemberRoleUseCase(sl()));
  }

  static void registerRepositories() {
    //login
    sl.registerLazySingleton<LoginRepository>(
        () => LoginRepositoryImpl(loginRemoteDataSource: sl()));

    //signup
    sl.registerLazySingleton<SignUpRepository>(() => SignUpRepoImpl(
        signUpLocalDataSource: sl(), signUpRemoteDataSource: sl()));

    //verify mail
    sl.registerLazySingleton<VerifyMailRepository>(
        () => VerfiyMailRepositoryImp(
              verifyMailRemoteDataSource: sl(),
            ));

    //forget password
    sl.registerLazySingleton<ForgetPasswordRepository>(() =>
        ForgetPasswordRepositoryImpl(forgetPasswordRemoteDataSource: sl()));

    //dashboard
    // sl.registerLazySingleton<DashboardLocalRepo>(() => DashboardLocalRepoImpl(
    //       localDataSource: sl(),
    //     ));
    sl.registerLazySingleton<DashboardRepo>(
        () => DashboardRemoteRepoImpl(dataSource: sl()));

    //settings
    sl.registerLazySingleton<UserSettingsRepo>(
        () => UserSettingsRepoImpl(remoteDataSource: sl()));

    /// groups and channels
    sl.registerLazySingleton<CreateGroupRepository>(
        () => GroupRepositoryImpl(sl()));

    sl.registerLazySingleton(() => GroupSettingRepositoryImpl(sl()));
  }

  static void registerDataSources() {
    //login
    sl.registerLazySingleton<LoginDataSource>(
        () => LoginDataSourceImp(apiService: sl()));

    //signup
    sl.registerLazySingleton<SignUpRemoteDataSource>(
        () => SignUpRemoteDataSourceImp());

    sl.registerLazySingleton<SignUpLocalDataSource>(
        () => SignUpLocalDataSourceImp());

    //verify mail
    sl.registerLazySingleton<VerifyMailDataSource>(
        () => VerifyMailDataSourceImp());

    //forget password
    sl.registerLazySingleton<ForgetPasswordDataSource>(
        () => ForgetPasswordDataSourceImp(sl()));

    //dashboard
    // sl.registerLazySingleton<DashboardLocalDataSource>(
    //     () => DashboardLocalDataSourceImpl());
    sl.registerLazySingleton<DashboardDataSource>(
        () => DashboardDataSourceImpl());
    //settings
    sl.registerLazySingleton<UserSettingsRemoteDataSource>(
      () => UserSettingsRemoteDataSourceImpl(),
    );

    //  groups and channels
    sl.registerLazySingleton<CreateGroupDataSource>(
        () => CreatGroupDataSourceMpl());

    sl.registerLazySingleton<GroupRemoteDataSource>(
        () => GroupRemoteDataSourceImpl(sl()));
  }

  static void registerSingletons() {
    sl.registerLazySingleton(() => RecaptchaService());

    sl.registerSingletonAsync<ApiService>(
        () async => await ApiService.create());
    sl.registerLazySingleton<SocketService>(() => SocketService());
    sl.registerLazySingleton<Dio>(() => Dio());
    sl.registerLazySingleton<NetworkInfo>(
        () => NetworkInfoImpl(connectionChecker: sl()));

    sl.registerLazySingleton<InternetConnectionChecker>(
        () => InternetConnectionChecker());

    sl.registerLazySingleton<NetworkManager>(() => (NetworkManager()));
    sl.registerLazySingleton<AppValidator>(() => AppValidator());
  }
}
