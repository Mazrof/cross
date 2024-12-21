import 'package:equatable/equatable.dart';
import 'package:telegram/core/utililes/app_enum/app_enum.dart';
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
  final bool replyState;
  final bool error;
  final String errorMessage;
  final bool isMuted;
  final String text;
  final int destructDuration;
  // final String? draftedMessage;
  int? pinnedIndex;
  int? chatIndex;
  ChatType? chatType;
  // int participantId;
  // List members; // Contains the list of users

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
    required this.replyState,
    required this.error,
    required this.errorMessage,
    required this.isMuted,
    required this.text,
    required this.destructDuration,
    // this.draftedMessage,
    this.pinnedIndex,
    this.chatIndex,
    this.chatType,
    // required this.chatType,
    // required this.participantId,
    // required this.members,
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
    bool? replyState,
    ChatType? chatType,
    int? chatIndex,
    bool? isMuted,
    int? pinnedIndex,
    String? text,
    int? destructDuration,
    // String? draftedMessage,
    // int? participantId,
    // List? members,
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
      replyState: replyState ?? this.replyState,
      chatType: chatType ?? this.chatType,
      chatIndex: chatIndex ?? this.chatIndex,
      isMuted: isMuted ?? this.isMuted,
      pinnedIndex: pinnedIndex ?? this.pinnedIndex,
      text: text ?? this.text,
      destructDuration: destructDuration ?? this.destructDuration,
      // draftedMessage: draftedMessage ?? this.draftedMessage,
      // participantId: participantId ?? this.participantId,
      // chatType: chatType ?? this.chatType,
      // members: members ?? this.members,
    );
  }

  @override
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
        replyState,
        chatType,
        chatIndex,
        pinnedIndex,
        text,
        destructDuration,
        // draftedMessage,
        // participantId,
        // members,
      ];
}
