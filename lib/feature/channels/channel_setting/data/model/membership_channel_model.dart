import 'package:equatable/equatable.dart';

class MembershipChannelModel extends Equatable {
  final int userId;
  final int channelId;
  final bool active;
  final bool hasDownloadPermissions;
  final String role;
  final String username;
  final String imageURL;

  const MembershipChannelModel({
    required this.userId,
    required this.channelId,
    required this.active,
    required this.hasDownloadPermissions,
    required this.role,
    required this.username,
    this.imageURL = '',
  });

  factory MembershipChannelModel.fromJson(Map<String, dynamic> json) {
    return MembershipChannelModel(
      userId: json['userId'],
      channelId: json['channelId'],
      active: json['active'],
      hasDownloadPermissions: json['hasDownloadPermissions'],
      role: json['role'],
      username: json['users']['username'],
      imageURL: json['users']['imageURL'] ?? '', // Fallback if imageURL is null
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'channelId': channelId,
      'active': active,
      'hasDownloadPermissions': hasDownloadPermissions,
      'role': role,
      'users': {
        'username': username,
      },
    };
  }

  @override
  List<Object?> get props => [
        userId,
        channelId,
        active,
        hasDownloadPermissions,
        role,
        username,
        imageURL,
      ];

  //copy with
  MembershipChannelModel copyWith({
    int? userId,
    int? channelId,
    bool? active,
    bool? hasDownloadPermissions,
    String? role,
    String? username,
    String? imageURL,
  }) {
    return MembershipChannelModel(
      userId: userId ?? this.userId,
      channelId: channelId ?? this.channelId,
      active: active ?? this.active,
      hasDownloadPermissions:
          hasDownloadPermissions ?? this.hasDownloadPermissions,
      role: role ?? this.role,
      username: username ?? this.username,
      imageURL: imageURL ?? this.imageURL,
    );
  }
}
