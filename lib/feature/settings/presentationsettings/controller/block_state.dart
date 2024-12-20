import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:telegram/core/utililes/app_enum/app_enum.dart';
import 'package:telegram/feature/settings/domainsettings/entities/user_settings_entity.dart';

class BlockState extends Equatable {
  final CubitState state;
  final String? errorMessage;
  final List<BlockedUser> blockedUsers;
  final List<BlockableContacts> contacts;

  BlockState({
    this.state = CubitState.initial,
    this.errorMessage,
    List<BlockedUser>? blockedUsers,
    List<BlockableContacts>? contacts,
  })  : blockedUsers = blockedUsers ?? [],
        contacts = contacts ?? [];

  BlockState copyWith({
    CubitState? state,
    String? errorMessage,
    List<BlockedUser>? blockedUsers,
    List<BlockableContacts>? contacts,
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
