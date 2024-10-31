import 'package:bloc/bloc.dart';
import 'package:telegram/core/helper/user_status_helper.dart';
import 'dart:async';
import 'package:telegram/feature/splash_screen/presentation/controller/splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial());

  void startAnimation() {
    emit(AnimationInProgress());
    Future.delayed(const Duration(milliseconds: 500), () {
      emit(AnimationMoved());
      _startTypewriterEffect('Your World is Just One Chat Away !', 0);
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
        checkAuthentication(); // Check authentication after typewriter effect is completed
      }
    });
  }

  void checkAuthentication() async {
     emit(SplashLoading());

    // Check user status using UserStatusHelper
    String status = await UserStatusHelper.checkUserStatus();

    switch (status) {
      case 'onbording':
        emit(SplashFirstTime());
        break;
      case 'login':
        emit(SplashUnauthenticated());
        break;
      case 'verify_mail':
        emit(SplashEmailVerificationRequired());
        break;
      default:
        emit(SplashAuthenticated());
        break;
    }
  }

}
