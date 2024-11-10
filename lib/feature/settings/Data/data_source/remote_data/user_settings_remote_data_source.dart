import 'dart:convert';

import 'package:telegram/feature/settings/Data/model/user_settings_model.dart';
import 'package:http/http.dart' as http;

class UserSettingsRemoteDataSource {
  final String mockUrl;

  UserSettingsRemoteDataSource(this.mockUrl);

  Future<UserSettingsBodyModel> fetchSettings() async {
    final response = await http.get(Uri.parse('$mockUrl/settings/1'));

    if (response.statusCode == 200) {
      return UserSettingsBodyModel.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to fetch settings from MockAPI");
    }
  }

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
