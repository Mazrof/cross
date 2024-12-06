import 'package:equatable/equatable.dart';
import 'package:telegram/feature/messaging/data/model/message.dart';

class ChatState extends Equatable {
  final List<Message> messages;
  final int index;
  final int id;
  final double xCoordiate;
  final double yCoordiate;
  final double width;
  final double height;
  final bool selectionState;
  final bool typingState;
  final bool messagesLoadedState;
  final bool editingState;
  final bool receivedState;
  final bool error;
  final String errorMessage;

  ChatState({
    required this.messages,
    required this.index,
    required this.id,
    required this.xCoordiate,
    required this.yCoordiate,
    required this.width,
    required this.height,
    required this.selectionState,
    required this.typingState,
    required this.messagesLoadedState,
    required this.editingState,
    required this.receivedState,
    required this.error,
    required this.errorMessage,
  });

  ChatState copyWith({
    List<Message>? messages,
    int? index,
    int? id,
    double? xCoordiate,
    double? yCoordiate,
    double? width,
    double? height,
    bool? selectionState,
    bool? typingState,
    bool? messagesLoadedState,
    bool? editingState,
    bool? receivedState,
    bool? error,
    String? errorMessage,
  }) {
    return ChatState(
      messages: messages ?? this.messages,
      index: index ?? this.index,
      id: id ?? this.id,
      xCoordiate: xCoordiate ?? this.xCoordiate,
      yCoordiate: yCoordiate ?? this.yCoordiate,
      width: width ?? this.width,
      height: height ?? this.height,
      selectionState: selectionState ?? this.selectionState,
      typingState: typingState ?? this.typingState,
      messagesLoadedState: messagesLoadedState ?? this.messagesLoadedState,
      editingState: editingState ?? this.editingState,
      receivedState: receivedState ?? this.receivedState,
      error: error ?? this.error,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        messages,
        index,
        id,
        xCoordiate,
        yCoordiate,
        width,
        height,
        selectionState,
        typingState,
        messagesLoadedState,
        editingState,
        receivedState,
        error,
        errorMessage,
      ];
}
