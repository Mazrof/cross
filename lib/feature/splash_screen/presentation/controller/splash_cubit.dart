import 'package:bloc/bloc.dart';
import 'package:telegram/core/helper/user_status_helper.dart';
import 'dart:async';
import 'package:uni_links5/uni_links.dart'; // For deep links
import 'package:telegram/feature/splash_screen/presentation/controller/splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial()) {
    // _initialize();
  }

  // void _initialize() async {
  //   emit(SplashLoading());
  //   await _handleDeepLink();
  // }

  Future<void> _handleDeepLink() async {
    try {
      final deepLink = await getInitialLink();
      if (deepLink != null) {
        handleDeepLink(deepLink);
      } else {
        checkAuthentication();
      }
    } catch (_) {
      checkAuthentication();
    }
  }

  void startAnimation() {
    emit(AnimationInProgress());
    Future.delayed(const Duration(milliseconds: 500), () {
      emit(AnimationMoved());
      _startTypewriterEffect('Your World is Just One Chat Away!', 0);
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
        _handleDeepLink(); // Check authentication after typewriter effect is completed
      }
    });
  }

  void checkAuthentication() async {
    emit(SplashLoading());

    // Check user status using UserStatusHelper
    String status = await UserStatusHelper.checkUserStatus();
    print(status);

    switch (status) {
      case 'onbording':
        emit(SplashFirstTime());
        print(state);
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

  void handleDeepLink(String? deepLink) {
    if (deepLink != null) {
      Uri uri = Uri.parse(deepLink);
      if (uri.path == '/reset-password') {
        final token = uri.queryParameters['token'];
        final id = uri.queryParameters['id'];
        if (token != null && id != null) {
          emit(SplashNavigateToResetPassword(token, id));
          return;
        }
      }
    }
    checkAuthentication();
  }
}
