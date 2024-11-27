class Message {
  String content;
  final String time;
  final String sender;
  final bool isDate;
  final isGIF;

  int id;

  Message({
    required this.isDate,
    required this.sender,
    required this.content,
    required this.time,
    required this.id,
    required this.isGIF,
  });

  void setId(int id) {
    this.id = id;
  }
}
