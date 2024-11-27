class Story {
  final String id;
  final DateTime createdAt;
  final int viewCount;
  final String status;
  final String mediaType;
  final String mediaUrl;
  final String content;

  Story({
    required this.id,
    required this.createdAt,
    required this.viewCount,
    required this.status,
    required this.mediaType,
    required this.mediaUrl,
    required this.content,
  });
}
