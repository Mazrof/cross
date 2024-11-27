import 'package:telegram/feature/home/domain/entity/chat.dart';
import 'package:telegram/core/utililes/app_enum/app_enum.dart';

class ChatModel extends Chat {
  ChatModel({
    required int id,
    required String name,
    required String imageUrl,
    required String lastMessage,
    required String sender,
    required MessageStatus messageStatus,
    required String time,
  }) : super(
          id: id,
          name: name,
          imageUrl: imageUrl,
          lastMessage: lastMessage,
          sender: sender,
          messageStatus: messageStatus,
          time: time,
        );

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      id: json['id'],
      name: json['name'],
      imageUrl: json['imageUrl'],
      lastMessage: json['lastMessage'],
      sender: json['sender'],
      messageStatus: MessageStatus.values[json['messageStatus']],
      time: json['time'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'lastMessage': lastMessage,
      'sender': sender,
      'messageStatus': messageStatus.index,
      'time': time,
    };
  }
}
