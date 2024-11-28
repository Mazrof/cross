import 'package:equatable/equatable.dart';
import 'package:telegram/core/utililes/app_enum/app_enum.dart';

class Chat extends Equatable {
  final int id;
  final String name;
  final String imageUrl;
  final String lastMessage;
  final String sender;
  final MessageStatus messageStatus;
  final String time;

  Chat({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.lastMessage,
    required this.sender,
    required this.messageStatus,
    required this.time,
  });

  @override
  List<Object?> get props =>
      [id, name, imageUrl, lastMessage, sender, messageStatus, time];
}
