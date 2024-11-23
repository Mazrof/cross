import 'package:telegram/core/utililes/app_enum/app_enum.dart';
import 'package:telegram/feature/dashboard/domain/entity/user.dart';

class BannedUsersState {
  final List<User> bannedUsers;
  final CubitState currState;
  final String? errorMessage;

  BannedUsersState({
    required this.bannedUsers,
    this.currState = CubitState.initial,
    this.errorMessage,
  });

  BannedUsersState copyWith({
    List<User>? users,
    List<User>? bannedUsers,
    CubitState? currState,
    String? errorMessage,
  }) {
    return BannedUsersState(
      bannedUsers: bannedUsers ?? this.bannedUsers,
      currState: currState ?? this.currState,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
