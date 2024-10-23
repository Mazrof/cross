import 'package:equatable/equatable.dart';
import 'package:telegram/core/utililes/app_enum/app_enum.dart';

class LoginState extends Equatable {
  final LoginStatusEnum state;
  final String? error;
  final bool rememberMe;
  final bool obscureText;
  final int remainingAttempts;
  final int secondsRemaining;

  const LoginState({
    this.state = LoginStatusEnum.init,
    this.error,
    this.rememberMe = false,
    this.obscureText = true,
    this.remainingAttempts = 3,
    this.secondsRemaining = 60,
  });

  LoginState copyWith({
    LoginStatusEnum? state,
    String? error,
    bool? rememberMe,
    bool? obscureText,
    int? remainingAttempts,
    int? secondsRemaining,
  }) {
    return LoginState(
      state: state ?? this.state,
      error: error ?? this.error,
      rememberMe: rememberMe ?? this.rememberMe,
      obscureText: obscureText ?? this.obscureText,
      remainingAttempts: remainingAttempts ?? this.remainingAttempts,
      secondsRemaining: secondsRemaining ?? this.secondsRemaining,
    );
  }

  @override
  List<Object?> get props => [
        state,
        error,
        rememberMe,
        obscureText,
        remainingAttempts,
        secondsRemaining,
      ];
}
