import 'package:equatable/equatable.dart';
import 'package:telegram/feature/messaging/data/model/message.dart';

abstract class ChatState {
  List<Message> get getMessages;
}

class ChatInitial extends ChatState {
  @override
  List<Message> get getMessages => [];
}

class ChatLoading extends ChatState {
  @override
  List<Message> get getMessages => [];
}

class ChatLoaded extends ChatState {
  final List<Message> messages;

  ChatLoaded({required this.messages});
  @override
  List<Message> get getMessages => messages;

  // @override
  // List<Object> get props => [messages];
}

class MessageSelected extends ChatState {
  final List<Message> messages;
  final int index;

  MessageSelected({required this.messages, required this.index});

  @override
  List<Message> get getMessages => messages;
}

// class SendMessage extends ChatState {
//   final Message message;

//   SendMessage({required this.message});
// }

class ChatError extends ChatState {
  final String message;

  ChatError({required this.message});

  @override
  List<Message> get getMessages => [];
}
