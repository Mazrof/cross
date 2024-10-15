import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:telegram/feature/auth/login/presentation/controller/login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool rememberMe = false;
  bool obscureText = true;

  LoginCubit() : super(LoginInitial());

  void login() {
    if (formKey.currentState?.validate() ?? false) {
      // Perform login logic here
      emit(LoginSuccess());
    }
  }

  void toggleRememberMe(bool? value) {
    rememberMe = value ?? false;
    emit(LoginRememberMeToggled(rememberMe));
  }

  void togglePasswordVisibility() {
    obscureText = !obscureText;
    emit(LoginPasswordVisibilityToggled(obscureText));
  }
}
