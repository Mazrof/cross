import 'package:equatable/equatable.dart';

class RegisterData extends Equatable {
  final int id;
  final String username;
  final String password;
  final DateTime? passwordChangedAt;
  final String email;
  final String phone;
  final String? photo;
  final String? bio;
  final String? screenName;
  final bool status;
  final DateTime? lastSeen;
  final bool activeNow;
  final String? providerType;
  final String? providerId;
  final int? autoDownloadSizeLimit;
  final int? maxLimitFileSize;
  final String profilePicVisibility;
  final String storyVisibility;
  final String readReceiptsEnabled;
  final bool lastSeenVisibility;
  final bool groupAddPermission;
  final bool isEmailVerified;
  final bool isPhoneVerified;
  final String? privateKey;
  final String publicKey;

  const RegisterData({
    required this.id,
    required this.username,
    required this.password,
    this.passwordChangedAt,
    required this.email,
    required this.phone,
    this.photo,
    this.bio,
    this.screenName,
    required this.status,
    this.lastSeen,
    required this.activeNow,
    this.providerType,
    this.providerId,
    this.autoDownloadSizeLimit,
    this.maxLimitFileSize,
    required this.profilePicVisibility,
    required this.storyVisibility,
    required this.readReceiptsEnabled,
    required this.lastSeenVisibility,
    required this.groupAddPermission,
    required this.isEmailVerified,
    required this.isPhoneVerified,
    this.privateKey,
    required this.publicKey,
  });

  @override
  List<Object?> get props => [
        id,
        username,
        password,
        passwordChangedAt,
        email,
        phone,
        photo,
        bio,
        screenName,
        status,
        lastSeen,
        activeNow,
        providerType,
        providerId,
        autoDownloadSizeLimit,
        maxLimitFileSize,
        profilePicVisibility,
        storyVisibility,
        readReceiptsEnabled,
        lastSeenVisibility,
        groupAddPermission,
        isEmailVerified,
        isPhoneVerified,
        privateKey,
        publicKey,
      ];

  factory RegisterData.fromJson(Map<String, dynamic> json) {
    return RegisterData(
      id: json['id'],
      username: json['username'],
      password: json['password'],
      passwordChangedAt: json['passwordChangedAt'] != null
          ? DateTime.parse(json['passwordChangedAt'])
          : null,
      email: json['email'],
      phone: json['phone'],
      photo: json['photo'],
      bio: json['bio'],
      screenName: json['screenName'],
      status: json['status'],
      lastSeen:
          json['lastSeen'] != null ? DateTime.parse(json['lastSeen']) : null,
      activeNow: json['activeNow'],
      providerType: json['providerType'],
      providerId: json['providerId'],
      autoDownloadSizeLimit: json['autoDownloadSizeLimit'],
      maxLimitFileSize: json['maxLimitFileSize'],
      profilePicVisibility: json['profilePicVisibility'],
      storyVisibility: json['storyVisibility'],
      readReceiptsEnabled: json['readReceiptsEnabled'],
      lastSeenVisibility: json['lastSeenVisibility'],
      groupAddPermission: json['groupAddPermission'],
      isEmailVerified: json['isEmailVerified'],
      isPhoneVerified: json['isPhoneVerified'],
      privateKey: json['privateKey'],
      publicKey: json['publicKey'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'password': password,
      'passwordChangedAt': passwordChangedAt?.toIso8601String(),
      'email': email,
      'phone': phone,
      'photo': photo,
      'bio': bio,
      'screenName': screenName,
      'status': status,
      'lastSeen': lastSeen?.toIso8601String(),
      'activeNow': activeNow,
      'providerType': providerType,
      'providerId': providerId,
      'autoDownloadSizeLimit': autoDownloadSizeLimit,
      'maxLimitFileSize': maxLimitFileSize,
      'profilePicVisibility': profilePicVisibility,
      'storyVisibility': storyVisibility,
      'readReceiptsEnabled': readReceiptsEnabled,
      'lastSeenVisibility': lastSeenVisibility,
      'groupAddPermission': groupAddPermission,
      'isEmailVerified': isEmailVerified,
      'isPhoneVerified': isPhoneVerified,
      'privateKey': privateKey,
      'publicKey': publicKey,
    };
  }
}
