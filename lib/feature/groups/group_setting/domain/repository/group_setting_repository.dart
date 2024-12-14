import 'package:telegram/feature/groups/add_new_group/data/model/member_model.dart';
import 'package:telegram/feature/groups/group_setting/data/model/group_setting_model.dart';
import 'package:telegram/feature/groups/group_setting/data/model/membership_model.dart';
import 'package:telegram/feature/groups/group_setting/domain/entity/group_update_data.dart';

abstract class GroupSettingRepository {
  Future<GroupModel> fetchGroupDetails(int groupId);

  Future<void> updateMemberRole(int groupId, MemberModel member);
  Future<void> addMember(int groupId, List<MemberModel> members);
  Future<void> removeMember(int groupId, int memberId);

  Future<void> deleteGroup(int groupId);
  Future<void> updateGroupDetails(int groupId, GroupUpdateData data);
  Future<List<MembershipModel>> fetchMembers(int groupId);
  Future<void> muteToggle(int groupId, bool isMuted);
}
