import 'package:telegram/feature/settings/domainsettings/entities/user_settings_entity.dart';

class UserSettingsBodyModel extends UserSettingsEntity {
  final String screenName;
  final String userName;
  final String phoneNumber;
  final String bio;
  final String status;
  final String autoDeleteTimer;
  final String lastSeenPrivacy;
  final String profilePhotoPrivacy;
  final bool enableReadReceipt;
  final List<String> blockedUsers;
  final List<String> contacts;

  UserSettingsBodyModel({
    required this.screenName,
    required this.userName,
    required this.phoneNumber,
    required this.bio,
    required this.status,
    required this.autoDeleteTimer,
    required this.lastSeenPrivacy,
    required this.profilePhotoPrivacy,
    required this.enableReadReceipt,
    required this.blockedUsers,
    required this.contacts,
  }) : super(
          screenName: screenName,
          userName: userName,
          phoneNumber: phoneNumber,
          bio: bio,
          status: status,
          autoDeleteTimer: autoDeleteTimer,
          lastSeenPrivacy: lastSeenPrivacy,
          profilePhotoPrivacy: profilePhotoPrivacy,
          enableReadReceipt: enableReadReceipt,
          blockedUsers: blockedUsers,
          contacts: contacts,
        );

  Map<String, dynamic> toJson() {
    final body = {
      'screen_name': screenName,
      'user_name': userName,
      'phone_number': phoneNumber,
      'bio': bio,
      'status': status,
      'auto_del_timer': autoDeleteTimer,
      'last_seen_privacy': lastSeenPrivacy,
      'profile_photo_privacy': profilePhotoPrivacy,
      'enable_read_receipt': enableReadReceipt,
      'blocked_users': blockedUsers,
      'contacts': contacts,
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
      autoDeleteTimer: autoDeleteTimer,
      lastSeenPrivacy: lastSeenPrivacy,
      profilePhotoPrivacy: profilePhotoPrivacy,
      enableReadReceipt: enableReadReceipt,
      blockedUsers: blockedUsers,
      contacts: contacts,
    );
  }

  factory UserSettingsBodyModel.fromEntity(UserSettingsEntity entity) {
    return UserSettingsBodyModel(
      screenName: entity.screenName,
      userName: entity.userName,
      phoneNumber: entity.phoneNumber,
      bio: entity.bio,
      status: entity.status,
      autoDeleteTimer: entity.autoDeleteTimer,
      lastSeenPrivacy: entity.lastSeenPrivacy,
      profilePhotoPrivacy: entity.profilePhotoPrivacy,
      enableReadReceipt: entity.enableReadReceipt,
      blockedUsers: entity.blockedUsers,
      contacts: entity.contacts,
    );
  }
  factory UserSettingsBodyModel.fromJson(Map<String, dynamic> json) {
    return UserSettingsBodyModel(
      screenName: json['screen_name'],
      userName: json['user_name'],
      phoneNumber: json['phone_number'],
      bio: json['bio'],
      status: json['status'],
      autoDeleteTimer: json['auto_del_timer'],
      lastSeenPrivacy: json['last_seen_privacy'],
      profilePhotoPrivacy: json['profile_photo_privacy'],
      enableReadReceipt: json['enable_read_receipt'],
      blockedUsers: List<String>.from(json['blocked_users']),
      contacts: List<String>.from(json['contacts']),
    );
  }
  static empty() {
    return UserSettingsBodyModel(
      screenName: "",
      userName: "",
      phoneNumber: "",
      bio: "",
      status: "",
      autoDeleteTimer: "",
      lastSeenPrivacy: "",
      profilePhotoPrivacy: "",
      enableReadReceipt: true,
      blockedUsers: [],
      contacts: [],
    );
  }
}
