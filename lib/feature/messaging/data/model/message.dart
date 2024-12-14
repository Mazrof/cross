// need to change this to equatable
class Message {
  String content;
  final String time;
  final String sender;
  final bool isDate;
  final bool isGIF;
  final bool isReply;
  final bool isForward;
  final String participantId;
  String? replyMessage;
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
        other.isGIF == isGIF;
    // if (identical(this, other)) return true;
    return ans;
  }
}
