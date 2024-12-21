import 'package:telegram/feature/groups/add_new_group/domain/entity/member.dart';

class MemberModel extends Member {
  MemberModel(
      {required super.userId,
      super.role,
      super.hasDownloadPermissions,
      super.hasMessagePermissions});

  factory MemberModel.fromJson(Map<String, dynamic> json) {
    return MemberModel(
      userId: json['userId'],
      role: json['role'],
      hasDownloadPermissions: json['hasDownloadPermissions'],
      hasMessagePermissions: json['hasMessagePermissions'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'memberId': userId,
      'role': role,
      'hasDownloadPermissions': hasDownloadPermissions,
      'hasMessagePermissions': hasMessagePermissions,
    };
  }

  //empty object

   MemberModel empty() {
    return MemberModel(
      userId: 0,
      role: '',
      hasDownloadPermissions: false,
      hasMessagePermissions: false,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MemberModel &&
          runtimeType == other.runtimeType &&
          userId == other.userId &&
          role == other.role &&
          hasDownloadPermissions == other.hasDownloadPermissions &&
          hasMessagePermissions == other.hasMessagePermissions;

  @override
  int get hashCode =>
      userId.hashCode ^
      role.hashCode ^
      hasDownloadPermissions.hashCode ^
      hasMessagePermissions.hashCode;

  //empty object
}
