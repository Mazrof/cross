
// Define the states
abstract class SignUpState {}

class SignUpInitial extends SignUpState {}

class SignUpPasswordVisibilityChanged extends SignUpState {
  final bool isPasswordVisible;
  SignUpPasswordVisibilityChanged(this.isPasswordVisible);
}

class SignUpConfirmPasswordVisibilityChanged extends SignUpState {
  final bool isConfirmPasswordVisible;
  SignUpConfirmPasswordVisibilityChanged(this.isConfirmPasswordVisible);
}

class SignUpPrivacyPolicyAcceptanceChanged extends SignUpState {
  final bool isPrivacyPolicyAccepted;
  SignUpPrivacyPolicyAcceptanceChanged(this.isPrivacyPolicyAccepted);
}