import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:telegram/core/utililes/app_enum/app_enum.dart';

class BlockState extends Equatable {
  final CubitState state;
  final String? errorMessage;
  final List<String> blockedUsers;
  final List<String> contacts;

  BlockState({
    this.state = CubitState.initial,
    this.errorMessage,
    List<String>? blockedUsers,
    List<String>? contacts,
  })  : blockedUsers = blockedUsers ?? [],
        contacts = contacts ?? [];

  BlockState copyWith({
    CubitState? state,
    String? errorMessage,
    List<String>? blockedUsers,
    List<String>? contacts,
  }) {
    return BlockState(
      blockedUsers: blockedUsers ?? this.blockedUsers,
      contacts: contacts ?? this.contacts,
    );
  }

  @override
  List<Object?> get props => [
        state,
        errorMessage,
        blockedUsers,
        contacts,
      ];
}
