import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:telegram/core/error/internet_check.dart';
import 'package:telegram/core/local/cache_helper.dart';
import 'package:telegram/core/network/api/api_service.dart';
import 'package:telegram/core/network/network_manager.dart';
import 'package:telegram/feature/auth/forget_password/presentataion/controller/reset_passwrod_controller/reset_password_cubit.dart';
import 'package:telegram/feature/auth/login/data/remote_data/remote_data_source.dart';
import 'package:telegram/feature/auth/login/data/repositories/login_repo.dart';
import 'package:telegram/feature/auth/login/domain/repositories/base_repo.dart';
import 'package:telegram/feature/auth/login/domain/use_cases/use_case.dart';
import 'package:telegram/feature/auth/login/presentation/controller/login/login_cubit.dart';
import 'package:telegram/feature/auth/on_bording/presentation/Controller/on_bording_bloc.dart';
import 'package:telegram/feature/auth/signup/data/data_source/local_data/sign_up_local_data_source.dart';
import 'package:telegram/feature/auth/signup/data/data_source/remote_data/sign_up_remote_data_source.dart';
import 'package:telegram/feature/auth/signup/data/repositories/sign_up_repo_impl.dart';
import 'package:telegram/feature/auth/signup/domain/repositories/sign_up_repo.dart';
import 'package:telegram/feature/auth/signup/domain/use_cases/register_use_case.dart';
import 'package:telegram/feature/auth/signup/domain/use_cases/save_register_info_use_case.dart';
import 'package:telegram/feature/auth/signup/presentation/controller/sign_up/signup_cubit.dart';
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
    registerCore();
  }

  static void registerCubits() {
    //login
    sl.registerLazySingleton(() => LoginCubit(
          loginUseCase: sl(),
        ));
    //signup
    sl.registerLazySingleton(() => SignUpCubit(
          registerUseCase: sl(),
          saveRegisterInfoUseCase: sl(),
        ));

    //slash
    sl.registerLazySingleton(() => SplashCubit());
    //onboarding
    sl.registerLazySingleton(() => OnBordingCubit());

    final brightness = WidgetsBinding.instance.window.platformBrightness;
    final isDarkMode = brightness == Brightness.dark;
    sl.registerLazySingleton(() => NightModeCubit(initialState: isDarkMode));

    //reset password
    sl.registerLazySingleton(() => ResetPasswordCubit());
    
  }

  static void registerUseCases() {
    //login
    sl.registerLazySingleton(() => LoginUseCase(loginRepository: sl()));

    //signup
    sl.registerLazySingleton(() => RegisterUseCase(sl()));
    sl.registerLazySingleton(() => SaveRegisterInfoUseCase(sl()));

    
  }

  static void registerRepositories() {
    //login
    sl.registerLazySingleton<BaseLoginRepository>(
        () => LoginRepositoryImpl(loginRemoteDataSource: sl()));

    //signup
    sl.registerLazySingleton<SignUpRepo>(() => SignUpRepoImpl(
        signUpLocalDataSource: sl(), signUpRemoteDataSource: sl()));
  }

  static void registerDataSources() {
    //login
    sl.registerLazySingleton<BaseLoginRemoteDataSource>(
        () => LoginRemoteDataSource(apiService: sl()));

    //signup
    sl.registerLazySingleton<SignUpRemoteDataSource>(
        () => SignUpRemoteDataSourceImpl(
              apiService: sl(),
            ));

    sl.registerLazySingleton<SignUpLocalDataSource>(
        () => SignUpLocalDataSourceImpl());
  }

  static void registerCore() {}

  static void registerSingletons() {
    sl.registerSingleton<ApiService>(ApiService());
    sl.registerLazySingleton<Dio>(() => Dio());
    sl.registerLazySingleton<NetworkInfo>(
        () => NetworkInfoImpl(connectionChecker: sl()));

    sl.registerLazySingleton<InternetConnectionChecker>(
        () => InternetConnectionChecker());
    sl.registerLazySingleton<NetworkManager>(() => (NetworkManager()));
  }
}
