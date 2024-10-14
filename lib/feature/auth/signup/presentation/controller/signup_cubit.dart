import 'package:bloc/bloc.dart';

import 'package:flutter/material.dart';
import 'package:telegram/core/di/service_locator.dart';
import 'package:telegram/core/network/network_manager.dart';
import 'package:telegram/feature/auth/signup/presentation/controller/signup_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpInitial());

  // final SignUpUseCase signUpUseCase;

  // Text editing controllers for form fields
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

   // Create unique GlobalKeys for each TextFormField
    final firstNameKey = GlobalKey<FormFieldState>();
    final lastNameKey = GlobalKey<FormFieldState>();
    final usernameKey = GlobalKey<FormFieldState>();
    final emailKey = GlobalKey<FormFieldState>();
    final phoneKey = GlobalKey<FormFieldState>();
    final passwordKey = GlobalKey<FormFieldState>();
    final confirmPasswordKey = GlobalKey<FormFieldState>();

  // Form key for validation
// Form key for validation
  final formKey = GlobalKey<FormState>();

  // Observables for password visibility
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;
  bool isPrivacyPolicyAccepted = false;

  // Toggle password visibility
  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    emit(SignUpPasswordVisibilityChanged(isPasswordVisible));
  }

  // Toggle confirm password visibility
  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible = !isConfirmPasswordVisible;
    emit(SignUpConfirmPasswordVisibilityChanged(isConfirmPasswordVisible));
  }

  // Toggle privacy policy acceptance
  void togglePrivacyPolicyAcceptance(bool? value) {
    isPrivacyPolicyAccepted = value ?? false;
    emit(SignUpPrivacyPolicyAcceptanceChanged(isPrivacyPolicyAccepted));
  }

  // Validate and submit the form
  Future<void> submitForm(BuildContext context) async {
    print('submitForm');
    // start the loading state
    try {
      // ScreenLoader.openLoadingDialog('Please wait...', AppImageString.loading);
      print('ScreenLoader.openLoadingDialog');

      //check internet connection
      final isConnected = await sl<NetworkManager>().isConnected();
      print('isConnected: $isConnected');

      if (isConnected == false) {
        // ScreenLoader.stopLoadingDialog();
        // Messages.showErrorSnakeBar(
        //     'No internet connection', 'Please check your internet settings');

        return;
      }

      // Validate the form
      if (formKey.currentState!.validate()) {
        // Perform signup logic here
        // Check if privacy policy is accepted
        if (!isPrivacyPolicyAccepted) {
          //privacy policy check

          // ScreenLoader.stopLoadingDialog();
          // Messages.showErrorSnakeBar(
          //     'Error', 'Please accept the privacy policy');
          return;
        }
      } else {
        // ScreenLoader.stopLoadingDialog();
        // Messages.showErrorSnakeBar('Error', 'Please fill all fields correctly');

        return;
      }

      // register user in firebase auth & save user Data in firebase
      // final userModel = UserModel(
      //   id: '',
      //   firstName: firstNameController.text.trim(),
      //   lastName: lastNameController.text.trim(),
      //   username: usernameController.text.trim(),
      //   email: emailController.text.trim(),
      //   phone: phoneController.text.trim(),
      //   password: passwordController.text.trim(),
      //   profileImage: '',
      // );
      // final result = await signUpUseCase(userModel);

      // Handle the result
    //   result.fold(
    //     (failure) {
    //       Messages.showErrorSnakeBar('Error', failure.message);
    //     },
    //     (isRegistered) {
    //       if (isRegistered) {
    //         Messages.showSuccessSnakeBar(
    //             'Success', 'User registration successful');

    //         // LOCAL STORAGE
    //         TAppLocalStorage.saveData('user', UserData.userModel.toJson());
    //         ScreenLoader.verifyEmail();
    //       } else {
    //         Messages.showErrorSnakeBar('Error', 'User registration failed');
    //       }
    //     },
    //   );
    } catch (e) {
    //   ScreenLoader.stopLoadingDialog();
    //   print('Error in submitForm: $e');
    //   Messages.showErrorSnakeBar('Error', 'An error occurred');
    }
  }

 
}