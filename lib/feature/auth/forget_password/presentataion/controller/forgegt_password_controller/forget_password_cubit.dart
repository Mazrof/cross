import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:telegram/core/network/network_manager.dart';
import 'package:telegram/core/utililes/app_enum/app_enum.dart';
import 'package:telegram/core/validator/app_validator.dart';
import 'package:telegram/feature/auth/forget_password/domain/usecase/forget_password_use_case.dart';
import 'package:telegram/feature/auth/forget_password/presentataion/controller/forgegt_password_controller/forget_password_state.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  final ForgetPasswordUseCase forgetPasswordUseCase;
  ForgetPasswordCubit(
      {required this.appValidator,
      required this.networkManager,
      required this.forgetPasswordUseCase})
      : super(const ForgetPasswordState());
  final AppValidator appValidator;
  final NetworkManager networkManager;

  // Text editing controller for email field
  final emailController = TextEditingController();

  // Create a GlobalKey for the TextFormField
  final emailKey = GlobalKey<FormFieldState>();

  // Form key for validation
  final formKey = GlobalKey<FormState>();

  void sendResetLink() async {
    if (appValidator.isFormValid(formKey)) {
      emit(state.copyWith(
          status: CubitState.loading, email: emailController.text));
      final response = await networkManager.isConnected();
      if (response) {
        final result = await forgetPasswordUseCase(emailController.text);
        result.fold(
          (failure) => emit(state.copyWith(
              status: CubitState.failure, errorMessage: failure.message)),
          (success) => emit(state.copyWith(status: CubitState.success)),
        );
      } else {
        emit(state.copyWith(
            status: CubitState.failure,
            errorMessage: 'No Internet Connection'));
      }
    }
  }

  @override
  Future<void> close() {
    emailController.dispose();
    return super.close();
  }
}
