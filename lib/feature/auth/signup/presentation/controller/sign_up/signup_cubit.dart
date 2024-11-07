import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:telegram/core/component/csnack_bar.dart';
import 'package:telegram/core/network/network_manager.dart';
import 'package:telegram/core/utililes/app_enum/app_enum.dart';
import 'package:telegram/feature/auth/signup/data/model/sign_up_body_model.dart';
import 'package:telegram/feature/auth/signup/domain/use_cases/register_use_case.dart';
import 'package:telegram/feature/auth/signup/domain/use_cases/save_register_info_use_case.dart';
import 'package:telegram/feature/auth/signup/presentation/controller/sign_up/signup_state.dart';
import 'package:telegram/feature/auth/signup/presentation/widget/not_robot.dart';

class SignUpCubit extends Cubit<SignupState> {
  SignUpCubit({
    required this.registerUseCase,
    required this.saveRegisterInfoUseCase,
  }) : super(SignupState());

  final RegisterUseCase registerUseCase;
  final SaveRegisterInfoUseCase saveRegisterInfoUseCase;

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final firstNameKey = GlobalKey<FormFieldState>();
  final lastNameKey = GlobalKey<FormFieldState>();
  final emailKey = GlobalKey<FormFieldState>();
  final phoneKey = GlobalKey<FormFieldState>();
  final passwordKey = GlobalKey<FormFieldState>();
  final confirmPasswordKey = GlobalKey<FormFieldState>();

  final formKey = GlobalKey<FormState>();

  void togglePasswordVisibility() {
    emit(state.copyWith(isPasswordVisible: !state.isPasswordVisible));
  }

  void toggleConfirmPasswordVisibility() {
    emit(state.copyWith(
        isConfirmPasswordVisible: !state.isConfirmPasswordVisible));
  }

  void togglePrivacyPolicyAcceptance() {
    emit(state.copyWith(
        isPrivacyPolicyAccepted: !state.isPrivacyPolicyAccepted));
  }

  void signUp() async {
    if (formKey.currentState?.validate() ?? false) {
      if (state.isPrivacyPolicyAccepted == false) {
        emit(state.copyWith(
          state: CubitState.failure,
          errorMessage: 'Please accept the privacy policy',
        ));
        return;
      }
      if (state.state != CubitState.loading) {
        emit(state.copyWith(state: CubitState.loading));
        bool connection = await NetworkManager().isConnected();

        if (!connection) {
          emit(state.copyWith(
            state: CubitState.failure,
            errorMessage: 'No Internet Connection',
          ));
          return;
        }

        final recaptchaToken = await handleRecaptcha();
        if (recaptchaToken != null) {
          emitSignUpStates(SignUpBodyModel(
            firstName: firstNameController.text.trim(),
            lastName: lastNameController.text.trim(),
            email: emailController.text.trim(),
            phone: phoneController.text.trim(),
            password: passwordController.text.trim(),
            recaptchaToken: recaptchaToken,
          ));
        } else {
          emit(state.copyWith(
            state: CubitState.failure,
            errorMessage: 'reCAPTCHA verification failed.',
          ));
        }
      }
    } else {
      emit(state.copyWith(
        state: CubitState.failure,
        errorMessage: 'Please fill in all required fields',
      ));
    }
  }

  void emitSignUpStates(SignUpBodyModel signUpRequestBody) async {
    await registerUseCase.call(signUpRequestBody).then((value) async {
      value.fold((failure) {
        emit(state.copyWith(
          state: CubitState.failure,
          errorMessage: failure.message,
        ));
      }, (unit) async {
        await saveRegisterInfoUseCase
            .call(signUpRequestBody)
            .then((saveResult) {
          saveResult.fold((saveFailure) {
            emit(state.copyWith(
              state: CubitState.failure,
              errorMessage: saveFailure.message,
            ));
          }, (saveSuccess) {
            emit(state.copyWith(state: CubitState.success));
          });
        });
      });
    });
  }
Future<String?> handleRecaptcha() async {
    final recaptchaService =
        RecaptchaService(siteKey: "6LcFx2wqAAAAACsC9_PqBh15E-40sOioz2hQ9ml9");
    bool isRecaptchaReady = await recaptchaService.initialize();

    if (!isRecaptchaReady) {
      emit(state.copyWith(
        state: CubitState.failure,
        errorMessage: 'reCAPTCHA initialization failed.',
      ));
      return null;
    }

    String? token = await recaptchaService.executeRecaptcha("signup_action");
    if (token != null) {
      return token;
    } else {
      emit(state.copyWith(
        state: CubitState.failure,
        errorMessage: 'reCAPTCHA token retrieval failed.',
      ));
      return null;
    }
  }

  @override
  Future<void> close() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    return super.close();
  }
}
