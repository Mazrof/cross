import 'package:telegram/feature/channels/create_channel/domain/entity/channel_entity.dart';

class ChannelModel extends Channel {
  ChannelModel({
    required int id,
    required String name,
    required bool privacy,
    required bool canAddComments,
    String? imageUrl,
    String? invitationLink,
  }) : super(
          id: id,
          name: name,
          privacy: privacy,
          canAddComments: canAddComments,
          imageUrl: imageUrl,
          invitationLink: invitationLink,
        );

  // From JSON
  // From JSON
  factory ChannelModel.fromJson(Map<String, dynamic> json) {
    final community =
        json['community'] as Map<String, dynamic>?; // Handle null community

    return ChannelModel(
      id: json['id'] as int,
      name: community?['name'] as String? ??
          '', // Default to an empty string if null
      privacy:
          community?['privacy'] as bool? ?? false, // Default to false if null
      canAddComments: json['canAddComments'] as bool,
      imageUrl: community?['imageURL'] as String?, // Handle optional field
      invitationLink:
          json['invitationLink'] as String?, // Handle optional field
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'privacy': privacy,
      'canAddComments': canAddComments,
      if (imageUrl != null) 'imageUrl': imageUrl,
    };
  }

  // Empty object
  static ChannelModel empty() {
    return ChannelModel(
      id: 0,
      name: '',
      privacy: false,
      canAddComments: false,
    );
  }

  //copy with
  ChannelModel copyWith({
    int? id,
    String? name,
    bool? privacy,
    bool? canAddComments,
    String? imageUrl,
  }) {
    return ChannelModel(
      id: id ?? this.id,
      name: name ?? this.name,
      privacy: privacy ?? this.privacy,
      canAddComments: canAddComments ?? this.canAddComments,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}
