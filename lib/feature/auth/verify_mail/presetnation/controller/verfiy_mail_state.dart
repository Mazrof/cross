import 'package:equatable/equatable.dart';

enum VerifyMailStatus { initial, loading, success, error, optSent }

class VerifyMailState extends Equatable {
  final VerifyMailStatus status;
  final String? errorMessage;
  final bool isOtpVerified;
  final String method;

  const VerifyMailState({
    this.method = 'email',
    this.status = VerifyMailStatus.initial,
    this.errorMessage,
    this.isOtpVerified = false,
  });

  VerifyMailState copyWith({
    
    VerifyMailStatus? status,
    String? errorMessage,
    bool? isOtpVerified,
    String? method,
  }) {
    return VerifyMailState(
      method: method ?? this.method,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      isOtpVerified: isOtpVerified ?? this.isOtpVerified,
    );
  }

  @override
  List<Object?> get props => [method,
    status, errorMessage, isOtpVerified];
}
