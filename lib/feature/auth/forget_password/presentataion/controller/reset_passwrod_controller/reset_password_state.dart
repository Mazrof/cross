import 'package:equatable/equatable.dart';
import 'package:telegram/core/utililes/app_enum/app_enum.dart';

class ResetPasswordState extends Equatable {
  final CubitState state;
  final String? errorMessage;
  final bool isPasswordVisible;
  final bool isConfirmPasswordVisible;

  ResetPasswordState({
    this.state = CubitState.initial,
    this.errorMessage,
    this.isPasswordVisible = false,
    this.isConfirmPasswordVisible = false,
  });

  ResetPasswordState copyWith({
    CubitState? state,
    String? errorMessage,
    bool? isPasswordVisible,
    bool? isConfirmPasswordVisible,
  }) {
    return ResetPasswordState(
      state: state ?? this.state,
      errorMessage: errorMessage ?? this.errorMessage,
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      isConfirmPasswordVisible:
          isConfirmPasswordVisible ?? this.isConfirmPasswordVisible,
    );
  }

  @override
  List<Object?> get props => [
        state,
        errorMessage,
        isPasswordVisible,
        isConfirmPasswordVisible,
      ];
}
