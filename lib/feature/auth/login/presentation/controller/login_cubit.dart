import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:telegram/core/local/cache_helper.dart';
import 'package:telegram/core/local/hive.dart';
import 'package:telegram/core/network/network_manager.dart';
import 'package:telegram/core/utililes/app_enum/app_enum.dart';
import 'package:telegram/core/validator/app_validator.dart';
import 'package:telegram/feature/auth/login/data/model/login_request_model.dart';
import 'package:telegram/feature/auth/login/domain/use_cases/login_use_case.dart';
import 'package:telegram/feature/auth/login/domain/use_cases/login_with_github_use_case.dart';
import 'package:telegram/feature/auth/login/domain/use_cases/login_with_google_use_case.dart';
import 'package:telegram/feature/auth/login/presentation/controller/login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final LoginUseCase loginUseCase;
  final LoginWithGoogleUseCase loginWithGoogleUseCase;
  final LoginWithGithubUseCase loginWithGithubUseCase;
  final NetworkManager networkManager;
  final AppValidator appValidator;

  LoginCubit(
      {required this.loginWithGoogleUseCase,
      required this.loginWithGithubUseCase,
      required this.appValidator,
      required this.networkManager,
      required this.loginUseCase})
      : super(const LoginState()) {
    //first make sure there is an box with the name 'register_info'
    if ((Hive.isBoxOpen('register_info'))) {
      //then check if there is an email and password in the box

      var email = HiveCash.read<String>(boxName: 'register_info', key: 'email');
      var password =
          HiveCash.read<String>(boxName: 'register_info', key: 'password');
      if (email != null && password != null) {
        emailController.text = email;
        passwordController.text = password;
        emit(state.copyWith(rememberMe: true));
      }
    }
  }

  Timer? _timer;
  final Duration timerDuration = const Duration(seconds: 1);

  void login() async {
    if (appValidator.isFormValid(formKey)) {
      if (state.remainingAttempts > 0) {
        emit(state.copyWith(state: LoginStatusEnum.loading, error: ''));
        bool connection = await networkManager.isConnected();

        if (!connection) {
          emit(state.copyWith(
              state: LoginStatusEnum.error, error: 'No Internet Connection'));
          return;
        }

        emitLoginStates(LoginRequestBody(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
          rememberMe: state.rememberMe,
        ));
      } else {
        startTimer();
      }
    } else {
      emit(state.copyWith(
          state: LoginStatusEnum.error,
          error: 'Please enter your email and password'));
    }
  }

  Future<void> signInWithGoogle() async {
    bool connection = await networkManager.isConnected();

    if (!connection) {
      emit(state.copyWith(
          state: LoginStatusEnum.error, error: 'No Internet Connection'));
      return;
    }

    final result = await loginWithGoogleUseCase.call();

    result.fold((l) {
      emit(state.copyWith(
          state: LoginStatusEnum.error, error: 'something went wrong'));
    }, (r) {
      emit(state.copyWith(state: LoginStatusEnum.success, error: ''));
      setloged();
    });
  }

  Future<void> signInWithGithub(context) async {
    bool connection = await networkManager.isConnected();

    if (!connection) {
      emit(state.copyWith(
          state: LoginStatusEnum.error, error: 'No Internet Connection'));
      return;
    }

    final result = await loginWithGithubUseCase.call(context);

    result.fold((l) {
      emit(state.copyWith(
          state: LoginStatusEnum.error, error: 'something went wrong'));
    }, (r) {
      emit(state.copyWith(state: LoginStatusEnum.success, error: ''));
      setloged();
    });
  }

  void emitLoginStates(LoginRequestBody loginRequestBody) async {
    print('start login');
    final result = await loginUseCase.call(loginRequestBody);
    print('end login');
    result.fold((failure) {
      int newRemainingAttempts = state.remainingAttempts - 1;

      if (newRemainingAttempts == 0) {
        startTimer();
        emit(state.copyWith(
          state: LoginStatusEnum.suspended,
          remainingAttempts: newRemainingAttempts,
          error: 'You have reached the maximum number of attempts',
        ));
      } else {
        emit(state.copyWith(
          state: LoginStatusEnum.error,
          error: 'Invalid email or password',
          remainingAttempts: newRemainingAttempts,
        ));
      }
    }, (unit) async {
      resetTimer();
      emit(state.copyWith(state: LoginStatusEnum.success));
      setloged();
    });
  }

  void toggleRememberMe(bool? value) {
    emit(state.copyWith(
        rememberMe: value!, error: '', state: LoginStatusEnum.idle));
  }

  void togglePasswordVisibility() {
    emit(
      state.copyWith(
          obscureText: !state.obscureText,
          error: '',
          state: LoginStatusEnum.idle),
    );
  }

  void startTimer() {
    emit(state.copyWith(secondsRemaining: state.secondsRemaining, error: ''));
    _timer?.cancel();
    _timer = Timer.periodic(timerDuration, (timer) {
      if (state.secondsRemaining > 0) {
        emit(state.copyWith(
            secondsRemaining: state.secondsRemaining - 1, error: ''));
      } else {
        _timer?.cancel();
        emit(state.copyWith(
          state: LoginStatusEnum.suspendedComplete,
          remainingAttempts: 3,
          secondsRemaining: 60,
          error: '',
        ));
      }
    });
  }

  void setloged() {
    CacheHelper.write(key: 'loged', value: 'true');
  }

  void resetTimer() {
    _timer?.cancel();
    emit(state.copyWith(remainingAttempts: 3, secondsRemaining: 60, error: ''));
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    emailController.dispose();
    passwordController.dispose();
    return super.close();
  }
}
