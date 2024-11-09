import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:telegram/core/error/internet_check.dart';
import 'package:telegram/core/local/cache_helper.dart';
import 'package:telegram/core/network/api/api_service.dart';
import 'package:telegram/core/network/network_manager.dart';
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
import 'package:telegram/feature/on_bording/presentation/Controller/on_bording_bloc.dart';
import 'package:telegram/feature/auth/signup/data/data_source/local_data/sign_up_local_data_source.dart';
import 'package:telegram/feature/auth/signup/data/data_source/remote_data/sign_up_remote_data_source.dart';
import 'package:telegram/feature/auth/signup/data/repositories/sign_up_repo_impl.dart';
import 'package:telegram/feature/auth/signup/domain/repositories/sign_up_repo.dart';
import 'package:telegram/feature/auth/signup/domain/use_cases/register_use_case.dart';
import 'package:telegram/feature/auth/signup/domain/use_cases/save_register_info_use_case.dart';
import 'package:telegram/feature/auth/signup/presentation/controller/signup_cubit.dart';
import 'package:telegram/feature/auth/verify_mail/data/data_source/verify_mail_remot_data_source.dart';
import 'package:telegram/feature/auth/verify_mail/data/repo/verfiy_mail_imp.dart';
import 'package:telegram/feature/auth/verify_mail/domain/repo/verify_mail_base_repo.dart';
import 'package:telegram/feature/auth/verify_mail/domain/use_case/send_otp_use_case.dart';
import 'package:telegram/feature/auth/verify_mail/domain/use_case/verify_otp_use_case.dart';
import 'package:telegram/feature/auth/verify_mail/presetnation/controller/verfiy_mail_cubit.dart';
import 'package:telegram/feature/splash_screen/presentation/controller/splash_cubit.dart';
import 'package:telegram/feature/night_mode/presentation/controller/night_mode_cubit.dart';

final sl = GetIt.instance;

class ServiceLocator {
  static void init() {
    CacheHelper.init();
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
  }

  static void registerDataSources() {
    //login
    sl.registerLazySingleton<LoginDataSource>(
        () => LoginDataSourceImp(apiService: sl()));

    //signup
    sl.registerLazySingleton<SignUpRemoteDataSource>(
        () => SignUpRemoteDataSourceImp(
              apiService: sl(),
            ));

    sl.registerLazySingleton<SignUpLocalDataSource>(
        () => SignUpLocalDataSourceImp());

    //verify mail
    sl.registerLazySingleton<VerifyMailDataSource>(
        () => VerifyMailDataSourceImp());

    //forget password
    sl.registerLazySingleton<ForgetPasswordDataSource>(
        () => ForgetPasswordDataSourceImp(sl()));
  }

  static void registerSingletons() {
    sl.registerLazySingleton(() => RecaptchaService());
    sl.registerSingleton<ApiService>(ApiService());
    sl.registerLazySingleton<Dio>(() => Dio());
    sl.registerLazySingleton<NetworkInfo>(
        () => NetworkInfoImpl(connectionChecker: sl()));

    sl.registerLazySingleton<InternetConnectionChecker>(
        () => InternetConnectionChecker());
    sl.registerLazySingleton<NetworkManager>(() => (NetworkManager()));
    sl.registerLazySingleton<AppValidator>(() => AppValidator());
  }
}
