import 'dart:io';

import 'package:device_preview/device_preview.dart';
import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:telegram/core/local/cache_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:telegram/core/observer/bloc_observer.dart';
import 'package:telegram/core/routes/app_router.dart';
import 'package:telegram/core/theme/app_theme.dart';
import 'package:telegram/feature/night_mode/presentation/controller/night_mode_cubit.dart';
import 'core/di/service_locator.dart';

void main() async {
  try {
    await _initializeApp();
  } catch (e, stackTrace) {
    if (kDebugMode) {
      print("Error during initialization: $e");
    }
    if (kDebugMode) {
      print("Stack trace: $stackTrace");
    }
  }

  runApp(
    DevicePreview(
      enabled: true,
      tools: const [
        ...DevicePreview.defaultTools,
      ],
      builder: (context) => const App(),
    ),
  );
  // CacheHelper.deleteAllCache();
}

Future<void> _initializeApp() async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  ServiceLocator.init();

  // await Firebase.initializeApp();

  Bloc.observer = MyBlocObserver();

  await _clearCacheIfFirstLaunch();
}

Future<void> _clearCacheIfFirstLaunch() async {
  final prefs = await SharedPreferences.getInstance();
  final isFirstLaunch = prefs.getBool('isFirstLaunch') ?? true;

  if (isFirstLaunch) {
    // Clear cached data
    await CacheHelper.deleteAllCache();

    // Set isFirstLaunch to false
    await prefs.setBool('isFirstLaunch', false);
  }
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<NightModeCubit>(),
      child: SafeArea(
        child: ScreenUtilInit(
          designSize: const Size(750, 1334),
          builder: (context, child) {
            return BlocBuilder<NightModeCubit, bool>(
              builder: (context, isNightMode) {
                return MaterialApp.router(
                  locale: DevicePreview.locale(context),
                  builder: DevicePreview.appBuilder,
                  debugShowCheckedModeBanner: false,
                  theme: TAppTheme.lightTheme,
                  darkTheme: TAppTheme.darkTheme,
                  // themeMode: ThemeMode.light,
                  themeMode: isNightMode ? ThemeMode.dark : ThemeMode.light,
                  routerConfig: route,
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
