import 'package:equatable/equatable.dart';
import 'package:telegram/core/utililes/app_enum/app_enum.dart';
import 'package:telegram/feature/groups/add_new_group/data/model/chat_tile_model.dart';
import 'package:telegram/feature/groups/add_new_group/data/model/groups_model.dart';
import 'package:telegram/feature/home/data/model/chat_model.dart';

class AddMembersState extends Equatable {
  final List<ChatModel> allMembers;
  final List<ChatModel> selectedMembers;
  final String groupName; // Keep track of group name only
  final CubitState state;
  final String errorMessage;
  final String? groupImageUrl;
  final GroupsModel? group;

  const AddMembersState({
    this.groupImageUrl,
    required this.groupName,
    this.allMembers = const [],
    this.selectedMembers = const [],
    this.state = CubitState.initial,
    this.errorMessage = '',
    this.group,
  });

  AddMembersState copyWith({
    List<ChatModel>? allMembers,
    List<ChatModel>? selectedMembers,
    String? groupImageUrl,
    String? groupName,
    CubitState? state,
    String? errorMessage,
    GroupsModel? group,
  }) {
    return AddMembersState(
      groupName: groupName ?? this.groupName,
      allMembers: allMembers ?? this.allMembers,
      selectedMembers: selectedMembers ?? this.selectedMembers,
      state: state ?? this.state,
      groupImageUrl: groupImageUrl ?? this.groupImageUrl,
      errorMessage: errorMessage ?? "",
      group: group ?? this.group,
    );
  }

  @override
  List<Object?> get props =>
      [allMembers, selectedMembers, state, errorMessage, groupImageUrl, group];
}
