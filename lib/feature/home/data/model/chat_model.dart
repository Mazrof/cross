import 'package:equatable/equatable.dart';
import 'package:telegram/feature/home/data/model/last_message_model.dart';

class ChatModel extends Equatable {
  final int id;

  final String type;
  final LastMessage? lastMessage;
  final int messagesCount;
  final SecondUser secondUser;

  ChatModel({
    required this.id,
    required this.type,
    this.lastMessage,
    required this.messagesCount,
    required this.secondUser,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      id: json['id'],
      type: json['type'],
      lastMessage: json['lastMessage'] != null
          ? LastMessage.fromJson(json['lastMessage'])
          : null,
      messagesCount: json['messagesCount'],
      secondUser: SecondUser.fromJson(json['secondUser']),
    );
  }

  @override
  List<Object?> get props => [id, type, lastMessage, messagesCount, secondUser];
}

class SecondUser extends Equatable {
  final int id;
  final String username;
  final String? photo;
  final String? screenName;
  final String phone;
  final String publicKey;
  final DateTime? lastSeen;
  final bool activeNow;

  SecondUser({
    required this.id,
    required this.username,
    this.photo,
    this.screenName,
    required this.phone,
    required this.publicKey,
    this.lastSeen,
    required this.activeNow,
  });

  factory SecondUser.fromJson(Map<String, dynamic> json) {
    return SecondUser(
      id: json['id'],
      username: json['username'],
      photo: json['photo'],
      screenName: json['screenName'],
      phone: json['phone'],
      publicKey: json['publicKey'],
      lastSeen:
          json['lastSeen'] != null ? DateTime.parse(json['lastSeen']) : null,
      activeNow: json['activeNow'],

    );
  }

  @override
  List<Object?> get props =>
      [id, username, photo, screenName, phone, publicKey, lastSeen, activeNow];
}
