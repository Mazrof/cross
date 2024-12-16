import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:telegram/core/di/service_locator.dart';
import 'package:telegram/core/local/hive.dart';
import 'package:telegram/core/network/api/api_service.dart';
import 'package:telegram/core/network/socket/socket_service.dart';
import 'package:telegram/core/utililes/app_enum/app_enum.dart';
import 'package:telegram/feature/home/data/model/chat_model.dart';
import 'package:telegram/feature/home/presentation/controller/home/home_cubit.dart';
import 'package:telegram/feature/messaging/data/model/message.dart';
import 'package:telegram/feature/messaging/presentation/controller/chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit()
      : super(
          ChatState(
            messages: [],
            messagesLoadedState: false,
            selectionState: false,
            typingState: false,
            index: -1,
            editingState: false,
            error: false,
            errorMessage: "",
            id: -1,
            receivedState: false,
            xCoordiate: -1,
            yCoordiate: -1,
            height: -1,
            width: -1,
            replyState: false,
            // chatType: ChatType.PersonalChat,
            // members: [],
            // chatType: ChatType.PersonalChat,
            // participantId: -1,
          ),
        );

  @override
  void emit(ChatState state) {
    // Always emit the state without comparing
    super.emit(state);
  }

  void init({
    required int chatIndex,
    required ChatType chatType,
  }) {
    super.state.chatType = chatType;
    super.state.chatIndex = chatIndex;
  }

  Future<void> startSocket() async {
    // Start the socket connection
    SocketService socketService = sl<SocketService>();

    socketService.connect();
  }

  void notTyping() {
    emit(state.copyWith(typingState: false));
  }

  void editingMessage(int index, int id) {
    print("Editing Message");

    emit(state.copyWith(
      editingState: true,
    ));

    print("test");
  }

  void replyingToMessage() {
    emit(state.copyWith(replyState: true));
  }

  void editMessage(int id, int index, String newContent) {
    print("Edit Message");

    state.messages[index].content = newContent;

    var updatedMessages = state.messages;

    sl<SocketService>().socket!.emit(
      "message:edit",
      {
        "id": id,
        "content": newContent,
      },
    );

    emit(state.copyWith(
      editingState: false,
      selectionState: false,
      index: -1,
      id: -1,
      height: -1,
      width: -1,
      xCoordiate: -1,
      yCoordiate: -1,
    ));

    // TODO
    // Uncomment when available
  }

  void messageEdited(dynamic data) {
    print(data);

    // if senderId == myId -> do nothing else update by Id

    int myId = HiveCash.read(boxName: "register_info", key: 'id');

    if (myId != data['senderId']) {
      var updatedMessages = state.messages
          .map(
            (item) => Message(
              content: item.content,
              id: item.id,
              isDate: item.isDate,
              isGIF: item.isGIF,
              sender: item.sender,
              time: item.time,
              isReply: item.isReply,
              isForward: item.isForward,
              participantId: item.participantId,
            ),
          )
          .toList();

      for (int i = 0; i < updatedMessages.length; i++) {
        if (updatedMessages[i].id == data['id']) {
          // edit the message
          updatedMessages[i].content = data['content'];
          break;
        }
      }

      emit(state.copyWith(
          messages: updatedMessages, editingState: false, error: true));
    }
  }

  void messageDeleted(data) {
    print(data);

    // if senderId == myId -> do nothing else update by Id

    int myId = HiveCash.read(boxName: "register_info", key: 'id');

    if (myId != data['senderId']) {
      var updatedMessages = state.messages
          .map(
            (item) => Message(
              content: item.content,
              id: item.id,
              isDate: item.isDate,
              isGIF: item.isGIF,
              sender: item.sender,
              time: item.time,
              isReply: item.isReply,
              isForward: item.isForward,
              participantId: item.participantId,
            ),
          )
          .toList();

      for (int i = 0; i < updatedMessages.length; i++) {
        if (updatedMessages[i].id == data['message']['id']) {
          // edit the message
          updatedMessages.removeAt(i);
          break;
        }
      }

      emit(state.copyWith(messages: updatedMessages));
    }
  }

  void defaultState() {
    emit(state.copyWith());
  }

  void messageSelected(
      int index, double dx, double dy, double width, double height, int id) {
    emit(
      state.copyWith(
        selectionState: true,
        index: index,
        xCoordiate: dx,
        yCoordiate: dy,
        width: width,
        height: height,
        id: id,
      ),
    );
  }

  void unselectMessage() {
    emit(
      state.copyWith(
        selectionState: false,
        index: -1,
        xCoordiate: -1,
        yCoordiate: -1,
        width: -1,
        height: -1,
        id: -1,
      ),
    );
  }

  void sendMessage(
    Message newMessage,
  ) {
    // TODO
    // Generate a unique id for each message
    // Send it to the backend

    print(newMessage.toString());

    sl<SocketService>().socket!.emit(
      "message:sent",
      {
        "content": newMessage.content,
        "status": "pinned", //or null
        "durationInMinutes": null, // can be null
        "isAnnouncement": true, // for group announcement
        "isForward": newMessage.isForward,
        "participantId": int.parse(newMessage.participantId),
        "senderId":
            int.parse(newMessage.sender) // Will be deleted after mirging auth,
      },
    );

    // final currentState = state as TypingMessage;

    if (!newMessage.isForward) {
      final updatedMessages = List<Message>.from(state.messages);
      updatedMessages.add(
        newMessage,
      );
      emit(
          state.copyWith(messages: updatedMessages, messagesLoadedState: true));
    } else {
      unselectMessage();
    }
  }

  void replyToMessage(Message replyMessage) {
    sl<SocketService>().socket!.emit(
      "message:sent",
      {
        "content": replyMessage.content,
        "status": "pinned", //or null
        "durationInMinutes": null, // can be null
        "isAnnouncement": true, // for group announcement
        "isForward": false,
        "participantId": 42,
        "senderId": int.parse(replyMessage.sender),
        "replyTo": sl<ChatCubit>().state.id,
      },
    );

    // final currentState = state as TypingMessage;
    final updatedMessages = List<Message>.from(state.messages);

    String replyMessageText = "";

    // if reply get the text of the message being replied to
    for (int i = 0; i < updatedMessages.length; i++) {
      if (updatedMessages[i].id == state.id) {
        replyMessageText = updatedMessages[i].content;
        break;
      }
    }

    replyMessage.replyMessage = replyMessageText;

    updatedMessages.add(replyMessage);

    emit(state.copyWith(
      messages: updatedMessages,
      messagesLoadedState: true,
      id: -1,
      index: -1,
      replyState: false,
      selectionState: false,
    ));
  }

  void deleteMessage(int id, int index) {
    print(id);

    sl<SocketService>().socket!.emit(
      "message:delete",
      {"id": id},
    );

    final updatedMessages = state.messages;

    updatedMessages.removeAt(index);

    emit(state.copyWith(
      messages: updatedMessages,
      messagesLoadedState: true,
      selectionState: false,
      index: -1,
      id: -1,
      height: -1,
      width: -1,
      xCoordiate: -1,
      yCoordiate: -1,
    ));
  }

  void typingMessage() {
    emit(state.copyWith(typingState: true));
  }

  void receiveMessage(dynamic message) {
    print(message);

    // TODO
    // userId == my id -> update id with backend id - else - add to messages list

    var updatedMessages = List<Message>.from(state.messages);

    // print(updatedMessages[updatedMessages.length - 1]);

    int myId = HiveCash.read(boxName: "register_info", key: 'id');

    if (myId == message["senderId"]) {
      updatedMessages[updatedMessages.length - 1].setId(message["id"]);
    } else {
      final DateTime dateTime = DateTime.parse(message["createdAt"]);
      final DateFormat formatter = DateFormat('HH:mm');

      print(message['replyTo']);

      updatedMessages = List<Message>.from(state.messages);
      String replyMessage = "";

      if (message['replyTo'].toString() != 'null') {
        // if reply get the text of the message being replied to
        for (int i = 0; i < updatedMessages.length; i++) {
          if (updatedMessages[i].id == message['replyTo']) {
            replyMessage = updatedMessages[i].content;
            break;
          }
        }
      }

      updatedMessages.add(
        Message(
          id: message["id"],
          isDate: false,
          sender: message['senderId'].toString(),
          content: message["content"],
          time: formatter.format(dateTime),
          isGIF: false,
          isReply: message['replyTo'].toString() != 'null',
          replyMessage: replyMessage,
          isForward: message['isForward'],
          participantId: (message['participantId']).toString(),
        ),
      );
    }
    emit(state.copyWith(messages: updatedMessages, receivedState: true));
    print("test");
  }

  // Get the prev Messages
  Future<dynamic> getMessages() async {
    List<Message> messages = [];

    final chat =
        sl<HomeCubit>().state.contacts[sl<ChatCubit>().state.chatIndex!];

    try {
      // emit(const ChatLoading());
      var apiService = sl<ApiService>();
      final res = await apiService.get(
        endPoint: 'chats/${chat.id.toString()}',
      );

      print(res.data[0]['replyTo']);

      List data = res.data;

      messages = (data.map(
        (e) => Message(
          isGIF: false,
          isDate: false,
          sender: (e['senderId']).toString(),
          content: e['content'],
          time: DateFormat('HH:mm').format(DateTime.parse(e['createdAt'])),
          id: e["id"],
          isReply: e['replyTo'] != null,
          isForward: e['isForward'],
          participantId: (e["participantId"]).toString(),
        ),
      )).toList();

      emit(state.copyWith(messages: messages, messagesLoadedState: true));
      return res;
    } catch (e) {
      print(e);
      emit(
          state.copyWith(error: true, errorMessage: "Failed to load messages"));
    }
  }
}
