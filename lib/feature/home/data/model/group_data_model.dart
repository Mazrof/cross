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

  // factory GroupDataModel.fromJson(Map<String, dynamic> json) {
  //   print('Parsing GroupDataModel from: $json');
  //   return GroupDataModel(
  //     partisipantId: json['id'],
  //     id: json['group']['id'],
  //     name: json['group']['name'],
  //     privacy: json['group']['privacy'] ?? false,
  //     groupSize: json['group']['groupSize'],
  //     imageUrl: json['group']['imageURL'] ?? "",
  //     lastMessage: json['lastMessage'] != null
  //         ? LastMessage.fromJson(json['lastMessage'])
  //         : null,
  //     creatorId: json['group']['creatorId'],
  //     active: json['group']['active'],
  //     communityId: json['group']['communityId'],
  //     invitationLink: json['group']['invitationLink'],
  //     messagesCount: 0,
  //   );
  // // }
  // factory GroupDataModel.fromJson(Map<String, dynamic> json) {
  //   print('Parsing GroupDataModel from: $json');

  //   // Check if 'group' exists and is a Map
  //   final group = json['group'] as Map<String, dynamic>?;

  //   if (group == null) {
  //     throw FormatException(
  //         "Invalid JSON: 'group' field is missing or not a Map.");
  //   }

  //   return GroupDataModel(
  //     partisipantId: json['id'],
  //     id: group['id'],
  //     name: group['name'] ?? '', // Provide default values for optional fields
  //     privacy: group['privacy'] ?? false,
  //     groupSize: group['groupSize'] ?? 0,
  //     imageUrl: group['imageURL'] ?? "",
  //     lastMessage: json['lastMessage'] != null
  //         ? LastMessage.fromJson(Map<String, dynamic>.from(json['lastMessage']))
  //         : null,
  //     creatorId: group['creatorId'] ?? 0,
  //     active: group['active'] ?? false,
  //     communityId: group['communityId'] ?? 0,
  //     invitationLink: group['invitationLink'] ?? "",
  //     messagesCount: 0,
  //   );
  // }

  factory GroupDataModel.fromJson(Map<String, dynamic> json) {
    print('Parsing GroupDataModel from: $json');

    if (json['group'] != null && json['group'] is Map) {
      // When 'group' exists and is a Map, parse it.
      final group = Map<String, dynamic>.from(json['group']);
      return GroupDataModel(
        partisipantId: json['id'], // Top-level field
        id: group['id'],
        name: group['name'],
        privacy: group['privacy'] ?? false,
        groupSize: group['groupSize'] ?? 0,
        imageUrl: group['imageURL'] ?? "",
        lastMessage: json['lastMessage'] != null
            ? LastMessage.fromJson(
                Map<String, dynamic>.from(json['lastMessage']))
            : null,
        creatorId: group['creatorId'] ?? 0,
        active: group['active'] ?? false,
        communityId: group['communityId'] ?? 0,
        invitationLink: group['invitationLink'] ?? "",
        messagesCount: json['messagesCount'] ?? 0,
      );
    } else if (json['group'] == null) {
      // When 'group' is missing, assume flat structure.
      return GroupDataModel(
        partisipantId:
            json['partisipantId'] ?? json['id'], // Use top-level fields
        id: json['id'],
        name: json['name'] ?? "",
        privacy: json['privacy'] ?? false,
        groupSize: json['groupSize'] ?? 0,
        imageUrl: json['imageUrl'] ?? "",
        lastMessage: json['lastMessage'] != null
            ? LastMessage.fromJson(
                Map<String, dynamic>.from(json['lastMessage']))
            : null,
        creatorId: json['creatorId'] ?? 0,
        active: json['active'] ?? false,
        communityId: json['communityId'] ?? 0,
        invitationLink: json['invitationLink'] ?? "",
        messagesCount: json['messagesCount'] ?? 0,
      );
    } else {
      throw FormatException(
          "Invalid JSON: 'group' field is missing or not a Map.");
    }
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

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'privacy': privacy,
      'groupSize': groupSize,
      'imageUrl': imageUrl,
      'lastMessage': lastMessage,
      'creatorId': creatorId,
      'active': active,
      'communityId': communityId,
      'invitationLink': invitationLink,
      'messagesCount': messagesCount,
      'partisipantId': partisipantId,
    };
  }
}
