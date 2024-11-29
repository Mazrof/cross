import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:telegram/core/di/service_locator.dart';
import 'package:telegram/core/local/user_access_token.dart';
import 'package:telegram/core/network/api/api_service.dart';
import 'package:telegram/feature/dashboard/data/model/group_model.dart';

import '../../model/user_model.dart';

abstract class DashboardDataSource {
  Future<List<UserModel>> getUsers();
  Future<bool> banUser(String userID);
  Future<bool> unBanUser(String userID);
  Future<List<GroupModel>> getGroups();
  Future<bool> applyFilter(String groupID);
}

class DashboardDataSourceImpl implements DashboardDataSource {
  ApiService apiService = sl<ApiService>();
  DashboardDataSourceImpl();

  @override
  Future<List<UserModel>> getUsers() async {
    String endpoint = 'admins/';
    print('start fetching users');

    var response = await apiService.get(
      endPoint: endpoint,
      token: UserAccessToken.accessToken,
      data: {
        'adminId': 1,

        ///----------------------->> This is the issue
      },
    );

    if (response.statusCode == 200) {
      final decodedJson = (response.data);
      print('here1');
      print(decodedJson);

      // Extract the "data" list from the response
      final List<dynamic> usersJson = decodedJson['data']['users'];
      print('here2');
      print(usersJson);

      // Map the JSON list to a list of UserModel
      final List<UserModel> users =
          usersJson.map((json) => UserModel.fromJson(json)).toList();

      return users;
    } else {
      throw Exception('Failed to load users');
    }
  }

  @override
  Future<bool> banUser(String userId) async {
    String endpoint = 'admins';
    final response = await apiService.patch(
      endPoint: '$endpoint/$userId/ban',
      token: UserAccessToken.accessToken,
      data: {
        'adminId': 1,
      },
    );
    return response.statusCode == 200;
  }

  @override
  Future<bool> unBanUser(String userId) async {
    String endpoint = 'admins';
    final response = await apiService.patch(
      endPoint: '$endpoint/$userId/ban',
      token: UserAccessToken.accessToken,
      data: {
        'adminId': 1,
      },
    );
    return response.statusCode == 200;
  }

  @override
  Future<List<GroupModel>> getGroups() async {
    String endpoint = 'groups/';
    final response = await apiService.get(
        endPoint: endpoint, token: UserAccessToken.accessToken);
    print(response.statusCode);
    print(response.data);

    if (response.statusCode == 200) {
      // Extract the "data" list from the response
      print('i am here');
      final List<dynamic> groups = response.data['data']['data'];
      print('here2');
      print(groups);

      // Map the JSON list to a list of UserModel
      List<GroupModel> groupList =
          groups.map((json) => GroupModel.fromJson(json)).toList();
      return groupList;
    } else {
      throw Exception('Failed to load groups');
    }
  }

  @override
  Future<bool> applyFilter(String groupId) async {
    String endpoint = 'groups';
    final response = await apiService.post(
      endPoint: '$endpoint/$groupId/filter',
      token: UserAccessToken.accessToken,
      data: {
        'adminId': 1,
      },
    );
    return response.statusCode == 200;
  }
}
