import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:telegram/feature/settings/datasettings/datasource/remotedata/user_settings_remote_data_source.dart';
import 'package:telegram/feature/settings/datasettings/models/user_settings_model.dart';

class SettingsRemoteDataSourceImplm extends UserSettingsRemoteDataSource {
  final settingsURL = "http://localhost:3000/api/v1/profile";
  @override
  Future<UserSettingsBodyModel> fetchSettings() async {
    try {
      final response = await http.get(Uri.parse('${settingsURL}/7'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return UserSettingsBodyModel.fromJson(json.decode(data));
      } else {
        throw Exception(
            'Failed to fetch settings with reponse error code: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Error fetching settings $error');
    }
  }

  @override
  Future<void> updateSettings(UserSettingsBodyModel newSetting) async {
    try {
      final response = await http.patch(
        Uri.parse('${settingsURL}/7'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(newSetting.toJson()),
      );
      if (response.statusCode != 200) {
        throw Exception(
            'Failed to Update settings with reponse error code: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Error Updating settings $error');
    }
  }
}
