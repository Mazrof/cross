import 'package:equatable/equatable.dart';

class Member extends Equatable {
  final int userId;
  final String role;
  final bool hasDownloadPermissions;
  final bool hasMessagePermissions;

  Member({
    required this.userId,
    this.role = 'member',
    this.hasDownloadPermissions = true,
    this.hasMessagePermissions = true,
  });

  @override
  List<Object?> get props => [userId, role, hasDownloadPermissions, hasMessagePermissions];
}
