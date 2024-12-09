class Message {
  String content;
  final String time;
  final String sender;
  final bool isDate;
  final bool isGIF;
  final bool isReply;
  String? replyMessage;
  int id;

  Message(
      {required this.isDate,
      required this.sender,
      required this.content,
      required this.time,
      required this.id,
      required this.isGIF,
      required this.isReply,
      this.replyMessage});

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
