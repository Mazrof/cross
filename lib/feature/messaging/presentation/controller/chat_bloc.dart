import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:telegram/core/di/service_locator.dart';
import 'package:telegram/core/network/api/api_service.dart';
import 'package:telegram/core/network/socket/socket_service.dart';
import 'package:telegram/feature/messaging/data/model/message.dart';
import 'package:telegram/feature/messaging/presentation/controller/chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());

  Future<void> startSocket() async {
    // Start the socket connection
    SocketService socketService = sl<SocketService>();

    socketService.connect();
  }

  void editingMessage(int index, int id) {
    print("Editing Message");
    emit(EditingMessage(messages: (state).getMessages, index: index, id: id));
  }

  void editMessage(int id, String newContent) {
    print("Edit Message");

    sl<SocketService>().socket.emit(
      "message:edit",
      {
        "id": id,
        "content": "Hello",
      },
    );
  }

  void defaultState() {
    emit(ChatLoaded(messages: (state).getMessages));
  }

  void messageSelected(
      int index, double dx, double dy, double width, double height, int id) {
    emit(
      MessageSelected(
        messages: (state).getMessages,
        index: index,
        xCoordiate: dx,
        yCoordiate: dy,
        width: width,
        height: height,
        id: id,
      ),
    );
  }

  void sendMessage(String message) {
    // TODO
    // Generate a unique id for each message
    // Send it to the backend

    print(message);

    sl<SocketService>().socket.emit(
      "message:sent",
      {
        "content": "after @abdo @mohamed",
        "status": "pinned", //or null
        "durationInMinutes": null, // can be null
        "isAnnouncement": true, // for group announcement
        "isForward": false,
        "participantId": 61,
        "senderId": 2 // Will be deleted after mirging auth,
      },
    );

    final currentState = state as TypingMessage;
    final updatedMessages = List<Message>.from(currentState.messages)
      ..add(
        Message(
          isDate: false,
          sender: "01",
          content: message,
          time: "00:00",
          // Assign front-end id
          id: 0,
        ),
      );
    emit(ChatLoaded(messages: updatedMessages));
  }

  void typingMessage() {
    emit(TypingMessage(messages: state.getMessages));
  }

  void receiveMessage(dynamic message) {
    if (state is ChatLoaded) {
      print(message);

      // TODO
      // userId == my id -> update id with backend id - else - add to messages list

      final currentState = state as ChatLoaded;

      final messages = List<Message>.from(currentState.messages);

      messages[messages.length - 1].setId(message["id"]);

      print(messages[messages.length - 1]);

      // final updatedMessages = List<Message>.from(currentState.messages)
      //   ..add(
      //     Message(
      //       isDate: false,
      //       sender: "01",
      //       content: message["content"],
      //       time: message["createdAt"],
      //     ),
      //   );
      emit(ChatLoaded(messages: messages));
    }
  }

  // Get the prev Messages
  Future<dynamic> getMessages() async {
    Dio dio = sl<Dio>();

    List<Message> messages = [];

    try {
      // emit(const ChatLoading());
      var apiService = sl<ApiService>();
      final res = await apiService.get(endPoint: '/messages', token: "");

      messages = (jsonDecode(res.data) as List)
          .map(
            (e) => Message(
              isDate: false,
              sender: e['senderId'],
              content: e['content'],
              time: e['timestamp'],
              id: 0,
            ),
          )
          .toList();

      emit(ChatLoaded(messages: messages));
      return res;
    } catch (e) {
      print(e);
      emit(ChatError(message: 'Failed to fetch messages'));
    }
  }
}
