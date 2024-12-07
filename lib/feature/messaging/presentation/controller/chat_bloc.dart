import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:telegram/core/di/service_locator.dart';
import 'package:telegram/core/local/hive.dart';
import 'package:telegram/core/network/api/api_service.dart';
import 'package:telegram/core/network/socket/socket_service.dart';
import 'package:telegram/feature/messaging/data/model/message.dart';
import 'package:telegram/feature/messaging/presentation/controller/chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit()
      : super(ChatState(
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
        ));

  Future<void> startSocket() async {
    // Start the socket connection
    SocketService socketService = sl<SocketService>();

    socketService.connect();
  }

  void editingMessage(int index, int id) {
    print("Editing Message");

    emit(state.copyWith(
      editingState: true,
    ));

    print("test");
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
      var updatedMesssages = List<Message>.from(state.messages);
      for (int i = 0; i < updatedMesssages.length; i++) {
        if (updatedMesssages[i].id == data['id']) {
          // edit the message
          updatedMesssages[i].content = data['content'];
          break;
        }
      }

      if (sl<ChatCubit>().isClosed) print("Closed");

      emit(state.copyWith(messages: updatedMesssages));
      print("test");
    }
  }

  void messageDeleted(data) {
    print(data);

    // if senderId == myId -> do nothing else update by Id

    int myId = HiveCash.read(boxName: "register_info", key: 'id');

    if (myId != data['senderId']) {
      var updatedMesssages = List<Message>.from(state.messages);
      for (int i = 0; i < updatedMesssages.length; i++) {
        if (updatedMesssages[i].id == data['id']) {
          // edit the message
          updatedMesssages.removeAt(i);
          break;
        }
      }

      if (sl<ChatCubit>().isClosed) print("Closed");

      emit(state.copyWith(messages: updatedMesssages));
      print("test");
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
        "isForward": false,
        "participantId": 42,
        "senderId":
            int.parse(newMessage.sender) // Will be deleted after mirging auth,
      },
    );

    // final currentState = state as TypingMessage;
    final updatedMessages = List<Message>.from(state.messages)
      ..add(
        newMessage,
      );
    emit(state.copyWith(messages: updatedMessages, messagesLoadedState: true));
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

      updatedMessages = List<Message>.from(state.messages)
        ..add(
          Message(
            id: message["id"],
            isDate: false,
            sender: message['senderId'].toString(),
            content: message["content"],
            time: formatter.format(dateTime),
            isGIF: false,
          ),
        );
    }
    emit(state.copyWith(messages: updatedMessages, receivedState: true));
    print("test");
  }

  // Get the prev Messages
  Future<dynamic> getMessages() async {
    Dio dio = sl<Dio>();

    List<Message> messages = [];

    try {
      // emit(const ChatLoading());
      var apiService = sl<ApiService>();
      final res = await apiService.get(
        endPoint: '/messages',
      );

      messages = (jsonDecode(res.data) as List)
          .map(
            (e) => Message(
              isGIF: false,
              isDate: false,
              sender: e['senderId'],
              content: e['content'],
              time: e['timestamp'],
              id: 0,
            ),
          )
          .toList();

      emit(state.copyWith(messages: messages, messagesLoadedState: true));
      return res;
    } catch (e) {
      print(e);
      emit(
          state.copyWith(error: true, errorMessage: "Failed to load messages"));
    }
  }
}
