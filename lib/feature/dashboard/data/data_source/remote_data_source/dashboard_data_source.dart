import 'package:dio/dio.dart';
import 'package:telegram/core/di/service_locator.dart';
import 'package:telegram/core/local/user_access_token.dart';
import 'package:telegram/core/network/api/api_service.dart';

abstract class DashboardDataSource {
  Future<Response> getUsers();
  Future<bool> banUser(String userID);
  Future<bool> unBanUser(String userID);
  Future<Response> getGroups();
  Future<bool> applyFilter(String groupID);
}

class DashboardDataSourceImpl implements DashboardDataSource {
  ApiService apiService = sl<ApiService>();
  DashboardDataSourceImpl();

  @override
  Future<Response> getUsers() async {
    String endpoint = '/admin/users';

    final response = await apiService.get(
      endPoint: endpoint,
      token: UserAccessToken.accessToken,
    );
    final result = response.data['users'];

    return result;
  }

  @override
  Future<bool> banUser(String userID) async {
    String endpoint = '/admin/users';
    final response = await apiService.post(
        endPoint: '$endpoint/$userID', token: UserAccessToken.accessToken);
    return response.statusCode == 200;
  }

  @override
  Future<bool> unBanUser(String userID) async {
    String endpoint = '/admin/users';
    final response = await apiService.post(
        endPoint: '$endpoint/$userID', token: UserAccessToken.accessToken);
    return response.statusCode == 200;
  }

  @override
  Future<Response> getGroups() async {
    String endpoint = '/admin/groups';
    final response = await apiService.get(
        endPoint: endpoint, token: UserAccessToken.accessToken);

    final reslut = response.data['groups'];
    return reslut;
  }

  @override
  Future<bool> applyFilter(String groupID) async {
    String endpoint = 'admin/groups';
    final response = await apiService.post(
        endPoint: '$endpoint/$groupID', token: UserAccessToken.accessToken);
    return response.statusCode == 200;
  }
}
