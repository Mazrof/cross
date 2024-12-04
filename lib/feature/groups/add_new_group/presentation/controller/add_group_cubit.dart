import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:telegram/core/utililes/app_enum/app_enum.dart';
import 'package:telegram/feature/groups/add_new_group/data/model/member_model.dart';
import 'package:telegram/feature/groups/add_new_group/domain/member.dart';
import 'package:telegram/feature/groups/add_new_group/presentation/controller/add_group_state.dart';

class AddMembersCubit extends Cubit<AddMembersState> {
  AddMembersCubit()
      : super(AddMembersState(
          groupName: '',
          allMembers: [],
          selectedMembers: [],
          state: CubitState.initial,
          errorMessage: '',
        ));

  void loadMembers() {
    emit(AddMembersState(
      groupName: '',
      state: CubitState.loading,
    ));

    // Simulate loading members
    Future.delayed(Duration(seconds: 2), () {
      final List<MemberModel> members = [
        MemberModel(
          id: 1,
          name: 'John Doe',
          imageUrl: 'https://example.com/john_doe.png',
          lastSeen: 'last seen at 4:29 PM',
        ),
        MemberModel(
          id: 2,
          name: 'Jane Smith',
          imageUrl: 'https://example.com/jane_smith.png',
          lastSeen: 'last seen at 10:00 AM',
        ),
      ];

      emit(state.copyWith(allMembers: members, state: CubitState.success));
    });
  }

  void toggleMember(MemberModel member) {
    final selectedMembers = List<MemberModel>.from(state.selectedMembers);

    if (selectedMembers.contains(member)) {
      selectedMembers.remove(member);
    } else {
      selectedMembers.add(member);
    }

    emit(state.copyWith(selectedMembers: selectedMembers));
  }

  void setGroupName(String name) {
    emit(state.copyWith(groupName: name));
  }

  void createGroup() {
    // Handle group creation logic
    print('Group created with members: ${state.selectedMembers}');
  }

  void setGroupImageUrl(String imageUrl) {
    emit(state.copyWith(groupImageUrl: imageUrl));
  }
}
