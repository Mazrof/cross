import 'package:telegram/feature/settings/domainsettings/entities/user_settings_entity.dart';

class UserSettingsBodyModel extends UserSettingsEntity {
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

  UserSettingsBodyModel({
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
  }) : super(
          profileImage: profileImage,
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
          storyVisibility: storyVisibility,
          maxFileSize: maxFileSize,
          maxDownloadSize: maxDownloadSize,
        );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = {};

    String? mapToApi(String? value) {
      switch (value) {
        case 'Everybody':
          return 'everyone';
        case 'Nobody':
          return 'nobody';
        case 'My Contacts':
          return 'contacts';
        default:
          return value;
      }
    }

    if (profileImage != null) json['photo'] = profileImage;
    if (screenName != null) json['screenName'] = screenName;
    if (userName != null) json['username'] = userName;
    if (phoneNumber != null) json['phone'] = phoneNumber;
    if (bio != null) json['bio'] = bio;
    // if (status != null) json['status'] = status;
    // if (autoDeleteTimer != null) json['auto_del_timer'] = autoDeleteTimer;
    if (lastSeenPrivacy != null) {
      json['lastSeenVisibility'] = mapToApi(lastSeenPrivacy);
    }
    if (profilePhotoPrivacy != null) {
      json['profilePicVisibility'] = mapToApi(profilePhotoPrivacy);
    }
    if (enableReadReceipt != null) {
      json['readReceiptsEnabled'] = mapToApi(enableReadReceipt);
    }
    // if (blockedUsers != null) json['blocked_users'] = blockedUsers;
    // if (contacts != null) json['contacts'] = contacts;
    if (storyVisibility != null) {
      json['storyVisibility'] = mapToApi(storyVisibility);
    }
    if (maxFileSize != null) json['maxLimitFileSize'] = maxFileSize;
    if (maxDownloadSize != null) {
      json['autoDownloadSizeLimit'] = maxDownloadSize;
    }

    return json;
  }

  UserSettingsEntity toEntity() {
    return UserSettingsEntity(
      profileImage: profileImage,
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
      storyVisibility: storyVisibility,
      maxFileSize: maxFileSize,
      maxDownloadSize: maxDownloadSize,
    );
  }

  factory UserSettingsBodyModel.fromEntity(UserSettingsEntity entity) {
    return UserSettingsBodyModel(
      profileImage: entity.profileImage,
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
      storyVisibility: entity.storyVisibility,
      maxFileSize: entity.maxFileSize,
      maxDownloadSize: entity.maxDownloadSize,
    );
  }
  factory UserSettingsBodyModel.fromJson(Map<String, dynamic> json) {
    final userJson = json['data']?['user'] as Map<String, dynamic>? ?? {};

    String? mapToUser(String? value) {
      switch (value) {
        case 'everyone':
          return 'Everybody';
        case 'nobody':
          return 'Nobody';
        case 'contacts':
          return 'My Contacts';
        default:
          return value;
      }
    }

    return UserSettingsBodyModel(
      profileImage: userJson['photo'],
      screenName: userJson['screenName'],
      userName: userJson['username'],
      phoneNumber: userJson['phone'],
      bio: userJson['bio'],
      status: null,
      autoDeleteTimer: null,
      lastSeenPrivacy: mapToUser(userJson['lastSeenVisibility']),
      profilePhotoPrivacy: mapToUser(userJson['profilePicVisibility']),
      enableReadReceipt: mapToUser(userJson['readReceiptsEnabled']),
      blockedUsers: [],
      contacts: [],
      storyVisibility: mapToUser(userJson['storyVisibility']),
      maxFileSize: userJson['maxLimitFileSize'],
      maxDownloadSize: userJson['autoDownloadSizeLimit'],
    );
  }
  factory UserSettingsBodyModel.blockedUsersFromJson(
      Map<String, dynamic> json) {
    final blockList = (json['data']?['blockList'] as List<dynamic>?)
        ?.map((entry) {
          final blockedId = entry['blockedId'] as int?;
          final blockedUser = entry['blockedUser'] as Map<String, dynamic>?;
          final username = blockedUser?['username'] as String?;

          if (blockedId != null && username != null) {
            return BlockedUser(id: blockedId, username: username);
          }
          return null;
        })
        .where((blockedUser) => blockedUser != null)
        .cast<BlockedUser>()
        .toList();

    return UserSettingsBodyModel(blockedUsers: blockList);
  }
  factory UserSettingsBodyModel.contactsFromJson(List<dynamic> json) {
    final contactsList = json
        .map((chat) {
          final secondUser = chat['secondUser'] as Map<String, dynamic>?;

          if (secondUser != null) {
            final id = secondUser['id'] as int?;
            final username = secondUser['username'] as String?;

            if (id != null && username != null) {
              return BlockableContacts(id: id, username: username);
            }
          }
          return null;
        })
        .where((contact) => contact != null)
        .cast<BlockableContacts>()
        .toList();

    return UserSettingsBodyModel(contacts: contactsList);
  }

  static empty() {
    return UserSettingsBodyModel(
      profileImage: "",
      screenName: "",
      userName: "",
      phoneNumber: "",
      bio: "",
      status: "",
      autoDeleteTimer: "",
      lastSeenPrivacy: "",
      profilePhotoPrivacy: "",
      enableReadReceipt: '',
      storyVisibility: '',
      maxFileSize: 0,
      maxDownloadSize: 0,
      blockedUsers: [],
      contacts: [],
    );
  }
}
