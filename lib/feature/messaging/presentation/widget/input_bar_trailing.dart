import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:telegram/core/di/service_locator.dart';
import 'package:telegram/core/local/hive.dart';
import 'package:telegram/core/utililes/app_colors/app_colors.dart';
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
                  if (sl<ChatCubit>().state.editingState) {
                    // Edit the message
                    sl<ChatCubit>().editMessage(
                      sl<ChatCubit>().state.id,
                      sl<ChatCubit>().state.index,
                      controller.text,
                    );
                  } else {
                    // Send The Message
                    sl<ChatCubit>().sendMessage(
                      controller.text,
                      HiveCash.read(boxName: "register_info", key: 'id')
                          .toString(),
                      receiverId,
                      false,
                    );
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
