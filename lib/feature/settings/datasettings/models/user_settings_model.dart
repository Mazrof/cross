import 'package:telegram/feature/settings/domainsettings/entities/user_settings_entity.dart';

class UserSettingsBodyModel extends UserSettingsEntity {
  final String screenName;
  final String userName;
  final String phoneNumber;
  final String bio;
  final String status;
  UserSettingsBodyModel({
    required this.screenName,
    required this.userName,
    required this.phoneNumber,
    required this.bio,
    required this.status,
  }) : super(
            screenName: screenName,
            userName: userName,
            phoneNumber: phoneNumber,
            bio: bio,
            status: status);

  Map<String, dynamic> toJson() {
    final body = {
      'screen_name': screenName,
      'user_name': userName,
      'phone_number': phoneNumber,
      'bio': bio,
      'status': status,
    };
    return body;
  }

  UserSettingsEntity toEntity() {
    return UserSettingsEntity(
      screenName: screenName,
      userName: userName,
      phoneNumber: phoneNumber,
      bio: bio,
      status: status,
    );
  }

  factory UserSettingsBodyModel.fromEntity(UserSettingsEntity entity) {
    return UserSettingsBodyModel(
        screenName: entity.screenName,
        userName: entity.userName,
        phoneNumber: entity.phoneNumber,
        bio: entity.bio,
        status: entity.status);
  }
  factory UserSettingsBodyModel.fromJson(Map<String, dynamic> json) {
    return UserSettingsBodyModel(
      screenName: json['screen_name'],
      userName: json['user_name'],
      phoneNumber: json['phone_number'],
      bio: json['bio'],
      status: json['status'],
    );
  }
  static empty() {
    return UserSettingsBodyModel(
      screenName: "",
      userName: "",
      phoneNumber: "",
      bio: "",
      status: "",
    );
  }
}
