import 'package:flutter/material.dart';
import 'package:telegram/core/di/service_locator.dart';
import 'package:telegram/core/local/hive.dart';
import 'package:telegram/core/utililes/app_colors/app_colors.dart';
import 'package:telegram/core/utililes/app_sizes/app_sizes.dart';
import 'package:telegram/feature/messaging/data/model/message.dart';
import 'package:telegram/feature/messaging/presentation/controller/chat_bloc.dart';
import 'package:telegram/feature/messaging/presentation/widget/input_bar_trailing.dart';

class CinputBar extends StatelessWidget {
  CinputBar({required this.controller, required this.receiverId});

  final String receiverId;

  final TextEditingController controller;
  final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSizes.sm),
      child: Container(
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
              onPressed: () {},
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

                        String myId =
                            HiveCash.read(boxName: "register_info", key: 'id');
                        final DateTime now = DateTime.now();

                        Message newMessage = new Message(
                            content: data.uri,
                            id: -1,
                            isDate: false,
                            isGIF: true,
                            sender: myId,
                            time: now.toString());

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
                          fontWeight: FontWeight.w300, color: AppColors.grey),
                      hintText: "Message",
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                    ),
                    onChanged: (text) {
                      if (controller.text != "") {
                        sl<ChatCubit>().typingMessage();
                      } else {
                        sl<ChatCubit>().defaultState();
                      }
                    },
                    controller: controller,
                  ),
                ),
              ),
            ),
            InputBarTrailing(
              controller: controller,
              receiverId: receiverId,
            )
          ],
        ),
      ),
    );
  }
}
