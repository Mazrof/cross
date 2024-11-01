import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:telegram/core/network/network_manager.dart';
import 'package:telegram/core/utililes/app_enum/app_enum.dart';
import 'package:telegram/feature/auth/forget_password/domain/usecase/log_out_use_case.dart';
import 'package:telegram/feature/auth/forget_password/domain/usecase/reset_password_use_case.dart';
import 'package:telegram/feature/auth/forget_password/presentataion/controller/reset_passwrod_controller/reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  ResetPasswordCubit(
      {required this.resetPasswordUsecase, required this.logOutUseCase}
  ) : super(ResetPasswordState());
  final ResetPasswordUseCase resetPasswordUsecase;
  final LogOutUseCase logOutUseCase;  

  // Text editing controllers for form fields

  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // Create unique GlobalKeys for each TextFormField

  final passwordKey = GlobalKey<FormFieldState>();
  final confirmPasswordKey = GlobalKey<FormFieldState>();

  // Form key for validation
  final formKey = GlobalKey<FormState>();

  void togglePasswordVisibility() {
    emit(state.copyWith(isPasswordVisible: !state.isPasswordVisible));
  }

  void toggleConfirmPasswordVisibility() {
    emit(state.copyWith(
        isConfirmPasswordVisible: !state.isConfirmPasswordVisible));
  }
  

  void resetPassword() async {
    if (formKey.currentState?.validate() ?? false) {
      if (passwordController.text != confirmPasswordController.text) {
        emit(state.copyWith(
            state: CubitState.failure,
            errorMessage: 'Password and confirm password does not match'));
        return;
      }
      emit(state.copyWith(state: CubitState.loading));
      final response = await NetworkManager().isConnected();
      if (!response) {
        final result = await resetPasswordUsecase(passwordController.text.trim(), confirmPasswordController.text.trim());
        result.fold(
          (failure) => emit(state.copyWith(
              state: CubitState.failure, errorMessage: failure.message)),
          (success) { 
            logOutUseCase();
            emit(state.copyWith(state: CubitState.success));
          }
        );
      
      }
    }
  }

  @override
  Future<void> close() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    return super.close();
  }
}
