import 'package:equatable/equatable.dart';
import 'package:telegram/feature/home/data/model/last_message_model.dart';

class ChannelDataModel extends Equatable {
  final int id;
  final String name;
  final bool privacy;
  final int creatorId;
  final String? imageUrl;
  final bool active;
  final int communityId;
  final bool canAddComments;
  final String invitationLink;
  final int messagesCount;
  final LastMessage? lastMessage;
  final partisipantId;

  ChannelDataModel({
    required this.id,
    required this.name,
    required this.privacy,
    required this.creatorId,
    this.imageUrl,
    required this.active,
    required this.communityId,
    required this.canAddComments,
    required this.invitationLink,
    required this.messagesCount,
    this.lastMessage,
    this.partisipantId,
  });

  // factory ChannelDataModel.fromJson(Map<String, dynamic> json) {
  //   return ChannelDataModel(
  //     partisipantId: json['id'],
  //     id: json['channel']['id'],
  //     name: json['channel']['name'],
  //     privacy: json['channel']['privacy'] ?? false,
  //     creatorId: json['channel']['creatorId'],
  //     imageUrl: json['channel']['imageURL'] ?? "",
  //     active: json['channel']['active'],
  //     communityId: json['channel']['communityId'],
  //     canAddComments: json['channel']['canAddComments'],
  //     invitationLink: json['channel']['invitationLink'],
  //     messagesCount: json['messagesCount'],
  //     lastMessage: json['lastMessage'] != null
  //         ? LastMessage.fromJson(json['lastMessage'])
  //         : null,
  //   );
  // }

  factory ChannelDataModel.fromJson(Map<String, dynamic> json) {
    print('Parsing ChannelDataModel from: $json');

    if (json['channel'] != null && json['channel'] is Map) {
      // When 'channel' exists and is a Map, parse it.
      final channel = Map<String, dynamic>.from(json['channel']);
      return ChannelDataModel(
        partisipantId: json['id'],
        id: channel['id'],
        name: channel['name'],
        privacy: channel['privacy'] ?? false,
        creatorId: channel['creatorId'],
        imageUrl: channel['imageURL'] ?? "",
        active: channel['active'],
        communityId: channel['communityId'],
        canAddComments: channel['canAddComments'],
        invitationLink: channel['invitationLink'],
        messagesCount: json['messagesCount'],
        lastMessage: json['lastMessage'] != null
            ? LastMessage.fromJson(
                Map<String, dynamic>.from(json['lastMessage']))
            : null,
      );
    } else if (json['channel'] == null) {
      // When 'channel' is missing, assume flat structure.
      return ChannelDataModel(
        partisipantId: json['id'],
        id: json['id'],
        name: json['name'],
        privacy: json['privacy'] ?? false,
        creatorId: json['creatorId'],
        imageUrl: json['imageURL'] ?? "",
        active: json['active'],
        communityId: json['communityId'],
        canAddComments: json['canAddComments'],
        invitationLink: json['invitationLink'],
        messagesCount: json['messagesCount'],
        lastMessage: json['lastMessage'] != null
            ? LastMessage.fromJson(
                Map<String, dynamic>.from(json['lastMessage']))
            : null,
      );
    } else {
      throw FormatException(
          "Invalid JSON: 'channel' field is missing or not a Map.");
    }
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        name,
        privacy,
        creatorId,
        imageUrl,
        active,
        communityId,
        canAddComments,
        invitationLink,
        messagesCount,
        lastMessage,
        partisipantId,
      ];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'privacy': privacy,
      'creatorId': creatorId,
      'imageUrl': imageUrl,
      'active': active,
      'communityId': communityId,
      'canAddComments': canAddComments,
      'invitationLink': invitationLink,
      'messagesCount': messagesCount,
      'lastMessage': lastMessage?.toJson(),
      'partisipantId': partisipantId,
    };
}
}
