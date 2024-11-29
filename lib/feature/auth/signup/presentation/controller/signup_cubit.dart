import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:telegram/core/network/network_manager.dart';
import 'package:telegram/core/utililes/app_enum/app_enum.dart';
import 'package:telegram/core/validator/app_validator.dart';
import 'package:telegram/feature/auth/signup/data/model/sign_up_body_model.dart';
import 'package:telegram/feature/auth/signup/domain/use_cases/check_recaptcha_tocken.dart';
import 'package:telegram/feature/auth/signup/domain/use_cases/register_use_case.dart';
import 'package:telegram/feature/auth/signup/domain/use_cases/save_register_info_use_case.dart';
import 'package:telegram/feature/auth/signup/presentation/controller/signup_state.dart';
import 'package:telegram/feature/auth/signup/presentation/widget/not_robot.dart';

class SignUpCubit extends Cubit<SignupState> {
  SignUpCubit(
      {required this.registerUseCase,
      required this.saveRegisterInfoUseCase,
      required this.appValidator,
      required this.recaptchaService,
      required this.checkRecaptchaTocken,
      required this.networkManager})
      : super(SignupState());

  final RegisterUseCase registerUseCase;
  final SaveRegisterInfoUseCase saveRegisterInfoUseCase;
  final AppValidator appValidator;
  final NetworkManager networkManager;
  final RecaptchaService recaptchaService;
  final CheckRecaptchaTocken checkRecaptchaTocken;

  // Text editing controllers for form fields
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // Create unique GlobalKeys for each TextFormField
  final usernameKey = GlobalKey<FormFieldState>();
  final emailKey = GlobalKey<FormFieldState>();
  final phoneKey = GlobalKey<FormFieldState>();
  final passwordKey = GlobalKey<FormFieldState>();
  final confirmPasswordKey = GlobalKey<FormFieldState>();

  // Form key for validation
  final formKey = GlobalKey<FormState>();

  void togglePasswordVisibility() {
    emit(state.copyWith(
        isPasswordVisible: !state.isPasswordVisible,
        errorMessage: '',
        state: CubitState.initial));
  }

  void toggleConfirmPasswordVisibility() {
    emit(state.copyWith(
        isConfirmPasswordVisible: !state.isConfirmPasswordVisible,
        errorMessage: '',
        state: CubitState.initial));
  }

  void togglePrivacyPolicyAcceptance() {
    emit(state.copyWith(
        isPrivacyPolicyAccepted: !state.isPrivacyPolicyAccepted,
        errorMessage: '',
        state: CubitState.initial));
  }

  void signUp() async {
    print('signUp1');
    if (appValidator.isFormValid(formKey) ?? false) {
      if (state.isPrivacyPolicyAccepted == false) {
        emit(state.copyWith(
          state: CubitState.failure,
          errorMessage: 'Please accept the privacy policy',
        ));
        return;
      }
      if (state.state != CubitState.loading) {
        emit(state.copyWith(state: CubitState.loading, errorMessage: ''));
        bool connection = await networkManager.isConnected();

        if (!connection) {
          emit(state.copyWith(
            state: CubitState.failure,
            errorMessage: 'No Internet Connection',

          ));
          return;
        }

        // final recaptchaToken = await recaptchaService.handleRecaptcha();
        // print('recaptchaToken: $recaptchaToken');
        // if (recaptchaToken == null) {
        //   emit(state.copyWith(
        //     state: CubitState.failure,
        //     errorMessage: 'reCAPTCHA verification failed.',
        //   ));
        //   return;
        // }
        // final response = await checkRecaptchaTocken.call(recaptchaToken);
        // if (response.isLeft() || response.isRight() == false) {
        //   emit(state.copyWith(
        //     state: CubitState.failure,
        //     errorMessage: 'reCAPTCHA verification failed.',
        //   ));
        //   return;
        // }


        emitSignUpStates(SignUpBodyModel(
          username: usernameController.text.trim(),
          email: emailController.text.trim(),
          phone: phoneController.text.trim(),
          password: passwordController.text.trim(),
        ));
      }
    } else {
      emit(state.copyWith(
        state: CubitState.failure,
        errorMessage: 'Please fill in all required fields',
      ));
    }
  }

  void emitSignUpStates(SignUpBodyModel signUpRequestBody) async {
    final id = await registerUseCase.call(signUpRequestBody);

    id.fold((failure) {
      emit(state.copyWith(
        state: CubitState.failure,
        errorMessage: 'Something went wrong, please try again',
      ));
    }, (unit) async {
      // Call the save data use case here
      signUpRequestBody.id = unit;

      await saveRegisterInfoUseCase
          .call(
        signUpRequestBody,
      )
          .then((saveResult) {
        saveResult.fold((saveFailure) {
          print(saveFailure.message);

          emit(state.copyWith(
            state: CubitState.failure,
            errorMessage: 'Something went wrong, please try again',
          ));
        }, (saveSuccess) {
          emit(state.copyWith(state: CubitState.success, errorMessage: ''));
        });
      });
    });
  }

  @override
  Future<void> close() {
    usernameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    return super.close();
  }
}
