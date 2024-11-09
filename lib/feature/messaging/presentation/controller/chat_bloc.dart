import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:telegram/core/di/service_locator.dart';
import 'package:telegram/core/network/api/api_service.dart';
import 'package:telegram/core/utililes/app_strings/app_strings.dart';
import 'package:telegram/feature/messaging/data/model/message.dart';
import 'package:telegram/feature/messaging/presentation/controller/chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());

  // Update the current page index
  Future<dynamic> getMessages() async {
    Dio dio = sl<Dio>();

    List<Message> messages = [];

    try {
      // emit(const ChatLoading());
      var apiService = sl<ApiService>();
      final res = await apiService.get(endPoint: '/messages', token: "");

      print(jsonDecode(res.data));

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