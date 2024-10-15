// Define the states
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginSuccess extends LoginState {}

class LoginRememberMeToggled extends LoginState {
  final bool rememberMe;
  LoginRememberMeToggled(this.rememberMe);
}

class LoginPasswordVisibilityToggled extends LoginState {
  final bool obscureText;
  LoginPasswordVisibilityToggled(this.obscureText);
}