import 'package:equatable/equatable.dart';
import 'package:telegram/feature/messaging/data/model/message.dart';

abstract class ChatState {}

class ChatInitial extends ChatState {}

// class ChatInitial extends ChatState {
//   const ChatInitial({required super.messages});
// }

class ChatLoading extends ChatState {}

class ChatLoaded extends ChatState {
  final List<Message> messages;

  ChatLoaded({required this.messages});

  // @override
  // List<Object> get props => [messages];
}

class ChatError extends ChatState {
  final String message;

  ChatError({required this.message});
}
