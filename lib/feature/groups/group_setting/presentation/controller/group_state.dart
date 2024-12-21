import 'package:equatable/equatable.dart';
import 'package:telegram/feature/groups/add_new_group/domain/entity/chat_tile_data.dart';
import 'package:telegram/feature/groups/group_setting/data/model/group_setting_model.dart';
import 'package:telegram/feature/groups/group_setting/data/model/membership_model.dart';
import 'package:telegram/core/utililes/app_enum/app_enum.dart';

class GroupState extends Equatable {
  final GroupModel? group;
  final List<MembershipModel> members;
  final String? errorMessage;
  final CubitState state;

  final bool ismute;

  GroupState({
     this.group ,
    this.members = const [],
    this.state = CubitState.initial,
    this.errorMessage,

     this.ismute=false,
  });

  GroupState copyWith({
    GroupModel? group,
    List<MembershipModel>? members,
    CubitState? state,
    String? errorMessage,
    List<chatTileData>? allMembers,
    List<chatTileData>? selectedMembers,
    bool? ismute,
  }) {
    return GroupState(
      group: group ?? this.group,
      members: members ?? this.members,
      state: state ?? this.state,
      errorMessage: errorMessage ?? this.errorMessage,

      ismute: ismute ?? this.ismute,
    );
  }

  @override
  List<Object?> get props => [
        group,
        members,
        state,
        errorMessage,
    
        ismute
      ];
}
