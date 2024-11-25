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
  final double xCoordiate;
  final double yCoordiate;
  final double width;
  final double height;

  MessageSelected({
    required this.xCoordiate,
    required this.yCoordiate,
    required this.messages,
    required this.index,
    required this.width,
    required this.height,
  });

  @override
  List<Message> get getMessages => messages;
}

class TypingMessage extends ChatState {
  final List<Message> messages;

  TypingMessage({required this.messages});

  @override
  List<Message> get getMessages => messages;
}

class EditingMessage extends ChatState {
  final List<Message> messages;
  final int index;

  EditingMessage({required this.messages, required this.index});

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
