import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:telegram/core/local/cache_helper.dart';
import 'package:telegram/core/network/network_manager.dart';
import 'package:telegram/feature/auth/verify_mail/domain/entity/verify_mail_data.dart';
import 'package:telegram/feature/auth/verify_mail/domain/use_case/send_otp_use_case.dart';
import 'package:telegram/feature/auth/verify_mail/domain/use_case/verify_otp_use_case.dart';
import 'package:telegram/feature/auth/verify_mail/presetnation/controller/verfiy_mail_state.dart';

class VerifyMailCubit extends Cubit<VerifyMailState> {
  final SendOtpUseCase sendOtpUseCase;
  final VerifyOtpUseCase verifyOtpUseCase;
  final NetworkManager networkManager;

  VerifyMailCubit(
    this.networkManager,
    this.sendOtpUseCase,
    this.verifyOtpUseCase,
  ) : super(const VerifyMailState());

  void verifyMail(BuildContext context) {
    CacheHelper.write(key: 'isMailVerified', value: true);
  }

  Timer? _timer;
  static const int _otpTimeout = 300; // 5 minutes in seconds

  void startOtpTimer() {
    emit(state.copyWith(remainingTime: _otpTimeout));
    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (state.remainingTime > 0) {
        emit(state.copyWith(remainingTime: state.remainingTime - 1));
      } else {
        _timer?.cancel();
        emit(state.copyWith(status: VerifyMailStatus.timeout));
      }
    });
  }

  void resetOtpTimer() {
    _timer?.cancel();
    startOtpTimer();
  }

  // Send verification mail
  void sendVerificationMail(String param1, String param2) async {
    try {
      bool connection = await networkManager.isConnected();
      if (!connection) {
        emit(state.copyWith(
            status: VerifyMailStatus.error,
            errorMessage: 'No internet connection'));
        return;
      }
      emit(state.copyWith(status: VerifyMailStatus.loading));
      final result = await sendOtpUseCase(param1, param2);
      if (result.isRight()) {
        emit(state.copyWith(status: VerifyMailStatus.optSent));
        startOtpTimer();
      } else {
        emit(state.copyWith(
            status: VerifyMailStatus.error,
            errorMessage: 'Failed to send OTP'));
      }
    } catch (e) {
      emit(state.copyWith(
          status: VerifyMailStatus.error, errorMessage: e.toString()));
    }
  }

  // Resend OTP
  void resendOtp(String param1, String param2) async {
    try {
      bool connection = await networkManager.isConnected();
      if (!connection) {
        emit(state.copyWith(
            status: VerifyMailStatus.error,
            errorMessage: 'No internet connection'));
        return;
      }
      emit(state.copyWith(status: VerifyMailStatus.loading));
      final result = await sendOtpUseCase(param1, param2);
      if (result.isRight()) {
        emit(state.copyWith(status: VerifyMailStatus.optSent));
        resetOtpTimer();
      } else {
        emit(state.copyWith(
            status: VerifyMailStatus.error,
            errorMessage: 'Failed to resend OTP'));
      }
    } catch (e) {
      emit(state.copyWith(
          status: VerifyMailStatus.error, errorMessage: e.toString()));
    }
  }

  // Verify OTP
  void verifyOtp(String method, String param, String otp) async {
    try {
      if (state.status == VerifyMailStatus.timeout) {
        emit(state.copyWith(
            status: VerifyMailStatus.error, errorMessage: 'OTP has expired'));
        return;
      }

      emit(state.copyWith(status: VerifyMailStatus.loading));
      bool connection = await networkManager.isConnected();
      if (!connection) {
        emit(state.copyWith(
            status: VerifyMailStatus.error,
            errorMessage: 'No internet connection'));
        return;
      }
      emit(state.copyWith(status: VerifyMailStatus.loading));
      final data = VerifyMailData(method: method, email: param, code: otp);

      final result = await verifyOtpUseCase(data);
      if (result.isRight()) {
        _timer?.cancel();
        emit(state.copyWith(
            status: VerifyMailStatus.success, isOtpVerified: true));
      } else {
        emit(state.copyWith(
            status: VerifyMailStatus.error, errorMessage: 'Invalid OTP'));
      }
    } catch (e) {
      emit(state.copyWith(
          status: VerifyMailStatus.error, errorMessage: e.toString()));
    }
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
