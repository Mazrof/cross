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
  }) : super(
          id: id,
          createdAt: createdAt,
          viewCount: viewCount,
          status: status,
          mediaType: mediaType,
          mediaUrl: mediaUrl,
          content: content,
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
    };
  }
}
