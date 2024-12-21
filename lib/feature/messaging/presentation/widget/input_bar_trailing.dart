import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:telegram/core/di/service_locator.dart';
import 'package:telegram/core/local/hive.dart';
import 'package:telegram/core/network/api/api_service.dart';
import 'package:telegram/core/utililes/app_colors/app_colors.dart';
import 'package:telegram/core/utililes/app_enum/app_enum.dart';
import 'package:telegram/feature/home/presentation/controller/home/home_cubit.dart';
import 'package:telegram/feature/messaging/data/model/message.dart';
import 'package:telegram/feature/messaging/presentation/controller/chat_bloc.dart';

class InputBarTrailing extends StatelessWidget {
  final TextEditingController controller;

  final String receiverId;
  final RecorderController recorderController;

  const InputBarTrailing({
    super.key,
    required this.controller,
    required this.receiverId,
    required this.recorderController,
  });

  @override
  Widget build(BuildContext context) {
    Future<Uint8List> convertAudioToBytes(String filePath) async {
      File file = File(filePath);
      Uint8List bytes = await file.readAsBytes();
      return bytes;
    }

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

                    Map<String, String> message = {
                      'content': controller.text,
                      'type': 'text',
                    };

                    Message newMessage = Message(
                      content: jsonEncode(message),
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

                  // if (sl<ChatCubit>().state.editingState) {
                  //   // Edit the message
                  //   sl<ChatCubit>().editMessage(
                  //     sl<ChatCubit>().state.id,
                  //     sl<ChatCubit>().state.index,
                  //     controller.text,
                  //     false,
                  //   );
                  // } else {
                  //   // Send The Message
                  //   // Make New Message Object

                  //   String myId =
                  //       HiveCash.read(boxName: "register_info", key: 'id')
                  //           .toString();

                  //   final DateTime now = DateTime.now();
                  //   final DateFormat formatter = DateFormat('HH:mm');

                  //   Message newMessage = Message(
                  //     content: controller.text,
                  //     isDate: false,
                  //     isGIF: false,
                  //     id: -1,
                  //     sender: myId,
                  //     time: formatter.format(now).toString(),
                  //     isReply: false,
                  //     isForward: false,
                  //     participantId: sl<HomeCubit>()
                  //         .state
                  //         .contacts[sl<ChatCubit>().state.chatIndex!]
                  //         .id
                  //         .toString(),

                  //     isPinned: false,
                  //     isDraft: false,

                  //   );

                  //   sl<ChatCubit>().sendMessage(newMessage);
                  // }

                  // // clean the controller text
                  // controller.text = "";
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
              GestureDetector(
                onTapDown: (details) {
                  // start recording
                  recorderController.checkPermission();
                  if (recorderController.hasPermission) {
                    recorderController
                        .record(); // By default saves file with datetime as name.
                  }
                },
                onTapUp: (details) async {
                  {
                    if (recorderController.isRecording) {
                      String? recordedFilePath =
                          await recorderController.stop();

                      print("Path${recordedFilePath!}");

                      // store it on a cloud
                      // send the link as the message
                      Uint8List fileBytes =
                          await convertAudioToBytes(recordedFilePath);

                      Response response = await sl<ApiService>().post(
                        endPoint: "accounts/FW25cKj/uploads/binary",
                        base: "https://api.bytescale.com/v2",
                        options: Options(
                          headers: {
                            'Authorization':
                                "Bearer public_FW25cKjAvB4jbgD9VvPnb7hGiLA1",
                            'Content-Type': 'audio/mp4',
                          },
                        ),
                        data: fileBytes,
                      );

                      print(response);

                      // get the audio url
                      // make new Message object
                      // send it

                      Map<String, String> message = {
                        'content': response.data['filePath'],
                        'type': 'audio',
                      };

                      String myId =
                          HiveCash.read(boxName: 'register_info', key: 'id')
                              .toString();

                      Message newMessage = new Message(
                        content: jsonEncode(message),
                        id: -1,
                        isDate: false,
                        isDraft: false,
                        isForward: false,
                        isGIF: false,
                        isPinned: false,
                        isReply: false,
                        participantId: sl<HomeCubit>()
                            .state
                            .contacts[sl<ChatCubit>().state.chatIndex!]
                            .id
                            .toString(),
                        sender: myId,
                        time: DateFormat('HH:mm')
                            .format(DateTime.now())
                            .toString(),
                        replyMessage: "",
                      );

                      sl<ChatCubit>().sendMessage(newMessage);
                    }
                  }
                },
                child: Icon(
                  (Icons.mic_outlined),
                  color: AppColors.grey,
                ),
              ),
            ],
          );
  }
}
