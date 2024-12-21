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
    final community = json['community'] as Map<String, dynamic>?;

    // Ensure all keys exist and are properly handled
    return ChannelModel(
      id: json['id'] as int? ?? 0, // Default to 0 if null
      name: community?['name'] as String? ?? '', // Default to empty string
      privacy: community?['privacy'] as bool? ?? false, // Default to false
      canAddComments:
          json['canAddComments'] as bool? ?? false, // Default to false
      imageUrl: community?['imageURL'] as String?,
      invitationLink: json['invitationLink'] as String?,
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
    String? invitationLink,
  }) {
    return ChannelModel(
      id: id ?? this.id,
      name: name ?? this.name,
      privacy: privacy ?? this.privacy,
      canAddComments: canAddComments ?? this.canAddComments,
      imageUrl: imageUrl ?? this.imageUrl,
      invitationLink: invitationLink ?? this.invitationLink,
    );
  }
}
