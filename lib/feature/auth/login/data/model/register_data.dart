class RegisterData {
  final int id;
  final String username;
  final String password;
  final String email;
  final String phone;
  final bool isEmailVerified;
  final bool isPhoneVerified;
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
  final String lastSeenVisibility;
  final bool groupAddPermission;
  final String? privateKey;
  final String? publicKey;

  RegisterData({
    required this.id,
    required this.username,
    required this.password,
    required this.email,
    required this.phone,
    required this.isEmailVerified,
    required this.isPhoneVerified,
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
    this.privateKey,
    this.publicKey,
  });

  factory RegisterData.fromJson(Map<String, dynamic> json) {
    final userJson = json['user'] ?? json;
    return RegisterData(
      id: userJson['id'] ?? 0,
      username: userJson['username'] ?? '',
      password: userJson['password'] ?? '',
      email: userJson['email'] ?? '',
      phone: userJson['phone'] ?? '',
      isEmailVerified: userJson['isEmailVerified'] ?? false,
      isPhoneVerified: userJson['isPhoneVerified'] ?? false,
      photo: userJson['photo'],
      bio: userJson['bio'],
      screenName: userJson['screenName'],
      status: userJson['status'] ?? false,
      lastSeen: userJson['lastSeen'] != null
          ? DateTime.parse(userJson['lastSeen'])
          : null,
      activeNow: userJson['activeNow'] ?? false,
      providerType: userJson['providerType'],
      providerId: userJson['providerId'],
      autoDownloadSizeLimit: userJson['autoDownloadSizeLimit'],
      maxLimitFileSize: userJson['maxLimitFileSize'],
      profilePicVisibility: userJson['profilePicVisibility'] ?? '',
      storyVisibility: userJson['storyVisibility'] ?? '',
      readReceiptsEnabled: userJson['readReceiptsEnabled'] ?? '',
      lastSeenVisibility: userJson['lastSeenVisibility'] ?? '',
      groupAddPermission: userJson['groupAddPermission'] ?? false,
      privateKey: userJson['privateKey'],
      publicKey: userJson['publicKey'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'password': password,
      'email': email,
      'phone': phone,
      if (photo != null) 'photo': photo,
      if (bio != null) 'bio': bio,
      if (screenName != null) 'screenName': screenName,
      'status': status,
      if (lastSeen != null) 'lastSeen': lastSeen!.toIso8601String(),
      'activeNow': activeNow,
      if (providerType != null) 'providerType': providerType,
      if (providerId != null) 'providerId': providerId,
      if (autoDownloadSizeLimit != null)
        'autoDownloadSizeLimit': autoDownloadSizeLimit,
      if (maxLimitFileSize != null) 'maxLimitFileSize': maxLimitFileSize,
      'profilePicVisibility': profilePicVisibility,
      'storyVisibility': storyVisibility,
      'readReceiptsEnabled': readReceiptsEnabled,
      'lastSeenVisibility': lastSeenVisibility,
      'groupAddPermission': groupAddPermission,
      if (privateKey != null) 'privateKey': privateKey,
      if (publicKey != null) 'publicKey': publicKey,
    };
  }
}
