import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:telegram/core/local/cache_helper.dart';

class NightModeCubit extends Cubit<bool> {
  NightModeCubit() : super(_getInitialNightMode());

  static bool _getInitialNightMode() {
    final brightness = WidgetsBinding.instance.window.platformBrightness;
    var isDarkMode = brightness == Brightness.dark;
    final isDarkModeFromCache = CacheHelper.read(key: 'isDarkMode');
    if (isDarkModeFromCache != null) {
      isDarkMode = isDarkModeFromCache ==true?true:false;
    }
    return isDarkMode;
  }

  void toggleNightMode() => emit(!state);

  void setNightMode(bool isNightMode) {
    // Save the state in local storage
    CacheHelper.write(key: 'isDarkMode', value: isNightMode);
    emit(isNightMode);
  }
}
