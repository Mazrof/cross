import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:telegram/core/component/popup_menu.dart';
import 'package:telegram/core/di/service_locator.dart';
import 'package:telegram/core/local/hive.dart';
import 'package:telegram/core/network/socket/socket_service.dart';
import 'package:telegram/core/routes/app_router.dart';
import 'package:telegram/core/utililes/app_strings/app_strings.dart';
import 'package:telegram/feature/auth/forget_password/presentataion/screen/forget_password_screen.dart';
import 'package:telegram/feature/messaging/presentation/controller/chat_bloc.dart';
import 'package:telegram/feature/messaging/presentation/controller/chat_state.dart';
import 'package:telegram/feature/messaging/presentation/widget/cinput_bar.dart';
import 'package:telegram/core/component/capp_bar.dart';
import 'package:telegram/core/component/avatar.dart';
import 'package:telegram/feature/messaging/presentation/widget/message_list.dart';
import 'package:telegram/feature/messaging/presentation/widget/reciever_details.dart';
import 'package:telegram/core/utililes/app_colors/app_colors.dart';
import 'package:telegram/feature/night_mode/presentation/controller/night_mode_cubit.dart';
import 'package:go_router/go_router.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({super.key});

  final TextEditingController controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  String receiverId = "";

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatCubit, ChatState>(
      builder: (context, state) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
        });

        // Hard Code the Ids
        String myId =
            HiveCash.read(boxName: 'register_info', key: 'id').toString();

        if (myId == "100") {
          receiverId = "102";
        } else {
          receiverId = "100";
        }

        print(receiverId);

        return Scaffold(
          appBar: state.selectionState == false && state.editingState == false
              ? CAppBar(
                  onLeadingTap: () {
                    // WidgetsBinding.instance.addPostFrameCallback(
                    //   (_) {
                    //     context.read<ChatCubit>().close();
                    //   },
                    // );
                    // sl<SocketService>().socket!.close();

                    context.go(AppRouter.kHome);
                  },
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
                )
              : CAppBar(
                  onLeadingTap: () {
                    sl<ChatCubit>().unselectMessage();
                    // if (controller.text.isNotEmpty) {
                    //   sl<ChatCubit>().typingMessage();
                    // } else {
                    //   sl<ChatCubit>().defaultState();
                    // }
                  },
                  leadingIcon: Icons.close,
                  title: const Text("1"),
                  actions: [
                    IconButton(
                      icon: const Icon(Icons.copy),
                      color: AppColors.whiteColor,
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: const Icon(Icons.forward_outlined),
                      color: AppColors.whiteColor,
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete_outlined),
                      color: AppColors.whiteColor,
                      onPressed: () {
                        sl<ChatCubit>().deleteMessage(state.id, state.index);
                      },
                    ),
                    IconButton(
                      onPressed: () {
                        sl<ChatCubit>().replyingToMessage();
                        // sl<ChatCubit>().replyToMessage(state.id);
                      },
                      icon: const Icon(Icons.reply),
                    ),
                    IconButton(
                      icon: const Icon(Icons.edit_outlined),
                      color: AppColors.whiteColor,
                      onPressed: () {
                        controller.text = state.messages[state.index].content;
                        sl<ChatCubit>().editingMessage(
                          state.index,
                          state.id,
                        );
                      },
                    ),
                  ],
                ),
          body: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: sl<NightModeCubit>().state
                        ? const AssetImage('assets/images/chat_background.png')
                        : const AssetImage('assets/images/chat_background.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Column(
                children: [
                  Expanded(
                    child: MessageList(
                      messages: state.messages,
                      scrollController: _scrollController,
                    ),
                  ),
                  CinputBar(receiverId: receiverId),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
