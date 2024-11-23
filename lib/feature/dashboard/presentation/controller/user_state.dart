import 'package:telegram/core/utililes/app_enum/app_enum.dart';
import 'package:telegram/feature/dashboard/domain/entity/user.dart';

class UsersState {
  final List<User> users;
  final CubitState currState;
  final String? errorMessage;

  UsersState({
    required this.users,
    this.currState = CubitState.initial,
    this.errorMessage,
  });

  UsersState copyWith({
    List<User>? users,
    List<User>? bannedUsers,
    CubitState? currState,
    String? errorMessage,
  }) {
    return UsersState(
      users: users ?? this.users,
      currState: currState ?? this.currState,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
