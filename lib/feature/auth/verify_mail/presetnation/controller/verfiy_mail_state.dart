import 'package:equatable/equatable.dart';

enum VerifyMailStatus { initial, loading, success, error, optSent }

class VerifyMailState extends Equatable {
  final VerifyMailStatus status;
  final String? errorMessage;
 
  final String method;

  const VerifyMailState({
    this.method = 'email',
    this.status = VerifyMailStatus.initial,
    this.errorMessage,
   
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
  
    );
  }

  @override
  List<Object?> get props => [method,
    status, errorMessage];
}
