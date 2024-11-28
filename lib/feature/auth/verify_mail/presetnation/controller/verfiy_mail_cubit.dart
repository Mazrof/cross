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
  ) : super(VerifyMailState());

  Timer? _timer;
  static const int _otpTimeout = 60; // 1 minute in seconds

  final otpController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  /// **Start the OTP Timer**
  void startOtpTimer() {
    emit(state.copyWith(remainingTime: _otpTimeout));
    _timer?.cancel(); // Ensure no duplicate timers
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state.remainingTime > 0) {
        emit(state.copyWith(
            remainingTime: state.remainingTime - 1,
            status: VerifyMailStatus.initial));
      } else {
        _timer?.cancel();
        emit(state.copyWith(
          status: VerifyMailStatus.timeout,
          errorMessage: 'OTP has expired. Please request a new one.',
        ));
      }
    });
  }

  /// **Reset the OTP Timer**
  void resetOtpTimer() {
    _timer?.cancel();
    startOtpTimer();
  }

  /// **Send Verification Mail**
  void sendVerificationMail(String param1, String param2) async {
    try {
      if (!await networkManager.isConnected()) {
        emit(state.copyWith(
          status: VerifyMailStatus.error,
          errorMessage: 'No internet connection',
        ));
        return;
      }
      emit(state.copyWith(status: VerifyMailStatus.loading));

      final result = await sendOtpUseCase(param1, param2);
      if (result.isRight()) {
        startOtpTimer();
        emit(state.copyWith(status: VerifyMailStatus.optSent));
      } else {
        emit(state.copyWith(
          status: VerifyMailStatus.error,
          errorMessage: 'Failed to send OTP',
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        status: VerifyMailStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  /// **Resend OTP**
  void resendOtp(String param1, String param2) async {
    try {
      if (!await networkManager.isConnected()) {
        emit(state.copyWith(
          status: VerifyMailStatus.error,
          errorMessage: 'No internet connection',
        ));
        return;
      }
      emit(state.copyWith(status: VerifyMailStatus.loading));

      final result = await sendOtpUseCase(param1, param2);
      if (result.isRight()) {
        startOtpTimer();
        emit(state.copyWith(status: VerifyMailStatus.optSent));
      } else {
        emit(state.copyWith(
          status: VerifyMailStatus.error,
          errorMessage: 'Failed to resend OTP',
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        status: VerifyMailStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  /// **Verify OTP**
  void verifyOtp(String method, String param, String opt) async {
    try {
      if (state.remainingTime <= 0) {
        emit(state.copyWith(
          status: VerifyMailStatus.error,
          errorMessage: 'OTP has expired',
        ));
        return;
      }

      if (!await networkManager.isConnected()) {
        emit(state.copyWith(
          status: VerifyMailStatus.error,
          errorMessage: 'No internet connection',
        ));
        return;
      }
      emit(state.copyWith(status: VerifyMailStatus.loading));

      final data = VerifyMailData(
          method: method, email: param, code: opt); // Create the data object
      final result = await verifyOtpUseCase(data);
      if (result.isRight()) {
        _timer?.cancel(); // Stop the timer on successful verification
        emit(state.copyWith(
          status: VerifyMailStatus.success,
          isOtpVerified: true,
        ));
        verifyMail();
      } else {
        emit(state.copyWith(
          status: VerifyMailStatus.error,
          errorMessage: 'Invalid OTP',
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        status: VerifyMailStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  /// **Verify Email**
  void verifyMail() {
    CacheHelper.write(key: 'registered', value: false);
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    // otpController.dispose();
    return super.close();
  }
}
