
import 'package:equatable/equatable.dart';

abstract class VerifyMailState extends Equatable {
  const VerifyMailState();

  @override
  List<Object> get props => [];
}

class VerifyMailInitial extends VerifyMailState {}

class VerifyMailLoading extends VerifyMailState {}

class VerifyMailSuccess extends VerifyMailState {}

class VerifyMailError extends VerifyMailState {
  final String message;

  const VerifyMailError(this.message);

  @override
  List<Object> get props => [message];
}