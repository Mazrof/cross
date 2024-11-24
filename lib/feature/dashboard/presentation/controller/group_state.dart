import 'package:telegram/core/utililes/app_enum/app_enum.dart';
import 'package:telegram/feature/dashboard/domain/entity/group.dart';

class GroupsState {
  final List<Group> groups;
  final CubitState currState;
  final String? errorMessage;

  GroupsState({
    required this.groups,
    this.currState = CubitState.initial,
    this.errorMessage,
  });

  GroupsState copyWith({
    List<Group>? groups,
    CubitState? currState,
    String? errorMessage,
  }) {
    return GroupsState(
      groups: groups ?? this.groups,
      currState: currState ?? this.currState,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
