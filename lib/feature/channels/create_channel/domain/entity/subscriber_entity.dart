import 'package:equatable/equatable.dart';

class Subscriber extends Equatable {
  final int userId;
  final int? channelId; // Optional because it may not always be provided
  final String role;
  final bool hasDownloadPermissions;

  Subscriber({
    required this.userId,
    this.channelId,
    required this.role,
    required this.hasDownloadPermissions,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [userId, channelId, role, hasDownloadPermissions];
}
