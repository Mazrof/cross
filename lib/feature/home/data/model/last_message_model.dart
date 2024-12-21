import 'package:equatable/equatable.dart';

class LastMessage extends Equatable {
  final int id;
  final DateTime createdAt;
  final bool isAnnouncement;
  final bool isForward;
  final DateTime updatedAt;
  final String content;
  final String? url;
  final int senderId;
  final int? replyTo;
  final int participantId;
  final int? durationInMinutes;
  final String status;

  LastMessage({
    required this.id,
    required this.createdAt,
    required this.isAnnouncement,
    required this.isForward,
    required this.updatedAt,
    required this.content,
    this.url,
    required this.senderId,
    this.replyTo,
    required this.participantId,
    this.durationInMinutes,
    required this.status,
  });

  factory LastMessage.fromJson(Map<String, dynamic> json) {
    return LastMessage(
      id: json['id'],
      createdAt: DateTime.parse(json['createdAt']),
      isAnnouncement: json['isAnnouncement'],
      isForward: json['isForward'],
      updatedAt: DateTime.parse(json['updatedAt']),
      content: json['content'],
      url: json['url'],
      senderId: json['senderId'],
      replyTo: json['replyTo'],
      participantId: json['participantId'],
      durationInMinutes: json['durationInMinutes'],
      status: json['status'],
    );
  }

  @override
  List<Object?> get props => [
        id,
        createdAt,
        isAnnouncement,
        isForward,
        updatedAt,
        content,
        url,
        senderId,
        replyTo,
        participantId,
        durationInMinutes,
        status
      ];

  //TO JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'createdAt': createdAt.toIso8601String(),
      'isAnnouncement': isAnnouncement,
      'isForward': isForward,
      'updatedAt': updatedAt.toIso8601String(),
      'content': content,
      'url': url,
      'senderId': senderId,
      'replyTo': replyTo,
      'participantId': participantId,
      'durationInMinutes': durationInMinutes,
      'status': status,
    };
  }
}
