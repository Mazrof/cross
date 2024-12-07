import 'package:equatable/equatable.dart';

enum VerifyMailStatus { initial, loading, success, error, optSent, timeout }

class VerifyMailState extends Equatable {
  final VerifyMailStatus status;
  final String? errorMessage;
  final int remainingTime;
  final String method;

  const VerifyMailState({
    this.remainingTime = 60,
    this.method = 'email',
    this.status = VerifyMailStatus.initial,
    this.errorMessage = '',
  });

  VerifyMailState copyWith({
    int? remainingTime,
    VerifyMailStatus? status,
    String? errorMessage,
    bool? isOtpVerified,
    String? method,
  }) {
    return VerifyMailState(
      remainingTime: remainingTime ?? this.remainingTime,
      method: method ?? this.method,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [method, status, errorMessage, remainingTime];

  @override
  // TODO: implement hashCode
  int get hashCode =>
      method.hashCode ^
      status.hashCode ^
      errorMessage.hashCode ^
      remainingTime.hashCode;
}
