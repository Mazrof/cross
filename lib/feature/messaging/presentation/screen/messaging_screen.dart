import 'package:flutter/material.dart';
import 'package:telegram/feature/messaging/presentation/widget/CInput_bar.dart';
import 'package:telegram/core/component/Capp_bar.dart';
import 'package:telegram/core/component/avatar.dart';
import 'package:telegram/feature/messaging/presentation/widget/message_date.dart';
import 'package:telegram/feature/messaging/presentation/widget/reciever_details.dart';
import 'package:telegram/core/utililes/app_colors/app_colors.dart';
import 'package:telegram/core/utililes/app_sizes/app_sizes.dart';

class MessagingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CAppBar(
        onLeadingTap: () {},
        title: const RecieverDetails(
          userName: "Kiro",
          state: "Warte auf Netzwerk...",
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
          IconButton(
            icon: const Icon(Icons.more_vert),
            color: AppColors.whiteColor,
            onPressed: () {},
          ),
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
                child: ListView(
                  reverse: true,
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        margin: const EdgeInsets.all(8.0),
                        padding: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          color: AppColors.messageBackgroundColor,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'hello how are ferfergf few fewa ',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: AppSizes.fontSizeMd),
                            ),
                            Text(
                              '9:57 PM',
                              style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: AppSizes.fontSizeSm),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const CInputBar(),
            ],
          ),
        ],
      ),
    );
  }
}
