import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:telegram/core/local/cache_helper.dart';
import 'package:telegram/core/network/network_manager.dart';
import 'package:telegram/core/validator/app_validator.dart';
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
      final result =await sendOtpUseCase(param1, param2);
      if (result.isRight()) {
        emit(state.copyWith(status: VerifyMailStatus.optSent));
      } else {
        emit(state.copyWith(
            status: VerifyMailStatus.error,
            errorMessage: 'Failed to send OTP'));
      }
    }
    catch (e) {
      emit(state.copyWith(
          status: VerifyMailStatus.error, errorMessage: e.toString()));
    }
  }

  // Verify OTP
  void verifyOtp(String method, String param, String otp) async {
    try {
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
}
