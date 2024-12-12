import 'package:bloc/bloc.dart';
import 'package:telegram/core/network/network_manager.dart';
import 'package:telegram/core/utililes/app_enum/app_enum.dart';
import 'package:telegram/feature/groups/add_new_group/data/model/member_model.dart';
import 'package:telegram/feature/groups/add_new_group/domain/use_case/add_members_use_case.dart';
import 'package:telegram/feature/groups/group_setting/domain/entity/group_update_data.dart';
import 'package:telegram/feature/groups/group_setting/domain/use_case/delete_group_use_case.dart';
import 'package:telegram/feature/groups/group_setting/domain/use_case/fetch_group_details_use_case.dart';
import 'package:telegram/feature/groups/group_setting/domain/use_case/fetch_group_members_use_case.dart';
import 'package:telegram/feature/groups/group_setting/domain/use_case/remove_member_user.dart';
import 'package:telegram/feature/groups/group_setting/domain/use_case/update_group_use_case.dart';
import 'package:telegram/feature/groups/group_setting/domain/use_case/update_member_role.dart';
import 'package:telegram/feature/groups/group_setting/presentation/controller/group_state.dart';

class GroupCubit extends Cubit<GroupState> {
  GroupCubit(
    this.fetchGroupDetailsUseCase,
    this.updateMemberRoleUseCase,
    this.addMemberUseCase,
    this.removeMemberUseCase,
    this.deleteGroupUseCase,
    this.updateGroupDetailsUseCase,
    this.networkManager,
    this.fetchGroupMembersUseCase,
  ) : super(GroupState());

  final FetchGroupDetailsUseCase fetchGroupDetailsUseCase;
  final UpdateMemberRoleUseCase updateMemberRoleUseCase;
  final AddMembersUseCase addMemberUseCase;
  final RemoveMemberUseCase removeMemberUseCase;
  final DeleteGroupUseCase deleteGroupUseCase;
  final UpdateGroupDetailsUseCase updateGroupDetailsUseCase;
  final NetworkManager networkManager;
  final FetchGroupMembersUseCase fetchGroupMembersUseCase;

  void fetchGroupDetails(int groupId) async {
    emit(state.copyWith(state: CubitState.loading));
    try {
      final group = await fetchGroupDetailsUseCase(groupId);
      final members = await fetchGroupMembersUseCase(groupId);
      emit(state.copyWith(
        state: CubitState.success,
        group: group,
        members: members,
      ));
    } catch (e) {
      emit(state.copyWith(
        state: CubitState.failure,
        errorMessage: e.toString(),
      ));
    }
  }

  void toggleNotifications(int groupId, bool isMuted) async {
    // Implement the logic to toggle notifications
  }

  void togglePrivacy(int groupId) async {
    try {
      final updatedGroup =
          state.group!.copyWith(privacy: !state.group!.privacy);
      await updateGroupDetailsUseCase(
          groupId,
          GroupUpdateData(
            name: updatedGroup.name,
            privacy: updatedGroup.privacy,
            imageUrl: updatedGroup.imageUrl,
            groupSize: updatedGroup.groupSize,
          ));
      emit(state.copyWith(group: updatedGroup));
    } catch (e) {
      emit(state.copyWith(
        state: CubitState.failure,
        errorMessage: e.toString(),
      ));
    }
  }

  void updateMemberRole(int groupId, MemberModel member) async {
    try {
      await updateMemberRoleUseCase(groupId, member);
      //edit the member role

      final updatedMembers = state.members.map((m) {
        if (m.userId == member.userId) {
          return m.copyWith(role: member.role);
        }
        return m;
      }).toList();
      emit(state.copyWith(members: updatedMembers));
    } catch (e) {
      emit(state.copyWith(
        state: CubitState.failure,
        errorMessage: e.toString(),
      ));
    }
  }

  // void addMember(int groupId, List<MemberModel> members) async {
  //   try {
  //     await addMemberUseCase(groupId, m  +embers);
  //     final updatedMembers = List<MembershipModel>.from(state.members)
  //       ..addAll(members.map((m) => MembershipModel(
  //             groupId: groupId,
  //             userId: m.userId,
  //             role: m.role,
  //             status: true,
  //             hasDownloadPermissions: true,
  //             hasMessagePermissions: true,
              
              
  //           )));
  //     emit(state.copyWith(members: updatedMembers));
  //   } catch (e) {
  //     emit(state.copyWith(
  //       state: CubitState.failure,
  //       errorMessage: e.toString(),
  //     ));
  //   }
  // }

  void removeMember(int groupId, int memberId) async {
    try {
      await removeMemberUseCase(groupId, memberId);
      final updatedMembers =
          state.members.where((m) => m.userId != memberId).toList();
      emit(state.copyWith(members: updatedMembers));
    } catch (e) {
      emit(state.copyWith(
        state: CubitState.failure,
        errorMessage: e.toString(),
      ));
    }
  }

  void leaveGroup(int groupId, int memberId) async {
    try {
      await removeMemberUseCase(groupId, memberId);
      // Handle leaving the group, e.g., navigate to another screen
    } catch (e) {
      emit(state.copyWith(
        state: CubitState.failure,
        errorMessage: e.toString(),
      ));
    }
  }

  void deleteGroup(int groupId) async {
    try {
      await deleteGroupUseCase(groupId);
      // Handle group deletion, e.g., navigate to another screen
    } catch (e) {
      emit(state.copyWith(
        state: CubitState.failure,
        errorMessage: e.toString(),
      ));
    }
  }

  void updateGroupDetails(int groupId, GroupUpdateData data) async {
    try {
      await updateGroupDetailsUseCase(groupId, data);
      final updatedGroup = state.group!.copyWith(
        name: data.name,
        privacy: data.privacy,
        imageUrl: data.imageUrl,
      );
      emit(state.copyWith(group: updatedGroup));
    } catch (e) {
      emit(state.copyWith(
        state: CubitState.failure,
        errorMessage: e.toString(),
      ));
    }
  }
}
