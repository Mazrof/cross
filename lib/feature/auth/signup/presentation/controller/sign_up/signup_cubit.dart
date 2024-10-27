import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:telegram/core/network/network_manager.dart';
import 'package:telegram/core/utililes/app_enum/app_enum.dart';
import 'package:telegram/feature/auth/signup/data/model/sign_up_body_model.dart';
import 'package:telegram/feature/auth/signup/domain/use_cases/register_use_case.dart';
import 'package:telegram/feature/auth/signup/domain/use_cases/save_register_info_use_case.dart';
import 'package:telegram/feature/auth/signup/presentation/controller/sign_up/signup_state.dart';

class SignUpCubit extends Cubit<SignupState> {

  SignUpCubit({required this.registerUseCase,
  required this.saveRegisterInfoUseCase
  }) : super(SignupState());

  final RegisterUseCase registerUseCase;
  final SaveRegisterInfoUseCase saveRegisterInfoUseCase;


  // Text editing controllers for form fields
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // Create unique GlobalKeys for each TextFormField
  final firstNameKey = GlobalKey<FormFieldState>();
  final lastNameKey = GlobalKey<FormFieldState>();
  final emailKey = GlobalKey<FormFieldState>();
  final phoneKey = GlobalKey<FormFieldState>();
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

  void togglePrivacyPolicyAcceptance() {
    emit(state.copyWith(
        isPrivacyPolicyAccepted: !state.isPrivacyPolicyAccepted));
  }


void signUp() async {
    if (formKey.currentState?.validate()??false) {
      if(state.isPrivacyPolicyAccepted==false){
        emit(state.copyWith(
            state: SignUpState.failure,
            errorMessage: 'Please accept the privacy policy'));
        return;
      }
      if (state.state != SignUpState.loading) {
        emit(state.copyWith(state: SignUpState.loading));
        bool connection = await NetworkManager().isConnected();

        if (!connection) {
          emit(state.copyWith(
              state: SignUpState.failure,
              errorMessage: 'No Internet Connection'));
          return;
        }

        emitSignUpStates(SignUpBodyModel(
          firstName: firstNameController.text.trim(),
          lastName: lastNameController.text.trim(),
          email: emailController.text.trim(),
          phone: phoneController.text.trim(),
          password: passwordController.text.trim(),
        ));
      }
    } else {
      emit(state.copyWith(
          state: SignUpState.failure,
          errorMessage: 'Please fill in all required fields'));
    }
  }

  
void emitSignUpStates(SignUpBodyModel signUpRequestBody) async {
    await registerUseCase.call(signUpRequestBody).then((value) async {
      value.fold((failure) {
        emit(state.copyWith(
          state: SignUpState.failure,
          errorMessage: failure.message,
        ));
      }, (unit) async {
        // Call the save data use case here
        await saveRegisterInfoUseCase
            .call(signUpRequestBody).then((saveResult) {
          saveResult.fold((saveFailure) {
            emit(state.copyWith(
              state: SignUpState.failure,
              errorMessage: saveFailure.message,
            ));
          }, (saveSuccess) {
            emit(state.copyWith(state: SignUpState.success));
          });
        });
      });
    });
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
