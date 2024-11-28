import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:telegram/feature/settings/datasettings/models/user_settings_model.dart';

abstract class UserSettingsRemoteDataSource {
  Future<UserSettingsBodyModel> fetchSettings();
  Future<void> updateSettings(UserSettingsBodyModel newSetting);
}

class UserSettingsRemoteDataSourceImpl extends UserSettingsRemoteDataSource {
  final String mockUrl = 'https://672f5ae4229a881691f2b22f.mockapi.io/api/v1';

  UserSettingsRemoteDataSourceImpl();

  @override
  Future<UserSettingsBodyModel> fetchSettings() async {
    final response = await http.get(Uri.parse('$mockUrl/settings/1'));

    if (response.statusCode == 200) {
      return UserSettingsBodyModel.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to fetch settings from MockAPI");
    }
  }

  @override
  Future<void> updateSettings(UserSettingsBodyModel newSetting) async {
    final response = await http.put(
      Uri.parse('$mockUrl/settings/1'),
      headers: {"Content-Type": "application/json"},
      body: json.encode(newSetting.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception("Failed to update settings on MockAPI");
    }
  }
}
