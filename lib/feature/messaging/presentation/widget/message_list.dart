import 'package:flutter/material.dart';
import 'package:telegram/feature/messaging/presentation/Data/Model/message.dart';
import 'package:telegram/feature/messaging/presentation/widget/cmessage_widget.dart';

class MessageList extends StatelessWidget {
  final List<Message> messages;
  const MessageList({super.key, required this.messages});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      reverse: true,
      itemCount: messages.length,
      itemBuilder: (context, i) => ChatMessage(
        message: messages[i].content,
        isSender: true,
        time: messages[i].time,
      ),
    );
  }
}
