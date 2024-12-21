import 'package:equatable/equatable.dart';
import 'package:telegram/core/utililes/app_enum/app_enum.dart';
import 'package:telegram/feature/dashboard/data/model/group_model.dart';
import 'package:telegram/feature/dashboard/domain/entity/group.dart';

class GroupsState extends Equatable {
  final List<GroupModel> groups;
  final CubitState currState;
  final String? errorMessage;

  GroupsState({
    required this.groups,
    this.currState = CubitState.initial,
    this.errorMessage,
  });

  GroupsState copyWith({
    List<GroupModel>? groups,
    CubitState? currState,
    String? errorMessage,
  }) {
    return GroupsState(
      groups: groups ?? this.groups,
      currState: currState ?? this.currState,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
  
  @override
  // TODO: implement props
  List<Object?> get props => [groups, currState, errorMessage];

 

}
