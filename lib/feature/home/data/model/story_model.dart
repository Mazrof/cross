import 'package:telegram/feature/home/domain/entity/story.dart';

class StoryModel extends Story {
  StoryModel({
    required String id,
    required DateTime createdAt,
    required int viewCount,
    required String status,
    required String mediaType,
    required String mediaUrl,
    required String content,
    required String userName,
    required String userImage,
    required bool isSeen,
    required bool isOwner,
  }) : super(
          id: id,
          createdAt: createdAt,
          viewCount: viewCount,
          status: status,
          mediaType: mediaType,
          mediaUrl: mediaUrl,
          content: content,
          userName: userName,
          userImage: userImage,
          isSeen: isSeen,
          isOwner: isOwner,
        );

  factory StoryModel.fromJson(Map<String, dynamic> json) {
    return StoryModel(
      id: json['id'],
      createdAt: DateTime.parse(json['created_at']),
      viewCount: json['view_count'],
      status: json['status'],
      mediaType: json['media_type'],
      mediaUrl: json['media_url'],
      content: json['content'],
      userName: json['user_name'],
      userImage: json['user_image'],
      isSeen: json['is_seen'],
      isOwner: json['is_owner'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'created_at': createdAt.toIso8601String(),
      'view_count': viewCount,
      'status': status,
      'media_type': mediaType,
      'media_url': mediaUrl,
      'content': content,
      'user_name': userName,
      'user_image': userImage,
      'is_seen': isSeen,
      'is_owner': isOwner,
    };
  }
}
