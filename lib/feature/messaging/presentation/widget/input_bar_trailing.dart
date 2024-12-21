import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:telegram/core/di/service_locator.dart';
import 'package:telegram/core/local/hive.dart';
import 'package:telegram/core/utililes/app_colors/app_colors.dart';
import 'package:telegram/core/utililes/app_enum/app_enum.dart';
import 'package:telegram/feature/home/presentation/controller/home/home_cubit.dart';
import 'package:telegram/feature/messaging/data/model/message.dart';
import 'package:telegram/feature/messaging/presentation/controller/chat_bloc.dart';

class InputBarTrailing extends StatelessWidget {
  final TextEditingController controller;

  final String receiverId;

  const InputBarTrailing(
      {super.key, required this.controller, required this.receiverId});

  @override
  Widget build(BuildContext context) {
    return (sl<ChatCubit>().state.typingState ||
            sl<ChatCubit>().state.editingState)
        ? Row(
            children: [
              IconButton(
                icon: const Icon(Icons.send),
                color: AppColors.grey,
                onPressed: () {
                  if (sl<ChatCubit>().state.replyState) {
                    String myId =
                        HiveCash.read(boxName: "register_info", key: 'id')
                            .toString();

                    final DateTime now = DateTime.now();
                    final DateFormat formatter = DateFormat('HH:mm');

                    Message replyMessage = Message(
                      content: controller.text,
                      isDate: false,
                      isGIF: false,
                      id: -1,
                      sender: myId,
                      time: formatter.format(now).toString(),
                      isReply: true,
                      isForward: false,
                      participantId: sl<HomeCubit>()
                          .state
                          .contacts[sl<ChatCubit>().state.chatIndex!]
                          .id
                          .toString(),
                      isPinned: false,
                      isDraft: false,
                    );

                    sl<ChatCubit>().replyToMessage(replyMessage);
                  } else if (sl<ChatCubit>().state.editingState) {
                    // Edit the message
                    sl<ChatCubit>().editMessage(sl<ChatCubit>().state.id,
                        sl<ChatCubit>().state.index, controller.text, false);
                  } else {
                    // Send The Message
                    // Make New Message Object
                    String myId =
                        HiveCash.read(boxName: "register_info", key: 'id')
                            .toString();

                    final DateTime now = DateTime.now();
                    final DateFormat formatter = DateFormat('HH:mm');

                    var participantId = "";

                    if (sl<ChatCubit>().state.chatType ==
                        ChatType.PersonalChat) {
                      participantId = sl<HomeCubit>()
                          .state
                          .contacts[sl<ChatCubit>().state.chatIndex!]
                          .id
                          .toString();
                    } else if (sl<ChatCubit>().state.chatType ==
                        ChatType.Group) {
                      print(sl<HomeCubit>().state.groups);
                      participantId = sl<HomeCubit>()
                          .state
                          .groups[sl<ChatCubit>().state.chatIndex!]
                          .partisipantId
                          .toString();
                    } else {
                      participantId = sl<HomeCubit>()
                          .state
                          .channels[sl<ChatCubit>().state.chatIndex!]
                          .id
                          .toString();
                    }
                    Message newMessage = Message(
                      content: controller.text,
                      isDate: false,
                      isGIF: false,
                      id: -1,
                      sender: myId,
                      time: formatter.format(now).toString(),
                      isReply: false,
                      isForward: false,
                      participantId: participantId,
                      isPinned: false,
                      isDraft: false,
                    );

                    sl<ChatCubit>().sendMessage(newMessage);
                  }

                  // clean the controller text
                  controller.text = "";

                  if (sl<ChatCubit>().state.editingState) {
                    // Edit the message
                    sl<ChatCubit>().editMessage(
                      sl<ChatCubit>().state.id,
                      sl<ChatCubit>().state.index,
                      controller.text,
                      false,
                    );
                  } else {
                    // Send The Message
                    // Make New Message Object

                    String myId =
                        HiveCash.read(boxName: "register_info", key: 'id')
                            .toString();

                    final DateTime now = DateTime.now();
                    final DateFormat formatter = DateFormat('HH:mm');

                    Message newMessage = Message(
                      content: controller.text,
                      isDate: false,
                      isGIF: false,
                      id: -1,
                      sender: myId,
                      time: formatter.format(now).toString(),
                      isReply: false,
                      isForward: false,
                      participantId: sl<HomeCubit>()
                          .state
                          .contacts[sl<ChatCubit>().state.chatIndex!]
                          .id
                          .toString(),

                      isPinned: false,
                      isDraft: false,

                    );

                    sl<ChatCubit>().sendMessage(newMessage);
                  }

                  // clean the controller text
                  controller.text = "";
                },
              ),
            ],
          )
        : Row(
            children: [
              IconButton(
                icon: const Icon(Icons.attach_file),
                color: AppColors.grey,
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.mic_outlined),
                color: AppColors.grey,
                onPressed: () {},
              ),
            ],
          );
  }
}
