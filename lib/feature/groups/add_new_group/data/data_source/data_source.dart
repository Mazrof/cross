import 'package:dio/dio.dart';
import 'package:telegram/core/di/service_locator.dart';
import 'package:telegram/core/network/api/api_service.dart';
import 'package:telegram/feature/dashboard/data/model/group_model.dart';
import 'package:telegram/feature/groups/add_new_group/data/model/groups_model.dart';
import 'package:telegram/feature/groups/add_new_group/data/model/member_model.dart';

abstract class CreateGroupDataSource {
  Future<GroupsModel> createGroup(GroupsModel group);
  Future<void> addMembers(int id, List<MemberModel> group);
}

class CreatGroupDataSourceMpl extends CreateGroupDataSource {
  final ApiService apiService = sl<ApiService>();

  CreatGroupDataSourceMpl();

  Future<GroupsModel> createGroup(GroupsModel group) async {
    final response = await apiService.post(
      
      endPoint: 'groups/',
      data: group.toJson(),
    );

    return GroupsModel.fromJson(response.data['data']['group']);
  }

  Future<void> addMembers(int id, List<MemberModel> members) async {
    await apiService.post(
      endPoint: 'groups/${id}/members',
      data: members.map((e) => e.toJson()).toList(),
    );
    
  }
}
