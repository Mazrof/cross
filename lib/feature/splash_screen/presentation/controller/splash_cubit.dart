import 'package:bloc/bloc.dart';
import 'dart:async';

import 'package:telegram/feature/splash_screen/presentation/controller/splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  // final AuthService _authService; // Add your authentication service
  // final FirstTimeService _firstTimeService; // Add your first-time check service

  SplashCubit(
      // this._authService, this._firstTimeService
      )
      : super(SplashInitial());

  void startAnimation(String slogan) {
    emit(AnimationInProgress());
    Future.delayed(const Duration(seconds: 2), () {
      emit(AnimationMoved());
      Future.delayed(const Duration(seconds: 2), () {
        emit(AnimationEnded());
        _startTypewriterEffect(slogan, 0);
      });
    });
  }

  void _startTypewriterEffect(String slogan, int textIndex) {
    Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (textIndex < slogan.length) {
        emit(TypewriterEffectInProgress(
            slogan.substring(0, textIndex + 1), textIndex + 1));
        textIndex++;
      } else {
        timer.cancel();
        emit(TypewriterEffectCompleted());
      }
    });
  }

  void checkAuthentication() async {
    emit(SplashLoading());
    const isFirstTime = true;
    if (isFirstTime) {
      emit(SplashFirstTime());
      return;
    }

    const isAuthenticated = false;
    if (isAuthenticated) {
      emit(SplashAuthenticated());
    } else {
      emit(SplashUnauthenticated());
    }
  }
}
