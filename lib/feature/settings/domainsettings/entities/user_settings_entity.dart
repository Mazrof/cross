class UserSettingsEntity {
  final String profileImage;
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

  UserSettingsEntity({
    required this.profileImage,
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
  });
}
