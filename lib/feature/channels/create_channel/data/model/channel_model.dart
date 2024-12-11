

import 'package:telegram/feature/channels/create_channel/domain/entity/channel_entity.dart';

class ChannelModel extends Channel {
  ChannelModel({
    required int id,
    required String name,
    required bool privacy,
    required bool canAddComments,
    String? imageUrl,
  }) : super(
          id: id,
          name: name,
          privacy: privacy,
          canAddComments: canAddComments,
          imageUrl: imageUrl,
        );

  // From JSON
  factory ChannelModel.fromJson(Map<String, dynamic> json) {
    return ChannelModel(
      id: json['id'] as int,
      name: json['name'] as String,
      privacy: json['privacy'] as bool,
      canAddComments: json['canAddComments'] as bool,
      imageUrl: json['imageUrl'] as String?, // Optional field
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'privacy': privacy,
      'canAddComments': canAddComments,
      if (imageUrl != null) 'imageUrl': imageUrl,
    };
  }
}
