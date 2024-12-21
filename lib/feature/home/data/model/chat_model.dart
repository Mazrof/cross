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
    print('Parsing ChatModel from: $json');

    if (json['secondUser'] != null && json['secondUser'] is Map) {
      // When 'secondUser' exists and is a Map, parse it.
      final secondUser = Map<String, dynamic>.from(json['secondUser']);
      return ChatModel(
        id: json['id'],
        type: json['type'],
        lastMessage: json['lastMessage'] != null
            ? LastMessage.fromJson(
                Map<String, dynamic>.from(json['lastMessage']))
            : null,
        messagesCount: json['messagesCount'],
        secondUser: SecondUser.fromJson(secondUser),
      );
    } else if (json['secondUser'] == null) {
      // When 'secondUser' is missing, assume flat structure.
      return ChatModel(
        id: json['id'],
        type: json['type'],
        lastMessage: json['lastMessage'] != null
            ? LastMessage.fromJson(
                Map<String, dynamic>.from(json['lastMessage']))
            : null,
        messagesCount: json['messagesCount'],
        secondUser: SecondUser.fromJson(json),
      );
    } else {
      throw FormatException(
          "Invalid JSON: 'secondUser' field is missing or not a Map.");
    }
  }

  //to json
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'lastMessage': lastMessage?.toJson(),
      'messagesCount': messagesCount,
      'secondUser': secondUser.toJson(),
    };
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
  //to json
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'photo': photo,
      'screenName': screenName,
      'phone': phone,
      'publicKey': publicKey,
      'lastSeen': lastSeen?.toIso8601String(),
      'activeNow': activeNow,
    };
  }

  @override
  List<Object?> get props =>
      [id, username, photo, screenName, phone, publicKey, lastSeen, activeNow];

  //to json
}
