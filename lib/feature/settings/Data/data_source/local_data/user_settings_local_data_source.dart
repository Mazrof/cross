import 'package:telegram/feature/settings/Data/model/user_settings_model.dart';

abstract class UserSettingsLocalDataSource {
  Future<UserSettingsBodyModel> fetchSettings();
  Future<void> updateSettings(UserSettingsBodyModel settings);
}
