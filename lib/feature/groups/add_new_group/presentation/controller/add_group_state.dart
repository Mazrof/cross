import 'package:equatable/equatable.dart';
import 'package:telegram/core/utililes/app_enum/app_enum.dart';
import 'package:telegram/feature/groups/add_new_group/data/model/chat_tile_model.dart';

class AddMembersState extends Equatable {
  final List<chatTileModel> allMembers;
  final List<chatTileModel> selectedMembers;
  final String groupName; // Keep track of group name only
  final CubitState state;
  final String errorMessage;
  final String? groupImageUrl;

  const AddMembersState({
    this.groupImageUrl,
    required this.groupName,
    this.allMembers = const [],
    this.selectedMembers = const [],
    this.state = CubitState.initial,
    this.errorMessage = '',
  });

  AddMembersState copyWith({
    List<chatTileModel>? allMembers,
    List<chatTileModel>? selectedMembers,
    String? groupImageUrl,
    String? groupName,
    CubitState? state,
    String? errorMessage,
  }) {
    return AddMembersState(
      groupName: groupName ?? this.groupName,
      allMembers: allMembers ?? this.allMembers,
      selectedMembers: selectedMembers ?? this.selectedMembers,
      state: state ?? this.state,
      groupImageUrl: groupImageUrl ?? this.groupImageUrl,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [allMembers, selectedMembers, state, errorMessage];
}
