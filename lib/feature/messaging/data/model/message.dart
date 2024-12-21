// need to change this to equatable
import 'package:hive/hive.dart';

part 'message.g.dart';

@HiveType(typeId: 0)
class Message extends HiveObject {
  @HiveField(0)
  String content;
  @HiveField(1)
  final String time;
  @HiveField(2)
  final String sender;
  @HiveField(3)
  final bool isDate;
  @HiveField(4)
  final bool isGIF;
  @HiveField(5)
  final bool isReply;
  @HiveField(6)
  final bool isForward;
  @HiveField(7)
  final String participantId;
  @HiveField(8)
  final bool isDraft;
  @HiveField(9)
  bool isPinned;
  @HiveField(10)
  String? replyMessage;
  @HiveField(11)
  int id;

  Message({
    required this.isDate,
    required this.sender,
    required this.content,
    required this.time,
    required this.id,
    required this.isGIF,
    required this.isReply,
    required this.isForward,
    required this.participantId,
    required this.isPinned,
    required this.isDraft,
    this.replyMessage,
  });

  void setId(int id) {
    this.id = id;
  }

  @override
  bool operator ==(Object other) {
    bool ans = other is Message &&
        other.id == id &&
        other.content == content &&
        other.isPinned == isPinned &&
        other.isDraft == isDraft &&
        other.isGIF == isGIF;
    // if (identical(this, other)) return true;
    return ans;
  }
}
