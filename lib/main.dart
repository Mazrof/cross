import 'dart:io';

import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
    const App(),
  );
}

Future<void> _initializeApp() async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  ServiceLocator.init();
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
