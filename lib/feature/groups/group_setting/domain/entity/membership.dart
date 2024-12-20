import 'package:equatable/equatable.dart';

class MembershipEntity extends Equatable {
  final int groupId;
  final int userId;
  final String role;
  final bool status;
  final bool hasDownloadPermissions;
  final bool hasMessagePermissions;
  final String username;
  final String imageUrl;

  MembershipEntity({
    required this.groupId,
    required this.userId,
    required this.role,
    required this.status,
    required this.hasDownloadPermissions,
    required this.hasMessagePermissions,
    required this.username,
    required this.imageUrl,
  });
  
  @override
  // TODO: implement props
  List<Object?> get props =>  [
    groupId,
    userId,
    role,
    status,
    hasDownloadPermissions,
    hasMessagePermissions,
    username,
    imageUrl,
  ];
}
