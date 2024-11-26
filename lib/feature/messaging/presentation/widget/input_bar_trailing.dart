import 'package:flutter/material.dart';
import 'package:telegram/core/di/service_locator.dart';
import 'package:telegram/core/network/socket/socket_service.dart';
import 'package:telegram/core/utililes/app_colors/app_colors.dart';
import 'package:telegram/feature/messaging/presentation/controller/chat_bloc.dart';
import 'package:telegram/feature/messaging/presentation/controller/chat_state.dart';

class InputBarTrailing extends StatelessWidget {
  final TextEditingController controller;

  const InputBarTrailing({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return sl<ChatCubit>().state is TypingMessage ||
            sl<ChatCubit>().state is EditingMessage 
        ? Row(
            children: [
              IconButton(
                icon: const Icon(Icons.send),
                color: AppColors.grey,
                onPressed: () {
                  if (sl<ChatCubit>().state is EditingMessage) {
                    // Edit the message
                    sl<ChatCubit>().editMessage(
                        (sl<ChatCubit>().state as EditingMessage).id,
                        controller.text);
                  } else {
                    // Send The Message
                    sl<ChatCubit>().sendMessage(controller.text);
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
