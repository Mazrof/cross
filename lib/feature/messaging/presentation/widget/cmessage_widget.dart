import 'dart:convert';

import 'package:chat_bubbles/bubbles/bubble_special_one.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:telegram/core/di/service_locator.dart';
import 'package:telegram/core/helper/screen_helper.dart';
import 'package:telegram/core/utililes/app_colors/app_colors.dart';
import 'package:telegram/core/utililes/app_sizes/app_sizes.dart';
import 'package:telegram/core/utililes/constant/constants.dart';
import 'package:telegram/feature/messaging/presentation/controller/chat_bloc.dart';
import 'package:telegram/feature/messaging/presentation/controller/chat_state.dart';

class ChatMessage extends StatelessWidget {
  final String message;
  final bool isSender;
  final String? imagePath;
  final String time;
  final bool isDelivered;
  final bool isSeen;
  final int index;
  final int id;
  final bool isGIF;
  final bool isReply;
  final bool isForward;
  String? replyMessage;

  ChatMessage({
    super.key,
    required this.message,
    required this.isSender,
    this.imagePath,
    required this.time,
    this.isDelivered = false,
    this.isSeen = false,
    required this.index,
    required this.id,
    required this.isGIF,
    required this.isReply,
    required this.isForward,
    this.replyMessage,
  });

  @override
  Widget build(BuildContext context) {
    Color getMessageBackGroundColor() {
      Color backgroundColor = Colors.white;

      if (isSender) {
        if (ScreenHelper.isDarkMode(context) == true) {
          backgroundColor = const Color.fromARGB(255, 67, 87, 47);
        } else {
          backgroundColor = Colors.white;
        }
      }

      return backgroundColor;
    }

    return BlocBuilder<ChatCubit, ChatState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment:
              isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            GestureDetector(
              onLongPress: () {
                print("Long Press detected!");

                // GlobalKey key = GlobalKey();
                dynamic object = context.findRenderObject();
                Offset position = object.localToGlobal(Offset.zero);
                Size size = object.size;

                sl<ChatCubit>().messageSelected(
                  index,
                  position.dx,
                  position.dy,
                  size.width,
                  size.height,
                  id,
                );
              },
              child: Container(
                margin: isSender
                    ? const EdgeInsets.only(
                        top: AppSizes.xs,
                        bottom: AppSizes.xs,
                        right: AppSizes.sm)
                    : const EdgeInsets.only(
                        top: AppSizes.xs,
                        bottom: AppSizes.xs,
                        right: AppSizes.sm),
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                decoration: BoxDecoration(
                  color: getMessageBackGroundColor(),
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(12),
                    topRight: const Radius.circular(12),
                    bottomLeft: isSender
                        ? const Radius.circular(12)
                        : const Radius.circular(0),
                    bottomRight: isSender
                        ? const Radius.circular(0)
                        : const Radius.circular(12),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (imagePath != null)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Container(
                          margin: const EdgeInsets.only(right: 50),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image(
                              image: AssetImage(imagePath!),
                            ),
                          ),
                        ),
                      ),
                    if (isReply)
                      // render the refernced message
                      Container(
                        padding: EdgeInsets.all(AppSizes.xs),
                        decoration: BoxDecoration(
                          color: AppColors.grey,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(
                              8.0,
                            ),
                            topLeft: Radius.circular(
                              8.0,
                            ),
                          ),
                        ),
                        child: Text(
                          replyMessage!,
                          style: const TextStyle(
                            color: AppColors.whiteColor,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    if (isForward)
                      // render text showing that it is forwarded message
                      Row(
                        children: [
                          Icon(
                            Icons.arrow_forward_ios_outlined,
                            color: Colors.black,
                            size: 16,
                          ),
                          Text(
                            "Forwarded Message",
                            style: const TextStyle(
                              color: AppColors.grey,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    if (message != "")
                      (jsonDecode(message)['type'] == 'GIF')
                          ? Image.network(
                              jsonDecode(message)['content'],
                              headers: {'accept': 'image/*'},
                              height: 200,
                              width: 200,
                            )
                          : Text(
                              jsonDecode(message)['content'],
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                              ),
                            ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          time,
                          textAlign: TextAlign.right,
                          style: const TextStyle(
                            color: AppColors.grey,
                            fontSize: 12,
                          ),
                        ),
                        // if (isSender)
                        Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: Icon(
                            _getStatusIcon(),
                            color: _getStatusColor(),
                            size: 16,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  IconData _getStatusIcon() {
    if (isSeen) {
      return Icons.done_all;
    } else if (isDelivered) {
      return Icons.done;
    } else {
      return Icons.error;
    }
  }

  Color _getStatusColor() {
    if (isSeen) {
      return Colors.blue;
    } else if (isDelivered) {
      return Colors.white70;
    } else {
      return Colors.red;
    }
  }
}

              // if replying to message
              // child: BubbleSpecialOne(
              //   text: message,
              //   color:
              //       isSender ? AppColors.lightBlueColor : AppColors.whiteColor,
              //   delivered: isDelivered,
              //   seen: isSeen,
              //   isSender: isSender,
              //   sent: true, // to be changed according to network status
              // ),

