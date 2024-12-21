import 'package:telegram/feature/groups/group_setting/domain/entity/membership.dart';

class MembershipModel extends MembershipEntity {
  MembershipModel({
    required int groupId,
    required int userId,
    required String role,
    required bool active,
    required bool hasDownloadPermissions,
    required bool hasMessagePermissions,
    required String username,
    required String imageUrl,
  }) : super(
          groupId: groupId,
          userId: userId,
          role: role,
          status: active,
          hasDownloadPermissions: hasDownloadPermissions,
          hasMessagePermissions: hasMessagePermissions,
          username: username,
          imageUrl: imageUrl,
        );

  factory MembershipModel.fromJson(Map<String, dynamic> json) {
    return MembershipModel(
      groupId: json['groupId'],
      userId: json['userId'],
      role: json['role'],
      active: json['active'],
      hasDownloadPermissions: json['hasDownloadPermissions'],
      hasMessagePermissions: json['hasMessagePermissions'],
      username: json['users']['username'],
      imageUrl: json['imageUrl'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'groupId': groupId,
      'userId': userId,
      'role': role,
      'status': status,
      'hasDownloadPermissions': hasDownloadPermissions,
      'hasMessagePermissions': hasMessagePermissions,
      'username': username,
      'imageUrl': imageUrl,
    };
  }

  //make a copywith

  MembershipModel copyWith({
    int? groupId,
    int? userId,
    String? role,
    bool? active,
    bool? hasDownloadPermissions,
    bool? hasMessagePermissions,
    String? username,
    String? imageUrl,
  }) {
    return MembershipModel(
      groupId: groupId ?? this.groupId,
      userId: userId ?? this.userId,
      role: role ?? this.role,
      active: status ?? this.status,
      hasDownloadPermissions:
          hasDownloadPermissions ?? this.hasDownloadPermissions,
      hasMessagePermissions:
          hasMessagePermissions ?? this.hasMessagePermissions,
      username: username ?? this.username,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  //empty object

  static MembershipModel empty() {
    return MembershipModel(
      groupId: 0,
      userId: 0,
      role: '',
      active: false,
      hasDownloadPermissions: false,
      hasMessagePermissions: false,
      username: '',
      imageUrl: '',
    );
  }
}
