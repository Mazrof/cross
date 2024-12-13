import 'package:equatable/equatable.dart';
import 'package:telegram/feature/groups/add_new_group/domain/entity/chat_tile_data.dart';
import 'package:telegram/feature/groups/group_setting/data/model/group_setting_model.dart';
import 'package:telegram/feature/groups/group_setting/data/model/membership_model.dart';
import 'package:telegram/core/utililes/app_enum/app_enum.dart';

class MembersState extends Equatable {
  final GroupModel? group;

  final String? errorMessage;
  final CubitState state;
  final List<chatTileData> allMembers;
  final List<chatTileData> selectedMembers;

  MembersState({
    this.group,
    this.state = CubitState.initial,
    this.errorMessage,
    required this.allMembers,
    required this.selectedMembers,
  });

  MembersState copyWith({
    GroupModel? group,
    List<MembershipModel>? members,
    CubitState? state,
    String? errorMessage,
    List<chatTileData>? allMembers,
    List<chatTileData>? selectedMembers,
  }) {
    return MembersState(
      group: group ?? this.group,
      state: state ?? this.state,
      errorMessage: errorMessage ?? this.errorMessage,
      allMembers: allMembers ?? this.allMembers,
      selectedMembers: selectedMembers ?? this.selectedMembers,
    );
  }

  @override
  List<Object?> get props => [
        group,
        state,
        errorMessage,
        allMembers,
        selectedMembers,
      ];
}
