import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:telegram/core/di/service_locator.dart';
import 'package:telegram/feature/messaging/data/model/message.dart';
import 'package:telegram/feature/messaging/presentation/controller/chat_bloc.dart';
import 'package:telegram/feature/messaging/presentation/controller/chat_state.dart';
import 'package:telegram/feature/messaging/presentation/widget/cmessage_widget.dart';
import 'package:telegram/feature/messaging/presentation/widget/message_date.dart';

class MessageList extends StatelessWidget {
  final List<Message> messages;
  const MessageList({super.key, required this.messages});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView.builder(
          reverse: true,
          itemCount: messages.length,
          itemBuilder: (context, i) {
            if (messages[i].isDate) {
              return MessageDate(date: messages[i].content);
            } else {
              return ChatMessage(
                message: messages[i].content,
                isSender: true,
                time: messages[i].time,
                index: i,
              );
            }
          },
        ),
        if (sl<ChatCubit>().state is EditingMessage ||
            sl<ChatCubit>().state is MessageSelected)
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
            child: Stack(
              children: [
                Container(
                  color: Colors.black.withOpacity(0.2),
                ),
                Positioned(
                  right: (sl<ChatCubit>().state as MessageSelected).xCoordiate,
                  top: (sl<ChatCubit>().state as MessageSelected).yCoordiate -
                      78 +
                      MediaQuery.of(context).viewInsets.bottom,
                  child: ChatMessage(
                    message: messages[
                            (sl<ChatCubit>().state as MessageSelected).index]
                        .content,
                    isSender: true,
                    time: messages[
                            (sl<ChatCubit>().state as MessageSelected).index]
                        .time,
                    index: (sl<ChatCubit>().state as MessageSelected).index,
                  ),
                ),
              ],
            ),
          )
      ],
    );
  }
}
