import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:telegram/core/di/service_locator.dart';
import 'package:telegram/core/utililes/app_strings/app_strings.dart';
import 'package:telegram/feature/messaging/data/model/message.dart';
import 'package:telegram/feature/messaging/presentation/controller/chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit()
      : super(
          ChatState(
            messages: [
              Message(
                content: "Hello",
                sender: "Kiro",
                time: "12",
                isDate: false,
              )
            ],
          ),
        );

  // Update the current page index
  Future<dynamic> getMessages() async {
    Dio dio = sl<Dio>();

    List<Message> response = [];

    try {
      // emit(const ChatLoading());
      // final response = await dio.get('${AppStrings.serverUrl}/messages');

      print(response);

      // emit(ChatLoaded(['Message 1', 'Message 2', 'Message 3']));
    } catch (e) {
      print(e);
      // emit(ChatError('Failed to fetch messages'));
    }

    return response;
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