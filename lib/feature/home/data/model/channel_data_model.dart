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

  factory ChannelDataModel.fromJson(Map<String, dynamic> json) {
    return ChannelDataModel(
      partisipantId: json['id'],
      id: json['channel']['id'],
      name: json['channel']['name'],
      privacy: json['channel']['privacy'] ?? false,
      creatorId: json['channel']['creatorId'],
      imageUrl: json['channel']['imageURL'] ?? "",
      active: json['channel']['active'],
      communityId: json['channel']['communityId'],
      canAddComments: json['channel']['canAddComments'],
      invitationLink: json['channel']['invitationLink'],
      messagesCount: json['messagesCount'],
      lastMessage: json['lastMessage'] != null
          ? LastMessage.fromJson(json['lastMessage'])
          : null,
    );
  }
  
  @override
  // TODO: implement props
  List<Object?> get props =>  [
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
}
