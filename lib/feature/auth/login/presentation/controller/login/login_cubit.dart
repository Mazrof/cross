import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:telegram/core/network/network_manager.dart';
import 'package:telegram/core/utililes/app_enum/app_enum.dart';
import 'package:telegram/feature/auth/login/data/model/login_request_model.dart';
import 'package:telegram/feature/auth/login/domain/use_cases/use_case.dart';
import 'package:telegram/feature/auth/login/presentation/controller/login/login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final LoginUseCase loginUseCase;

  LoginCubit({required this.loginUseCase}) : super(const LoginState());

  Timer? _timer;
  final Duration timerDuration = const Duration(seconds: 1);

  void login() async {
    if (formKey.currentState?.validate() ?? false) {
      if (state.remainingAttempts > 0) {
        emit(state.copyWith(state: LoginStatusEnum.loading));
        bool conncection = await NetworkManager().isConnected();

        if (!conncection) {
          emit(state.copyWith(
              state: LoginStatusEnum.error, error: 'No Internet Connection'));
          return;
        }
        print('LoginCubit: login: email: ${emailController.text.trim()}');

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

  void emitLoginStates(LoginRequestBody loginRequestBody) async {
    print('here');
    await loginUseCase.call(loginRequestBody).then((value) async {
      value.fold((failure) {
        int newRemainingAttempts = state.remainingAttempts - 1;

        if (newRemainingAttempts == 0) {
          startTimer();
          emit(state.copyWith(
            state: LoginStatusEnum.suspended,
            remainingAttempts: newRemainingAttempts,
          ));
        } else {
          emit(state.copyWith(
            state: LoginStatusEnum.error,
            error: failure.message,
            remainingAttempts: newRemainingAttempts,
          ));
        }
      }, (unit) async {
        resetTimer();
        emit(state.copyWith(state: LoginStatusEnum.success));
      });
    });
  }

  void toggleRememberMe(bool? value) {
    emit(state.copyWith(rememberMe: value!));
  }

  void togglePasswordVisibility() {
    emit(state.copyWith(obscureText: !state.obscureText));
  }

  void startTimer() {
    emit(state.copyWith(secondsRemaining: state.secondsRemaining));
    _timer?.cancel();
    _timer = Timer.periodic(timerDuration, (timer) {
      if (state.secondsRemaining > 0) {
        emit(state.copyWith(secondsRemaining: state.secondsRemaining - 1));
      } else {
        _timer?.cancel();
        emit(state.copyWith(
          state: LoginStatusEnum.suspendedComplete,
          remainingAttempts: 3,
          secondsRemaining: 60,
        ));
      }
    });
  }

  void resetTimer() {
    _timer?.cancel();
    emit(state.copyWith(remainingAttempts: 3, secondsRemaining: 60));
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    emailController.dispose();
    passwordController.dispose();
    return super.close();
  }
}
