class UserSettingsEntity {
  final String screenName;
  final String userName;
  final String phoneNumber;
  final String bio;
  final String status;
  final String autoDeleteTimer;
  final String lastSeenPrivacy;
  final String profilePhotoPrivacy;
  final bool enableReadReceipt;

  UserSettingsEntity({
    required this.screenName,
    required this.userName,
    required this.phoneNumber,
    required this.bio,
    required this.status,
    required this.autoDeleteTimer,
    required this.lastSeenPrivacy,
    required this.profilePhotoPrivacy,
    required this.enableReadReceipt,
  });
}
