class BlockedUser {
  int id;
  String username;
  BlockedUser({required this.id, required this.username});
}

class BlockableContacts {
  int id;
  String username;
  BlockableContacts({required this.id, required this.username});
}

class UserSettingsEntity {
  final String? profileImage;
  final String? screenName;
  final String? userName;
  final String? phoneNumber;
  final String? bio;
  final String? status;
  final String? autoDeleteTimer;
  final String? lastSeenPrivacy;
  final String? profilePhotoPrivacy;
  final String? enableReadReceipt;
  final String? storyVisibility;
  final int? maxFileSize;
  final int? maxDownloadSize;
  final List<BlockedUser>? blockedUsers;
  final List<BlockableContacts>? contacts;

  UserSettingsEntity({
    this.profileImage,
    this.screenName,
    this.userName,
    this.phoneNumber,
    this.bio,
    this.status,
    this.autoDeleteTimer,
    this.lastSeenPrivacy,
    this.profilePhotoPrivacy,
    this.enableReadReceipt,
    this.blockedUsers,
    this.contacts,
    this.storyVisibility,
    this.maxFileSize,
    this.maxDownloadSize,
  });
}
