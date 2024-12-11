import 'package:bloc/bloc.dart';
import 'package:telegram/core/network/network_manager.dart';
import 'package:telegram/core/utililes/app_enum/app_enum.dart';
import 'package:telegram/feature/groups/add_new_group/data/model/member_model.dart';
import 'package:telegram/feature/groups/add_new_group/domain/use_case/add_members_use_case.dart';
import 'package:telegram/feature/groups/group_setting/data/model/group_setting_model.dart';
import 'package:telegram/feature/groups/group_setting/data/model/membership_model.dart';
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
    //simulate loading
    emit(state.copyWith(state: CubitState.loading));
    await Future.delayed(Duration(seconds: 2));

    //make group detailas

    final group = GroupModel(
      id: 1,
      groupSize: 5,
      name: 'Group Name',
      privacy: true,
      imageUrl: '',
    );

    //fake members
    final members = List.generate(
        5,
        (index) => MembershipModel(
              groupId: 1,
              userId: index,
              role: 'member',
              status: true,
              hasDownloadPermissions: true,
              hasMessagePermissions: true,
              username: 'user$index',
              imageUrl: '',
            ));

    emit(state.copyWith(
      state: CubitState.success,
      group: group,
      members: members,
    ));
  }


  void toggleNotifications(int groupId, bool isMuted) async {
    
  }

  void togglePrivacy(int groupId) async {}

  void updateMemberRole(int groupId, MemberModel member) async {}

  void addMember(int groupID, List<MemberModel> members) async {}
  void removeMember(int groupId, int memberId) async {}
  void leaveGroup(int groupId, int memberId) async {}
  void deleteGroup(int groupId) async {}

  void updateGroupDetails(int groupId, GroupUpdateData data) async {}
}
