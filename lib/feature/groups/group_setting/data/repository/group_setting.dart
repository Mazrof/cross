import 'package:telegram/feature/groups/add_new_group/data/model/member_model.dart';
import 'package:telegram/feature/groups/group_setting/data/data_source/group_setting_data_srouce.dart';
import 'package:telegram/feature/groups/group_setting/data/model/group_setting_model.dart';
import 'package:telegram/feature/groups/group_setting/data/model/membership_model.dart';
import 'package:telegram/feature/groups/group_setting/domain/entity/group_update_data.dart';
import 'package:telegram/feature/groups/group_setting/domain/repository/group_setting_repository.dart';

class GroupSettingRepositoryImpl implements GroupSettingRepository {
  final GroupRemoteDataSource remoteDataSource;

  GroupSettingRepositoryImpl(this.remoteDataSource);

  @override
  Future<GroupModel> fetchGroupDetails(int groupId) async {
    return await remoteDataSource.fetchGroupDetails(groupId);
  }

  @override
  Future<void> updateMemberRole(int groupId, MemberModel member) async {
    await remoteDataSource.updateMemberRole(groupId, member);
  }

  @override
  Future<void> addMember(int groupId, List<MemberModel> members) async {
    await remoteDataSource.addMember(groupId, members);
  }

  @override
  Future<void> removeMember(int groupId, int memberId) async {
    await remoteDataSource.removeMember(groupId, memberId);
  }

  @override
  Future<void> deleteGroup(int groupId) async {
    await remoteDataSource.deleteGroup(groupId);
  }

  @override
  Future<void> updateGroupDetails(int groupId, GroupUpdateData data) async {
    await remoteDataSource.updateGroupDetails(groupId, data);
  }
  
  @override
  Future<List<MembershipModel>> fetchMembers(int groupId) {
    return remoteDataSource.fetchMembers(groupId);
  }
}
