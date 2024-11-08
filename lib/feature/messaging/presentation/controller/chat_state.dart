import 'package:telegram/feature/messaging/data/model/message.dart';

class ChatState {
  final List<Message> messages;
  // final PageController controller;
  // final List<OnboardingContents> onBordingcontents;

  ChatState({
    required this.messages,
  });

  ChatState copyWith(List<Message>? messages) {
    return ChatState(
      messages: messages ?? this.messages,
    );
  }
}
