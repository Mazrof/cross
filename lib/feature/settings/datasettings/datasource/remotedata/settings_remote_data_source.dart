import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:telegram/core/error/faliure.dart';
import 'package:telegram/core/local/hive.dart';
import 'package:telegram/core/network/api/api_constants.dart';
import 'package:telegram/core/network/api/api_service.dart';
import 'package:telegram/feature/dashboard/domain/entity/user.dart';

import 'package:telegram/feature/settings/datasettings/datasource/remotedata/user_settings_remote_data_source.dart';
import 'package:telegram/feature/settings/datasettings/models/user_settings_model.dart';

class SettingsRemoteDataSourceImplm extends UserSettingsRemoteDataSource {
  final ApiService _apiService;
  final settingsURL = "http://localhost:3000/api/v1/profile";

  SettingsRemoteDataSourceImplm({
    required ApiService apiService,
  }) : _apiService = apiService;

  int id = HiveCash.read(boxName: "register_info", key: "id");

  @override
  Future<UserSettingsBodyModel> fetchSettings() async {
    try {
      final response =
          await _apiService.get(endPoint: "${ApiConstants.profileSetting}/$id");
      if (response.statusCode == 200 || response.statusCode == 201) {
        print("settings fetched successfuly");
        return UserSettingsBodyModel.fromJson(response.data);
      } else {
        throw Exception(
            'Failed to fetch settings with reponse error code: ${response.statusCode}');
      }
    } catch (e) {
      if (e is ServerFailure) {
        print('Error fetching setting: ${e.message}');
        throw Exception(e.message);
      } else {
        print("Unexpected Error: $e");
        throw Exception('Error occurred on fetching setting: $e');
      }
    }
  }

  @override
  Future<void> updateSettings(UserSettingsBodyModel newSetting) async {
    try {
      final response = await _apiService.patch(
          endPoint: "${ApiConstants.profileSetting}/$id",
          data: json.encode(newSetting.toJson()));
      if (response.statusCode == 200 || response.statusCode == 201) {
        print("settings updated successfully");
      } else {
        throw Exception(
            'Failed to Update settings with reponse error code: ${response.statusCode}');
      }
    } catch (e) {
      if (e is ServerFailure) {
        print('Error updating setting: ${e.message}');
        throw Exception(e.message);
      } else {
        print("Unexpected Error: $e");
        throw Exception('Error occurred on updating setting: $e');
      }
    }
  }

  @override
  Future<UserSettingsBodyModel> getBlocked() async {
    try {
      final response = await _apiService.get(
          endPoint: ApiConstants.blockedUsers,
          queryParameters: {"blockerID": id});
      if (response.statusCode == 200 || response.statusCode == 201) {
        print("blocked users fetched successfuly for id : $id");
        return UserSettingsBodyModel.blockedUsersFromJson(
            response.data); //change
      } else {
        throw Exception(
            'Failed to get blocked users with response error code: ${response.statusCode}');
      }
    } catch (e) {
      if (e is ServerFailure) {
        print('Error fetching blocked users: ${e.message}');
        throw Exception(e.message);
      } else {
        print("Unexpected Error: $e");
        throw Exception('Error occurred on fetching blocked users: $e');
      }
    }
  }

  @override
  Future<UserSettingsBodyModel> getContacts() async {
    try {
      final response = await _apiService.get(endPoint: ApiConstants.contacts);
      if (response.statusCode == 200 || response.statusCode == 201) {
        print("contacts fetched successfully");
        return UserSettingsBodyModel.contactsFromJson(response.data); //change
      } else {
        throw Exception(
            "Failed to get contacts with response code : ${response.statusCode} ");
      }
    } catch (e) {
      if (e is ServerFailure) {
        print('Error fetching contacts: ${e.message}');
        throw Exception(e.message);
      } else {
        print("Unexpected Error: $e");
        throw Exception('Error occurred on fetching contacts: $e');
      }
    }
  }

  @override
  Future<void> blockUser(int blockedId) async {
    try {
      final response = await _apiService.post(
          endPoint: 'user/$blockedId/block',
          queryParameters: {'blockerID': id});
      if (response.statusCode == 200 || response.statusCode == 201) {
        print("contacts blocked successfully");
      } else {
        throw Exception(
            "Failed to block contacts with response code : ${response.statusCode} ");
      }
    } catch (e) {
      if (e is ServerFailure) {
        print('Error blocking contacts: ${e.message}');
        throw Exception(e.message);
      } else {
        print("Unexpected Error: $e");
        throw Exception('Error occurred on blocking contacts: $e');
      }
    }
  }

  @override
  Future<void> unBlockUser(int blockedId) async {
    try {
      final response = await _apiService.delete(
          endPoint: 'user/$blockedId/block',
          queryParameters: {'blockerID': id});
      if (response.statusCode == 200 || response.statusCode == 201) {
        print("contacts unblocked successfully");
      } else {
        throw Exception(
            "Failed to unblock contacts with response code : ${response.statusCode} ");
      }
    } catch (e) {
      if (e is ServerFailure) {
        print('Error unblocking contacts: ${e.message}');
        throw Exception(e.message);
      } else {
        print("Unexpected Error: $e");
        throw Exception('Error occurred on unblocking contacts: $e');
      }
    }
  }
}
