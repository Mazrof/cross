import 'package:flutter/material.dart';

class ChatModel {
  final String chatId;
  final List<Participant> participants;
  final LastMessage lastMessage;
  final String cursor;

  ChatModel({
    required this.chatId,
    required this.participants,
    required this.lastMessage,
    required this.cursor,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      chatId: json['chatId'],
      participants: (json['participants'] as List)
          .map((participant) => Participant.fromJson(participant))
          .toList(),
      lastMessage: LastMessage.fromJson(json['lastMessage']),
      cursor: json['cursor'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'chatId': chatId,
      'participants':
          participants.map((participant) => participant.toJson()).toList(),
      'lastMessage': lastMessage.toJson(),
      'cursor': cursor,
    };
  }
}

class Participant {
  final String userId;
  final String name;
  final String lastSeen;
  final String publicKey;
  final String imageUrl;
  final String phone;

  Participant({
    required this.userId,
    required this.name,
    required this.lastSeen,
    required this.publicKey,
    required this.imageUrl,
    required this.phone,
  });

  // to be changed
  factory Participant.fromJson(Map<String, dynamic> json) {
    return Participant(
      userId: json['userId'],
      name: json['name'],
      lastSeen: json['lastSeen'],
      publicKey: '',
      imageUrl: '',
      phone: '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'name': name,
      'lastSeen': lastSeen,
    };
  }
}

class LastMessage {
  final String messageId;
  final String content;
  final String timestamp;

  LastMessage({
    required this.messageId,
    required this.content,
    required this.timestamp,
  });

  factory LastMessage.fromJson(Map<String, dynamic> json) {
    return LastMessage(
      messageId: json['messageId'],
      content: json['content'],
      timestamp: json['timestamp'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'messageId': messageId,
      'content': content,
      'timestamp': timestamp,
    };
  }
}
