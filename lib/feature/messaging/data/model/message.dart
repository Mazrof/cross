class Message {
  final String content;
  final String time;
  final String sender;
  final bool isDate;

  int id;

  Message({
    required this.isDate,
    required this.sender,
    required this.content,
    required this.time,
    required this.id,
  });

  void setId(int id) {
    this.id = id;
  }
}
