import 'package:equatable/equatable.dart';

class Story extends Equatable {
  final String id;
  final DateTime createdAt;
  final int viewCount;
  final String status;
  final String mediaType;
  final String mediaUrl;
  final String content;
  final String userName;
  final String userImage;
  final bool isSeen;
  final bool isOwner;

  Story({
    required this.id,
    required this.createdAt,
    required this.viewCount,
    required this.status,
    required this.mediaType,
    required this.mediaUrl,
    required this.content,
    required this.userName,
    required this.userImage,
    required this.isSeen,
    required this.isOwner,
  });

  @override
  List<Object?> get props => [
        id,
        createdAt,
        viewCount,
        status,
        mediaType,
        mediaUrl,
        content,
        userName,
        userImage,
        isSeen,
        isOwner,
      ];
}
