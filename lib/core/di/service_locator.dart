import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:telegram/core/error/internet_check.dart';
import 'package:telegram/core/local/cache_helper.dart';
import 'package:telegram/core/network/api/api_service.dart';
import 'package:telegram/core/network/network_manager.dart';
import 'package:telegram/feature/auth/login/presentation/controller/login_cubit.dart';
import 'package:telegram/feature/auth/on_bording/presentation/Controller/on_bording_bloc.dart';
import 'package:telegram/feature/auth/signup/presentation/controller/signup_cubit.dart';
import 'package:telegram/feature/splash_screen/presentation/controller/splash_cubit.dart';
import 'package:telegram/night_mode/presentation/controller/night_mode_cubit.dart';

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
    sl.registerLazySingleton(() => LoginCubit());
    sl.registerLazySingleton(() => SignUpCubit());
    sl.registerLazySingleton(() => SplashCubit());
    sl.registerLazySingleton(() => OnBordingCubit());

    final brightness = WidgetsBinding.instance.window.platformBrightness;
    final isDarkMode = brightness == Brightness.dark;
    sl.registerLazySingleton(() => NightModeCubit(initialState: isDarkMode));
  }

  static void registerUseCases() {}

  static void registerRepositories() {}

  static void registerDataSources() {}

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
