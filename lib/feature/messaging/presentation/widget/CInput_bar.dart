import 'dart:convert';

import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:flutter/material.dart';
import 'package:giphy_picker/giphy_picker.dart';
import 'package:intl/intl.dart';
import 'package:telegram/core/di/service_locator.dart';
import 'package:telegram/core/local/hive.dart';
import 'package:telegram/core/utililes/app_colors/app_colors.dart';
import 'package:telegram/core/utililes/app_enum/app_enum.dart';
import 'package:telegram/core/utililes/app_sizes/app_sizes.dart';
import 'package:telegram/feature/home/presentation/controller/home/home_cubit.dart';
import 'package:telegram/feature/messaging/data/model/message.dart';
import 'package:telegram/feature/messaging/presentation/controller/chat_bloc.dart';
import 'package:telegram/feature/messaging/presentation/screen/chat_screen.dart';
import 'package:telegram/feature/messaging/presentation/widget/input_bar_trailing.dart';

class CinputBar extends StatelessWidget {
  CinputBar({
    super.key,
    required this.showContactModal,
    required this.textInput,
    required this.recorderController,
  });

  final void Function() showContactModal;
  final RecorderController recorderController;

  StringWrapper textInput;

  final TextEditingController controller = TextEditingController(
    text: sl<ChatCubit>().state.text,
  );
  final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSizes.sm),
      child: Column(
        children: [
          Container(
            // height: AppSizes.inputFieldH,
            decoration: BoxDecoration(
              color: Theme.of(context).dialogBackgroundColor,
              borderRadius: BorderRadius.circular(AppSizes.borderRadiusLg),
              boxShadow: const [
                BoxShadow(
                  color: AppColors.blackColor12,
                  spreadRadius: 2,
                  blurRadius: 5,
                ),
              ],
            ),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.emoji_emotions_outlined),
                  iconSize: AppSizes.iconMd,
                  color: AppColors.grey,
                  onPressed: () async {
                    // show GIFs and Stickers picker
                    final gif = await GiphyPicker.pickGif(
                      context: context,
                      // YOUR GIPHY APIKEY HERE
                      apiKey: "cT82h8t2IZnnLbrCbS4LP98ZY5t3K9V6",
                      showPreviewPage: false,
                    );

                    String myId =
                        HiveCash.read(boxName: "register_info", key: 'id')
                            .toString();
                    final DateTime now = DateTime.now();

                    if (gif != null) {
                      Map<String, String> message = {
                        'content': gif!.images.original!.url!,
                        'type': 'GIF',
                      };

                      Message newMessage = Message(
                        content: jsonEncode(message),
                        id: -1,
                        isDate: false,
                        isGIF: true,
                        sender: myId,
                        time: now.toString(),
                        isReply: false,
                        isDraft: false,
                        isForward: false,
                        isPinned: false,
                        participantId: sl<HomeCubit>()
                            .state
                            .contacts[sl<ChatCubit>().state.chatIndex!]
                            .id
                            .toString(),
                      );

                      sl<ChatCubit>().sendMessage(
                        newMessage,
                      );
                    }
                  },
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        bottom: AppSizes.xxs, top: AppSizes.xxs),
                    child: KeyboardListener(
                      focusNode: _focusNode,
                      onKeyEvent: (value) {
                        // print(value);
                      },
                      child: TextField(
                        contentInsertionConfiguration:
                            ContentInsertionConfiguration(
                          allowedMimeTypes: [
                            'image/gif',
                            'image/png',
                            'image/jpeg'
                          ],
                          onContentInserted: (data) {
                            // Handle the inserted content here
                            // send the gif

                            String myId = HiveCash.read(
                                boxName: "register_info", key: 'id');
                            final DateTime now = DateTime.now();

                            Message newMessage = new Message(
                              content: data.uri,
                              id: -1,
                              isDate: false,
                              isGIF: true,
                              sender: myId,
                              time: now.toString(),
                              isDraft: false,
                              isForward: false,
                              isPinned: false,
                              isReply: false,
                              participantId: sl<HomeCubit>()
                                  .state
                                  .contacts[sl<ChatCubit>().state.chatIndex!]
                                  .id
                                  .toString(),
                            );

                            sl<ChatCubit>().sendMessage(
                              newMessage,
                            );
                          },
                        ),

                        keyboardType: TextInputType.multiline,
                        style: Theme.of(context).textTheme.bodyMedium,
                        maxLines:
                            5, // Max number of lines before field starts scrolling
                        minLines:
                            1, // Minimum number of lines field will start with
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.all(8),
                          hintStyle: TextStyle(
                              fontWeight: FontWeight.w300,
                              color: AppColors.grey),
                          hintText: "Message",
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                        ),
                        onChanged: (text) {
                          textInput.value = text;
                          if (text == "") {
                            sl<ChatCubit>().notTyping();
                          } else {
                            sl<ChatCubit>().typingMessage();

                            /// Cannotttttttttttttttttt Mention in Personal Chat
                            if ((sl<ChatCubit>().state.chatType ==
                                        ChatType.Group ||
                                    sl<ChatCubit>().state.chatType ==
                                        ChatType.Group) &&
                                text[text.length - 1] == '@') {
                              // check if last entered character is @ -> show mention modalSheet
                              showContactModal();
                            }
                          }
                        },
                        controller: controller,
                      ),
                    ),
                  ),
                ),
                InputBarTrailing(
                  controller: controller,
                  receiverId: sl<HomeCubit>()
                      .state
                      .contacts[sl<ChatCubit>().state.chatIndex!]
                      .id
                      .toString(),
                  recorderController: recorderController,
                )
              ],
            ),
          ),
        ],
      ),
    );

    //  MessageBar(
    //   replying: sl<ChatCubit>().state.replyState,
    //   replyingTo: sl<ChatCubit>().state.replyState
    //       ? sl<ChatCubit>().state.messages[sl<ChatCubit>().state.index].content
    //       : "",
    //   onSend: (text) {
    //     if (sl<ChatCubit>().state.replyState) {
    //       String myId =
    //           HiveCash.read(boxName: "register_info", key: 'id').toString();

    //       final DateTime now = DateTime.now();
    //       final DateFormat formatter = DateFormat('HH:mm');

    //       Message replyMessage = Message(
    //         content: text,
    //         isDate: false,
    //         isGIF: false,
    //         id: -1,
    //         sender: myId,
    //         time: formatter.format(now).toString(),
    //         isReply: true,
    //         isForward: false,
    //         participantId: sl<HomeCubit>()
    //             .state
    //             .contacts[sl<ChatCubit>().state.chatIndex!]
    //             .id
    //             .toString(),
    //         isPinned: false,
    //         isDraft: false,
    //       );

    //       sl<ChatCubit>().replyToMessage(replyMessage);
    //     } else if (sl<ChatCubit>().state.editingState) {
    //       // Edit the message
    //       sl<ChatCubit>().editMessage(sl<ChatCubit>().state.id,
    //           sl<ChatCubit>().state.index, text, false);
    //     } else {
    //       // Send The Message
    //       // Make New Message Object
    //       String myId =
    //           HiveCash.read(boxName: "register_info", key: 'id').toString();

    //       final DateTime now = DateTime.now();
    //       final DateFormat formatter = DateFormat('HH:mm');

    //       var participantId = "";

    //       if (sl<ChatCubit>().state.chatType == ChatType.PersonalChat) {
    //         participantId = sl<HomeCubit>()
    //             .state
    //             .contacts[sl<ChatCubit>().state.chatIndex!]
    //             .id
    //             .toString();
    //       } else if (sl<ChatCubit>().state.chatType == ChatType.Group) {
    //         print(sl<HomeCubit>().state.groups);
    //         participantId = sl<HomeCubit>()
    //             .state
    //             .groups[sl<ChatCubit>().state.chatIndex!]
    //             .partisipantId
    //             .toString();
    //       } else {
    //         participantId = sl<HomeCubit>()
    //             .state
    //             .channels[sl<ChatCubit>().state.chatIndex!]
    //             .id
    //             .toString();
    //       }
    //       Message newMessage = Message(
    //         content: text,
    //         isDate: false,
    //         isGIF: false,
    //         id: -1,
    //         sender: myId,
    //         time: formatter.format(now).toString(),
    //         isReply: false,
    //         isForward: false,
    //         participantId: participantId,
    //         isPinned: false,
    //         isDraft: false,
    //       );

    //       sl<ChatCubit>().sendMessage(newMessage);
    //     }

    //     // clean the controller text
    //     text = "";
    //   },
    //   actions: [
    //     InkWell(
    //       child: Icon(
    //         Icons.add,
    //         color: Colors.black,
    //         size: 24,
    //       ),
    //       onTap: () {},
    //     ),
    //     Padding(
    //       padding: EdgeInsets.only(left: 8, right: 8),
    //       child: InkWell(
    //         child: Icon(
    //           Icons.camera_alt,
    //           color: Colors.green,
    //           size: 24,
    //         ),
    //         onTap: () {},
    //       ),
    //     ),
    //   ],
    //   onTextChanged: (text) {
    //     textInput.value = text;
    //     if (text == "") {
    //       sl<ChatCubit>().notTyping();
    //     } else {
    //       sl<ChatCubit>().typingMessage(text);

    //       /// Cannotttttttttttttttttt Mention in Personal Chat
    //       if (text[text.length - 1] == '@') {
    //         // check if last entered character is @ -> show mention modalSheet
    //         showContactModal();
    //       }
    //     }
    //   },
    // );
  }
}
