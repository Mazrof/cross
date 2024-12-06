import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:telegram/core/utililes/app_enum/app_enum.dart';
import 'package:telegram/feature/groups/group_setting/data/model/group_setting_model.dart';
import 'package:telegram/feature/groups/group_setting/data/model/membership_model.dart';

class GroupState extends Equatable {
  final GroupModel? group;
  final List<MembershipModel> members;
  final String? errorMessage;
  final CubitState state;


  GroupState({
    this.group,
    this.members = const [],
    this.state = CubitState.initial,
    this.errorMessage,
  });

  GroupState copyWith({
    GroupModel? group,
    List<MembershipModel>? members,
    CubitState? state,
    String? errorMessage,
  }) {
    return GroupState(
      group: group ?? this.group,
      members: members ?? this.members,
      state: state ?? this.state,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props =>
      [group, members,state, errorMessage];
}
