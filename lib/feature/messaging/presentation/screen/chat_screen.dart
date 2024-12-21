import 'package:duration_picker/duration_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:telegram/core/component/clogo_loader.dart';
import 'package:telegram/core/component/popup_menu.dart';
import 'package:telegram/core/di/service_locator.dart';
import 'package:telegram/core/local/hive.dart';
import 'package:telegram/core/network/socket/socket_service.dart';
import 'package:telegram/core/routes/app_router.dart';
import 'package:telegram/core/utililes/app_strings/app_strings.dart';
import 'package:telegram/feature/auth/forget_password/presentataion/screen/forget_password_screen.dart';
import 'package:telegram/feature/home/data/model/chat_model.dart';
import 'package:telegram/feature/home/presentation/controller/home/home_cubit.dart';
import 'package:telegram/feature/messaging/data/model/message.dart';
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

class StringWrapper {
  String value;
  StringWrapper(this.value);
}

class ChatScreen extends StatelessWidget {
  ChatScreen({super.key});

  final TextEditingController controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  StringWrapper textInput = StringWrapper("");

  @override
  Widget build(BuildContext context) {
    void _scrollToIndex(int index) {
      // print(sl<ChatCubit>().state.pinnedIndex!);
      _scrollController.animateTo(
        (index) * 50.0,
        duration: Duration(seconds: 1),
        curve: Curves.easeInOut,
      );
    }

    void setDestructTime() async {
      Duration? resultingDuration = await showDurationPicker(
        context: context,
        initialTime: Duration(minutes: 3),
      );

      if (resultingDuration != null) {
        sl<ChatCubit>().setDestructTime(resultingDuration.inMinutes);
      }
    }

    Widget getPinnedMessage() {
      GestureDetector pinnedMessage = GestureDetector();

      int index = -1;

      for (int i = 0; i < sl<ChatCubit>().state.messages.length; i++) {
        if (sl<ChatCubit>().state.messages[i].isPinned) {
          // pinnedMessages.add(
          //   Container(
          //     height: 30,
          //     width: 100,
          //     child: Text(
          //       sl<ChatCubit>().state.messages[i].content,
          //     ),
          //   ),
          // );

          pinnedMessage = GestureDetector(
            onTap: () {
              _scrollToIndex(sl<ChatCubit>().state.pinnedIndex!);
            },
            child: Container(
              height: 30,
              width: 300,
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Row(
                children: [
                  Icon(Icons.push_pin),
                  Text(
                    sl<ChatCubit>().state.messages[i].content,
                    style: TextStyle(
                      color: AppColors.blackColor,
                    ),
                  ),
                ],
              ),
            ),
          );

          index = i;
        }
      }

      sl<ChatCubit>().updateEmitIndex(index);

      return pinnedMessage;
    }

    Future<String?> showContactModal() async {
      // get the contacts names to show them
      // get them from the contacts list

      // final members = sl<ChatCubit>().state.chatType == ChatType.Group ? sl<HomeCubit>().state.groups[ sl<ChatCubit>().state.chatIndex!].;
      final contacts = sl<HomeCubit>().state.contacts;

      List contactNames = [];

      for (var contact in contacts) {
        contactNames.add(contact.secondUser.username);
      }

      return await showModalBottomSheet<String>(
        context: context,
        backgroundColor: AppColors.grey,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        builder: (context) {
          return ListView.builder(
            itemCount: contacts.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(contacts[index].secondUser.username),
                onTap: () {
                  // setState(() {
                  //   _controller.text = '@${_contacts[index]} ';
                  // });

                  if (sl<ChatCubit>().state.selectionState) {
                    // if selected then return participantId

                    Navigator.pop(context, contacts[index].id.toString());
                  }
                },
              );
            },
          );
        },
      );
    }

    return BlocBuilder<ChatCubit, ChatState>(
      builder: (context, state) {
        // WidgetsBinding.instance.addPostFrameCallback((_) {
        //   _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
        // });
        PreferredSizeWidget appBar;

        String myId =
            HiveCash.read(boxName: 'register_info', key: 'id').toString();
        TextEditingController searchController = TextEditingController();

        if (state.isSearching) {
          appBar = CAppBar(
            showBackButton: true,
            onLeadingTap: () {
              sl<ChatCubit>().setSearchMode(false);
              sl<ChatCubit>().resetSearch();
            },
            title: TextField(
              controller: searchController,
              decoration: const InputDecoration(
                hintText: 'Search messages...',
                border: InputBorder.none,
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () async {
                  context
                      .read<ChatCubit>()
                      .searchMessages(searchController.text);

                  if (context
                      .read<ChatCubit>()
                      .state
                      .searchResultIndices
                      .isNotEmpty) {
                    _scrollToIndex(
                        context.read<ChatCubit>().state.searchResultIndices[
                            context.read<ChatCubit>().state.searchPtr]);
                  }
                },
              ),
              IconButton(
                icon: const Icon(Icons.arrow_upward),
                onPressed: () async {
                  if (!(context.read<ChatCubit>().state.searchPtr >=
                      context
                              .read<ChatCubit>()
                              .state
                              .searchResultIndices
                              .length -
                          1)) {
                    await context.read<ChatCubit>().incSearchPtr();
                    _scrollToIndex(
                        context.read<ChatCubit>().state.searchResultIndices[
                            context.read<ChatCubit>().state.searchPtr]);
                  }
                },
              ),
              IconButton(
                icon: const Icon(Icons.arrow_downward),
                onPressed: () async {
                  if (!(context.read<ChatCubit>().state.searchPtr <= 0)) {
                    await context.read<ChatCubit>().decSearchPtr();
                    _scrollToIndex(
                        context.read<ChatCubit>().state.searchResultIndices[
                            context.read<ChatCubit>().state.searchPtr]);
                  }
                },
              ),
            ],
          );
        } else if (state.selectionState == false &&
            state.editingState == false) {
          appBar = CAppBar(
            onLeadingTap: () async {
              // WidgetsBinding.instance.addPostFrameCallback(
              //   (_) {
              //     context.read<ChatCubit>().close();
              //   },
              // );
              // sl<SocketService>().socket!.close();

              // If Text is not empty draft it

              await sl<ChatCubit>().draftMessage(textInput.value);

              context.go(AppRouter.kHome);
            },
            title: RecieverDetails(
              userName: sl<HomeCubit>()
                  .state
                  .contacts[sl<ChatCubit>().state.chatIndex!]
                  .secondUser
                  .username,
              state: AppStrings.waitingInternet,
              avatar: Avatar(
                imageUrl: sl<HomeCubit>()
                    .state
                    .contacts[sl<ChatCubit>().state.chatIndex!]
                    .secondUser
                    .username,
              ),
            ),
            showBackButton: true,
            actions: [
              IconButton(
                icon: const Icon(Icons.call),
                color: AppColors.whiteColor,
                onPressed: () {},
              ),
              PopupMenu(
                [
                  {
                    'icon': sl<ChatCubit>().state.isMuted
                        ? Icons.volume_down
                        : Icons.volume_up,
                    'value': 'Mute'
                  },
                  {'icon': Icons.search, 'value': 'Search'},
                  {'icon': Icons.copy, 'value': 'Change Background'},
                  {'icon': Icons.timer, 'value': 'Timer'},
                  {'icon': Icons.clear, 'value': 'Clear History'},
                  {'icon': Icons.delete, 'value': 'Delete Chat'},
                ],
                actions: [
                  () => {sl<ChatCubit>().muteChat()},
                  () => {sl<ChatCubit>().setSearchMode(true)},
                  () => {},
                  () => setDestructTime(),
                  () => {},
                  () => {},
                ],
              ),
            ],
          );
        } else {
          appBar = CAppBar(
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
                onPressed: () async {
                  // forward the message
                  // but showContactsModal to select from

                  String participantId = (await showContactModal())!;

                  Message newMessage = Message(
                    content: sl<ChatCubit>()
                        .state
                        .messages[sl<ChatCubit>().state.index]
                        .content,
                    isDate: false,
                    isGIF: false,
                    id: -1,
                    sender: myId,
                    time: DateFormat('HH:mm').format(DateTime.now()).toString(),
                    isReply: false,
                    isForward: true,
                    participantId: participantId,
                    isPinned: false,
                    isDraft: false,
                  );

                  sl<ChatCubit>().sendMessage(newMessage);
                },
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
                onPressed: () {
                  sl<ChatCubit>().editMessage(
                    sl<ChatCubit>().state.id,
                    sl<ChatCubit>().state.index,
                    sl<ChatCubit>()
                        .state
                        .messages[sl<ChatCubit>().state.index]
                        .content,
                    true,
                  );
                  // sl<ChatCubit>().replyToMessage(state.id);
                },
                icon: const Icon(Icons.push_pin),
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
          );
        }

        return state.messagesLoadedState
            ? Scaffold(
                appBar: PreferredSize(
                  preferredSize: Size.fromHeight(kToolbarHeight),
                  child: appBar,
                ),
                body: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: sl<NightModeCubit>().state
                              ? const AssetImage(
                                  'assets/images/chat_background.png')
                              : const AssetImage(
                                  'assets/images/chat_background.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        Expanded(
                          child: MessageList(
                            scrollController: _scrollController,
                          ),
                        ),
                        CinputBar(
                          showContactModal: showContactModal,
                          textInput: textInput,
                        ),
                      ],
                    ),
                    if (sl<ChatCubit>().state.pinnedIndex != null)
                      Positioned(
                        top: 0,
                        left: 0,
                        child: Container(
                          child: GestureDetector(
                            onTap: () {
                              _scrollToIndex(
                                  sl<ChatCubit>().state.pinnedIndex!);
                            },
                            child: Container(
                              height: 30,
                              width: 300,
                              decoration: BoxDecoration(
                                color: AppColors.whiteColor,
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.push_pin),
                                  Text(
                                    sl<ChatCubit>()
                                        .state
                                        .messages[
                                            sl<ChatCubit>().state.pinnedIndex!]
                                        .content,
                                    style: TextStyle(
                                      color: AppColors.blackColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              )
            : const LogoLoader();
      },
    );
  }
}
