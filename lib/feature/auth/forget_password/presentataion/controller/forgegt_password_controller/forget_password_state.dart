import 'package:equatable/equatable.dart';
import 'package:telegram/core/utililes/app_enum/app_enum.dart';


class ForgetPasswordState extends Equatable {
  final CubitState status;
  final String? email;
  final String? errorMessage;

  const ForgetPasswordState({
    this.status = CubitState.initial,
    this.email,
    this.errorMessage='',
  });

  ForgetPasswordState copyWith({
    CubitState? status,
    String? email,
    String? errorMessage,
  }) {
    return ForgetPasswordState(
      status: status ?? this.status,
      email: email ?? this.email,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, email, errorMessage];
}
