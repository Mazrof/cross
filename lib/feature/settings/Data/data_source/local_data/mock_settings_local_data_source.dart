import 'package:flutter/widgets.dart';
import 'package:telegram/feature/settings/Data/data_source/local_data/user_settings_local_data_source.dart';
import 'package:telegram/feature/settings/Data/model/user_settings_model.dart';

class MockSettingsLocalDataSource extends UserSettingsLocalDataSource {
  final Map<String, dynamic> _mockDatabase;

  MockSettingsLocalDataSource(this._mockDatabase);

  @override
  Future<UserSettingsBodyModel> fetchSettings() async {
    return UserSettingsBodyModel(
      screenName: _mockDatabase['screen_name'] ?? 'Default Name',
      userName: _mockDatabase['user_name'] ?? 'default_username',
      phoneNumber: _mockDatabase['phone_number'] ?? '0000000000',
      bio: _mockDatabase['bio'] ?? 'No bio available',
      status: _mockDatabase['status'] ?? 'Offline',
    );
  }

  @override
  Future<void> updateSettings(UserSettingsBodyModel settings) async {
    _mockDatabase['screen_name'] = settings.screenName;
    _mockDatabase['user_name'] = settings.userName;
    _mockDatabase['phone_number'] = settings.phoneNumber;
    _mockDatabase['bio'] = settings.bio;
    _mockDatabase['status'] = settings.status;
  }
}
