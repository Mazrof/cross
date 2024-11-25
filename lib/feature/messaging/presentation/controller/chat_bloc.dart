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

  // Start the socket connection

  Future<void> startSocket() async {
    SocketService socketService = sl<SocketService>();

    socketService.connect();
  }

  void editMessage(int index) {
    print("Editing Message");
    emit(EditingMessage(messages: (state).getMessages, index: index));
  }

  void defaultState() {
    emit(ChatLoaded(messages: (state).getMessages));
  }

  void messageSelected(
      int index, double dx, double dy, double width, double height) {
    emit(
      MessageSelected(
        messages: (state).getMessages,
        index: index,
        xCoordiate: dx,
        yCoordiate: dy,
        width: width,
        height: height,
      ),
    );
  }

  void sendMessage(String message) {
    if (state is ChatLoaded) {
      print(message);

      sl<SocketService>().socket.emit(
        "message:sent",
        {
          "content": message,
          "status": "pinned", //or null
          "durationInMinutes": 10, // can be null
          "isAnnouncement": true, // for group announcement
          "isForward": false,
          "participantId":
              1, // id of the place where the message gonna be send or null if you will provide reciever id for new personl chats
          // "replyTo":12,// or null (the message id to which this message reply for)
          "senderId": 2 // Will be deleted after mirging auth,
          // "receiverId":2// if you provide a receiver id this means I will create new personal chat
          // "messageMentions":[
          //     1,//ids of the users mentioned
          //     2
          // ]
        },
      );

      final currentState = state as ChatLoaded;
      final updatedMessages = List<Message>.from(currentState.messages)
        ..add(
          Message(isDate: false, sender: "01", content: message, time: "00:00"),
        );
      emit(ChatLoaded(messages: updatedMessages));
    }
  }

  void typingMessage() {
    emit(TypingMessage(messages: state.getMessages));
  }

  void receiveMessage(dynamic message) {
    if (state is ChatLoaded) {
      // message = jsonDecode(message);

      final currentState = state as ChatLoaded;
      final updatedMessages = List<Message>.from(currentState.messages)
        ..add(
          Message(
            isDate: false,
            sender: "01",
            content: message["content"],
            time: message["createdAt"],
          ),
        );
      emit(ChatLoaded(messages: updatedMessages));
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

      // print(jsonDecode(res.data));

      messages = (jsonDecode(res.data) as List)
          .map(
            (e) => Message(
                isDate: false,
                sender: e['senderId'],
                content: e['content'],
                time: e['timestamp']),
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



// OnBordingState(
//           currentPage: 0,
//           controller: PageController(),
//           onBordingcontents: [
//             OnboardingContents(
//               title: "Welcome to Mazrof",
//               image: AppAssetsStrings.on_bording1,
//               desc:
//                   "Connect with friends and family instantly, no matter where they are.",
//               count: "1/4",
//             ),
//             OnboardingContents(
//               title: "Seamless Communication",
//               image: AppAssetsStrings.on_bording2,
//               desc:
//                   " Enjoy high-quality voice and video calls with just a tap.",
//               count: "2/4",
//             ),
//             OnboardingContents(
//               title: "Share Moments",
//               image: AppAssetsStrings.on_bording3,
//               desc:
//                   "Send photos, videos, and files effortlessly to keep everyone in the loop.",
//               count: "3/4",
//             ),
//             OnboardingContents(
//               title: "One Chat, Endless Possibilities",
//               image: AppAssetsStrings.on_bording4,
//               desc:
//                   "Dive into a world of endless conversations and connections.",
//               count: "4/4",
//             ),
//           ],
//         )