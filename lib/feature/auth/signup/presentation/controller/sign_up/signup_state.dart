import 'package:equatable/equatable.dart';
import 'package:telegram/core/utililes/app_enum/app_enum.dart';

class SignupState extends Equatable {
  final CubitState state;
  final String? errorMessage;
  final bool isPasswordVisible;
  final bool isConfirmPasswordVisible;
  final bool isPrivacyPolicyAccepted;

  SignupState({
    this.state = CubitState.initial,
    this.errorMessage,
    this.isPasswordVisible = false,
    this.isConfirmPasswordVisible = false,
    this.isPrivacyPolicyAccepted = false,
  });

  SignupState copyWith({
    CubitState? state,
    String? errorMessage,
    bool? isPasswordVisible,
    bool? isConfirmPasswordVisible,
    bool? isPrivacyPolicyAccepted,
  }) {
    return SignupState(
      state: state ?? this.state,
      errorMessage: errorMessage ?? this.errorMessage,
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      isConfirmPasswordVisible:
          isConfirmPasswordVisible ?? this.isConfirmPasswordVisible,
      isPrivacyPolicyAccepted:
          isPrivacyPolicyAccepted ?? this.isPrivacyPolicyAccepted,
    );
  }

  @override
  List<Object?> get props => [
        state,
        errorMessage,
        isPasswordVisible,
        isConfirmPasswordVisible,
        isPrivacyPolicyAccepted,
      ];




}
