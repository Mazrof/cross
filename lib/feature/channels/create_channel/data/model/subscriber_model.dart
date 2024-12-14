
import 'package:telegram/feature/channels/create_channel/domain/entity/subscriber_entity.dart';

class SubscriberModel extends Subscriber {
  SubscriberModel({
    required int userId,
    int? channelId,
    required String role,
    required bool hasDownloadPermissions,
  }) : super(
          userId: userId,
          channelId: channelId,
          role: role,
          hasDownloadPermissions: hasDownloadPermissions,
        );

  // From JSON
  factory SubscriberModel.fromJson(Map<String, dynamic> json) {
    return SubscriberModel(
      userId: json['userId'] as int,
      channelId: json['channelId'] as int?,
      role: json['role'] as String,
      hasDownloadPermissions: json['hasDownloadPermissions'] as bool,
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      if (channelId != null) 'channelId': channelId,
      'role': role,
      'hasDownloadPermissions': hasDownloadPermissions,
    };
  }
}
