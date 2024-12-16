import 'package:equatable/equatable.dart';
import 'package:telegram/feature/home/data/model/last_message_model.dart';

class GroupDataModel extends Equatable {
  final int id;
  final String name;
  final bool privacy;
  final int? groupSize;
  final String? imageUrl;
  final LastMessage? lastMessage;
  final int creatorId;
  final bool active;
  final int communityId;
  final String invitationLink;
  final int messagesCount;
  final partisipantId;

  GroupDataModel({
    required this.id,
    required this.name,
    required this.privacy,
    this.groupSize,
    this.imageUrl,
    this.lastMessage,
    required this.creatorId,
    required this.active,
    required this.communityId,
    required this.invitationLink,
    required this.messagesCount,
    this.partisipantId,
  });

  factory GroupDataModel.fromJson(Map<String, dynamic> json) {
    print('Parsing GroupDataModel from: $json');
    return GroupDataModel(
      partisipantId: json['id'],
      id: json['group']['id'],
      name: json['group']['name'],
      privacy: json['group']['privacy'] ?? false,
      groupSize: json['group']['groupSize'],
      imageUrl: json['group']['imageURL'] ?? "",
      lastMessage: json['lastMessage'] != null
          ? LastMessage.fromJson(json['lastMessage'])
          : null,
      creatorId: json['group']['creatorId'],
      active: json['group']['active'],
      communityId: json['group']['communityId'],
      invitationLink: json['group']['invitationLink'],
      messagesCount: 0,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        name,
        privacy,
        groupSize,
        imageUrl,
        lastMessage,
        creatorId,
        active,
        communityId,
        invitationLink,
        messagesCount,
        partisipantId
      ];
}
