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
    String endpoint = 'admin/users';
    print('start fetching users');

    var response = await apiService.get(
      endPoint: endpoint,
      token: UserAccessToken.accessToken,
    );

    if (response.statusCode == 200) {
      final decodedJson = jsonDecode(response.data);
      print('here1');
      print(decodedJson);

      // Extract the "data" list from the response
      final List<dynamic> usersJson = decodedJson['data'];
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
  Future<bool> banUser(String userID) async {
    String endpoint = 'admin/users';
    final response = await apiService.post(
        endPoint: '$endpoint/$userID', token: UserAccessToken.accessToken);
    return response.statusCode == 200;
  }

  @override
  Future<bool> unBanUser(String userID) async {
    String endpoint = 'admin/users';
    final response = await apiService.post(
        endPoint: '$endpoint/$userID', token: UserAccessToken.accessToken);
    return response.statusCode == 200;
  }

  @override
  Future<List<GroupModel>> getGroups() async {
    String endpoint = 'admin/groups';
    final response = await apiService.get(
        endPoint: endpoint, token: UserAccessToken.accessToken);
    if (response.statusCode == 200) {
      final decodedJson = jsonDecode(response.data);
      print('here1');
      print(decodedJson);

      // Extract the "data" list from the response
      final List<dynamic> groups = decodedJson['data']['data'];
      print('here2');
      print(groups);

      // Map the JSON list to a list of UserModel
      List<GroupModel> groupList = groups.map((json) => GroupModel.fromJson(json)).toList();
      return groupList;
    } else {
      throw Exception('Failed to load groups');
    }
  }

  @override
  Future<bool> applyFilter(String groupID) async {
    String endpoint = 'admin/groups';
    final response = await apiService.post(
        endPoint: '$endpoint/$groupID', token: UserAccessToken.accessToken);
    return response.statusCode == 200;
  }
}
