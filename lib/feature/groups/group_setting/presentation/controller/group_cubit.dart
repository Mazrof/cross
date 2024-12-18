import 'package:bloc/bloc.dart';
import 'package:telegram/core/di/service_locator.dart';
import 'package:telegram/core/local/hive.dart';
import 'package:telegram/core/network/network_manager.dart';
import 'package:telegram/core/utililes/app_enum/app_enum.dart';
import 'package:telegram/feature/groups/add_new_group/data/model/member_model.dart';
import 'package:telegram/feature/groups/add_new_group/domain/entity/chat_tile_data.dart';
import 'package:telegram/feature/groups/add_new_group/domain/use_case/add_members_use_case.dart';
import 'package:telegram/feature/groups/group_setting/data/model/group_setting_model.dart';
import 'package:telegram/feature/groups/group_setting/domain/entity/group_update_data.dart';
import 'package:telegram/feature/groups/group_setting/domain/use_case/delete_group_use_case.dart';
import 'package:telegram/feature/groups/group_setting/domain/use_case/fetch_group_details_use_case.dart';
import 'package:telegram/feature/groups/group_setting/domain/use_case/fetch_group_members_use_case.dart';
import 'package:telegram/feature/groups/group_setting/domain/use_case/mute_use_case.dart';
import 'package:telegram/feature/groups/group_setting/domain/use_case/remove_member_user.dart';
import 'package:telegram/feature/groups/group_setting/domain/use_case/update_group_use_case.dart';
import 'package:telegram/feature/groups/group_setting/domain/use_case/update_member_role.dart';
import 'package:telegram/feature/groups/group_setting/presentation/controller/group_state.dart';
import 'package:telegram/feature/home/data/model/chat_model.dart';
import 'package:telegram/feature/home/presentation/controller/home/home_cubit.dart';

class GroupCubit extends Cubit<GroupState> {
  GroupCubit(
    this.fetchGroupDetailsUseCase,
    this.updateMemberRoleUseCase,
    this.removeMemberUseCase,
    this.deleteGroupUseCase,
    this.updateGroupDetailsUseCase,
    this.networkManager,
    this.fetchGroupMembersUseCase,
    this.muteUseCase,
  ) : super(GroupState(
          state: CubitState.initial,
         
          ismute: false,
          group: GroupModel.empty(),
        ));

  final FetchGroupDetailsUseCase fetchGroupDetailsUseCase;
  final UpdateMemberRoleUseCase updateMemberRoleUseCase;
   final RemoveMemberUseCase removeMemberUseCase;
  final DeleteGroupUseCase deleteGroupUseCase;
  final UpdateGroupDetailsUseCase updateGroupDetailsUseCase;
  final NetworkManager networkManager;
  final FetchGroupMembersUseCase fetchGroupMembersUseCase;
  final MuteUseCase muteUseCase;

  List<chatTileData> convertChatModelToChatTileData(
      List<ChatModel> chats, String currentUserId) {
    return chats.map((chat) {
      return chatTileData(
        id: chat.id,
        name: chat.secondUser.username,
        imageUrl: chat.secondUser.photo ?? '',
        lastSeen: chat.secondUser.lastSeen.toString(),
      );
    }).toList();
  }

  void toggleNotifications(int groupId, bool isMuted) async {
    try {
      if (networkManager.isConnected() == false) {
        emit(state.copyWith(
            state: CubitState.failure, errorMessage: 'No Internet Connection'));
        return;
      }

      emit(state.copyWith(ismute: isMuted));
      // await muteUseCase(groupId, isMuted);  //waiting back-end
    } catch (e) {
      emit(state.copyWith(
        state: CubitState.failure,
        errorMessage: e.toString(),
      ));
    }
  }

  void togglePrivacy(int groupId, bool val) async {
    try {
      if (networkManager.isConnected() == false) {
        emit(state.copyWith(
            state: CubitState.failure, errorMessage: 'No Internet Connection'));
        return;
      }

      print('toggling privacy');
      print(state);
      final updatedGroup = state.group!.copyWith(privacy: val);
      print(updatedGroup.privacy);

      emit(state.copyWith(group: updatedGroup));

      print('mmmmmmmmmmmmmmmmmmmm');
      await updateGroupDetailsUseCase(
          groupId,
          GroupUpdateData(
            name: updatedGroup.name,
            privacy: updatedGroup.privacy,
            imageUrl: updatedGroup.imageUrl,
            groupSize: updatedGroup.groupSize,
          ));
    } catch (e) {
      emit(state.copyWith(
        state: CubitState.failure,
        errorMessage: e.toString(),
      ));
    }
  }

  void fetchGroupDetails(int groupId) async {
    final int id = HiveCash.read(boxName: "register_info", key: "id");
    List<chatTileData> members = convertChatModelToChatTileData(
        sl<HomeCubit>().state.contacts, id.toString());

    print('fetching group details');
    emit(state.copyWith(state: CubitState.loading));

    if (networkManager.isConnected() == false) {
      emit(state.copyWith(
          state: CubitState.failure, errorMessage: 'No Internet Connection'));
      return;
    }

    try {
      final group = await fetchGroupDetailsUseCase(groupId);
      print('fetching group members');
      print(group);
      final members = await fetchGroupMembersUseCase(groupId);
      print('fetched group members');
      print(members);
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

  // void toggleMember(chatTileData member) {
  //   final selectedMembers = List<chatTileData>.from(state.selectedMembers);

  //   if (selectedMembers.contains(member)) {
  //     selectedMembers.remove(member);
  //   } else {
  //     selectedMembers.add(member);
  //   }

  //   emit(state.copyWith(
  //       selectedMembers: selectedMembers, state: CubitState.initial));
  // }

  void updateMemberRole(MemberModel member) async {
    try {
      if (networkManager.isConnected() == false) {
        emit(state.copyWith(
            state: CubitState.failure, errorMessage: 'No Internet Connection'));
        return;
      }
      await updateMemberRoleUseCase(state.group!.id, member);
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

  void removeMember(int groupId, int memberId) async {
    try {
      if (networkManager.isConnected() == false) {
        emit(state.copyWith(
            state: CubitState.failure, errorMessage: 'No Internet Connection'));
        return;
      }
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
      if (networkManager.isConnected() == false) {
        emit(state.copyWith(
            state: CubitState.failure, errorMessage: 'No Internet Connection'));
        return;
      }
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
      if (networkManager.isConnected() == false) {
        emit(state.copyWith(
            state: CubitState.failure, errorMessage: 'No Internet Connection'));
        return;
      }
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
      if (networkManager.isConnected() == false) {
        emit(state.copyWith(
            state: CubitState.failure, errorMessage: 'No Internet Connection'));
        return;
      }
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
