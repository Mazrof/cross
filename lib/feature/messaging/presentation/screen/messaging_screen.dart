import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:telegram/core/component/popup_menu.dart';
import 'package:telegram/core/utililes/app_strings/app_strings.dart';
import 'package:telegram/feature/messaging/presentation/Data/Model/message.dart';
import 'package:telegram/feature/messaging/presentation/widget/CInput_bar.dart';
import 'package:telegram/core/component/capp_bar.dart';
import 'package:telegram/core/component/avatar.dart';
import 'package:telegram/feature/messaging/presentation/widget/message_list.dart';
import 'package:telegram/feature/messaging/presentation/widget/reciever_details.dart';
import 'package:telegram/core/utililes/app_colors/app_colors.dart';

class MessagingScreen extends StatelessWidget {
  MessagingScreen({super.key});

  final List<Message> messages = [
    Message(content: "Hello", time: "9:05", sender: "ME", isDate: false),
    Message(content: "Hello", time: "9:05", sender: "ME", isDate: false),
    Message(content: "October 3", time: "9:05", sender: "ME", isDate: true),
    Message(content: "Hello", time: "9:05", sender: "ME", isDate: false),
    Message(content: "October 3", time: "9:05", sender: "ME", isDate: true),
  ];
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CAppBar(
        onLeadingTap: () {},
        title: const RecieverDetails(
          userName: "Kiro",
          state: AppStrings.waitingInternet,
          avatar: Avatar(
              imageUrl:
                  "https://images.rawpixel.com/image_png_social_square/czNmcy1wcml2YXRlL3Jhd3BpeGVsX2ltYWdlcy93ZWJzaXRlX2NvbnRlbnQvMzY2LW1ja2luc2V5LTIxYTc3MzYtZm9uLWwtam9iNjU1LnBuZw.png"),
        ),
        showBackButton: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.call),
            color: AppColors.whiteColor,
            onPressed: () {},
          ),
          const PopupMenu([
            {'icon': Icons.volume_up, 'value': 'Mute'},
            {'icon': Icons.search, 'value': 'Search'},
            {'icon': Icons.copy, 'value': 'Change Background'},
            {'icon': Icons.clear, 'value': 'Clear History'},
            {'icon': Icons.delete, 'value': 'Delete Chat'},
          ]),
        ],
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/chat_background.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            children: [
              Expanded(
                child: MessageList(
                  messages: messages,
                ),
              ),
              CInputBar(
                controller: controller,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
