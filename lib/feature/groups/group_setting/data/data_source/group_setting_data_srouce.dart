import 'package:telegram/core/network/api/api_service.dart';
import 'package:telegram/feature/groups/add_new_group/data/model/member_model.dart';
import 'package:telegram/feature/groups/group_setting/data/model/group_setting_model.dart';
import 'package:telegram/feature/groups/group_setting/data/model/membership_model.dart';
import 'package:telegram/feature/groups/group_setting/domain/entity/group_update_data.dart';

abstract class GroupRemoteDataSource {
  Future<GroupModel> fetchGroupDetails(int groupId);
  Future<void> updateMemberRole(int groupId, MemberModel member);
  Future<void> addMember(int groupId, List<MemberModel> members);
  Future<void> removeMember(int groupId, int memberId);

  Future<void> deleteGroup(int groupId);
  Future<void> updateGroupDetails(int groupId, GroupUpdateData data);
  Future<List<MembershipModel>> fetchMembers(int groupId);
}

class GroupRemoteDataSourceImpl implements GroupRemoteDataSource {
  final ApiService apiService;

  GroupRemoteDataSourceImpl(this.apiService);

  @override
  Future<GroupModel> fetchGroupDetails(int groupId) async {
    final response = await apiService.get(endPoint: 'groups/$groupId');
    return GroupModel.fromJson(response.data['data']['group']);
  }

  @override
  Future<void> updateMemberRole(int groupId, MemberModel member) async {
    await apiService.patch(
      endPoint: 'groups/$groupId/members/${member.userId}',
      data: {
        'role': member.role,
        "hasDownloadPermissions": member.hasDownloadPermissions,
        "hasMessagePermissions": member.hasMessagePermissions,
      },
    );
  }

  @override
  Future<void> addMember(int groupId, List<MemberModel> members) async {
    await apiService.post(
      endPoint: 'groups/$groupId/members',
      data: [
        for (final member in members)
          {
            'userId': member.userId,
            'role': member.role,
            "hasDownloadPermissions": member.hasDownloadPermissions,
            "hasMessagePermissions": member.hasMessagePermissions,
          }
      ],
    );
  }

  @override
  Future<void> removeMember(int groupId, int memberId) async {
    await apiService.delete(
      endPoint: 'groups/$groupId/members/$memberId/remove',
    );
  }

  @override
  Future<void> deleteGroup(int groupId) async {
    await apiService.delete(
      endPoint: 'groups/$groupId',
    );
  }

  @override
  Future<void> updateGroupDetails(int groupId, GroupUpdateData data) async {
    await apiService.post(endPoint: 'groups/$groupId', data: {
      'name': data.name,
      'privacy': data.privacy,
      'imageUrl': data.imageUrl,
    });
  }

  @override
  Future<List<MembershipModel>> fetchMembers(int groupId) async {
    final respons = await apiService.get(
      endPoint: 'groups/$groupId/members',
    );
    return respons.data['data']['members']
        .map<MemberModel>((e) => MemberModel.fromJson(e))
        .toList();
  }
}
