class Message {
  final String content;
  final String time;
  final String sender;
  final bool isDate;

  Message({
    required this.isDate,
    required this.sender,
    required this.content,
    required this.time,
  });
}
