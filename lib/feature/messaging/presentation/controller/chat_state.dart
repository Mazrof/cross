import 'package:equatable/equatable.dart';
import 'package:telegram/feature/messaging/data/model/message.dart';

class ChatState extends Equatable {
  @override
  List<Object> get props => [];

  final List<Message> messages;
  // final PageController controller;
  // final List<OnboardingContents> onBordingcontents;

  const ChatState({
    required this.messages,
  });

  ChatState copyWith(List<Message>? messages) {
    return ChatState(
      messages: messages ?? this.messages,
    );
  }
}

// class ChatInitial extends ChatState {
//   const ChatInitial();
// }

// class ChatLoading extends ChatState {
//   const ChatLoading();
// }

// class ChatLoaded extends ChatState {
//   final List<Message> messages;

//   const ChatLoaded({required this.messages}) : super(messages: messages);

//   @override
//   List<Object> get props => [messages];
// }

// class ChatError extends ChatState {
//   final String message;

//   ChatError({required this.message}) : super(messages: []);

//   @override
//   List<Object> get props => [message];
// }
