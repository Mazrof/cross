import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:telegram/core/di/service_locator.dart';
import 'package:telegram/core/local/hive.dart';
import 'package:telegram/feature/messaging/data/model/message.dart';
import 'package:telegram/feature/messaging/presentation/controller/chat_bloc.dart';
import 'package:telegram/feature/messaging/presentation/controller/chat_state.dart';
import 'package:telegram/feature/messaging/presentation/widget/cmessage_widget.dart';
import 'package:telegram/feature/messaging/presentation/widget/message_date.dart';

class MessageList extends StatelessWidget {
  // final List<Message> messages;
  final scrollController;

  const MessageList({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatCubit, ChatState>(builder: (context, state) {
      return Stack(
        children: [
          ListView.builder(
            controller: scrollController,
            itemCount: state.messages.length,
            itemBuilder: (context, i) {
              if (state.messages[i].isDate) {
                return MessageDate(date: state.messages[i].content);
              } else {
                return Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: ChatMessage(
                    message: state.messages[i].content,
                    isSender: state.messages[i].sender ==
                        HiveCash.read(boxName: 'register_info', key: 'id')
                            .toString(),
                    time: state.messages[i].time,
                    index: i,
                    id: state.messages[i].id,
                    isGIF: state.messages[i].isGIF,
                    isReply: state.messages[i].isReply,
                    replyMessage: state.messages[i].replyMessage,
                    isForward: state.messages[i].isForward,
                  ),
                );
              }
            },
          ),
          if (sl<ChatCubit>().state.editingState ||
              sl<ChatCubit>().state.selectionState)
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
              child: Stack(
                children: [
                  Container(
                    color: Colors.black.withOpacity(0.2),
                  ),
                  Positioned(
                    right: (sl<ChatCubit>().state).xCoordiate,
                    top: (sl<ChatCubit>().state).yCoordiate -
                        78 +
                        MediaQuery.of(context).viewInsets.bottom,
                    // right: 50,
                    // top: 100 - 78 + MediaQuery.of(context).viewInsets.bottom,
                    child: ChatMessage(
                      message:
                          state.messages[(sl<ChatCubit>().state).index].content,
                      isSender: state
                              .messages[(sl<ChatCubit>().state).index].sender ==
                          HiveCash.read(boxName: 'register_info', key: 'id')
                              .toString(),
                      time: state.messages[(sl<ChatCubit>().state).index].time,
                      index: (sl<ChatCubit>().state).index,
                      id: (sl<ChatCubit>().state).id,
                      isGIF:
                          state.messages[(sl<ChatCubit>().state).index].isGIF,
                      isReply:
                          state.messages[(sl<ChatCubit>().state).index].isReply,
                      isForward: state
                          .messages[(sl<ChatCubit>().state).index].isForward,
                    ),
                  ),
                ],
              ),
            )
        ],
      );
    });
  }
}
