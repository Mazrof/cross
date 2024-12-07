import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:telegram/core/di/service_locator.dart';
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
  }

  void editMessage(int id, int index, String newContent) {
    print("Edit Message");

    state.messages[index].content = newContent;

    var updatedMessages = state.messages;

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

    // sl<SocketService>().socket.emit(
    //   "message:edit",
    //   {
    //     "id": id,
    //     "content": "Hello",
    //   },
    // );
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
    String message,
    String senderId,
    String receiverId,
    bool isGIF,
  ) {
    // TODO
    // Generate a unique id for each message
    // Send it to the backend

    print(message);

    sl<SocketService>().socket!.emit(
      "message:sent",
      {
        "content": message,
        "status": "pinned", //or null
        "durationInMinutes": null, // can be null
        "isAnnouncement": true, // for group announcement
        "isForward": false,
        "participantId": 42,
        "senderId": int.parse(senderId) // Will be deleted after mirging auth,
      },
    );

    // final currentState = state as TypingMessage;
    final updatedMessages = List<Message>.from(state.messages)
      ..add(
        Message(
          isGIF: isGIF,
          isDate: false,
          sender: "01",
          content: message,
          time: "00:00",
          // Assign front-end id
          id: 0,
        ),
      );
    emit(state.copyWith(messages: updatedMessages, messagesLoadedState: true));
  }

  void deleteMessage(int id, int index) {
    print(id);

    // sl<SocketService>().socket.emit(
    //   "message:delete",
    //   {"id": id},
    // );

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

    // final updatedMessages = List<Message>.from(state.messages);

    // updatedMessages[updatedMessages.length - 1].setId();

    // print(updatedMessages[updatedMessages.length - 1]);

    final updatedMessages = List<Message>.from(state.messages)
      ..add(
        Message(
          id: message["id"],
          isDate: false,
          sender: "01",
          content: message["content"],
          time: message["createdAt"],
          isGIF: false,
        ),
      );
    emit(state.copyWith(messages: updatedMessages, receivedState: true));
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
