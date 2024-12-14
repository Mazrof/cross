import 'package:telegram/feature/groups/add_new_group/domain/entity/chat_tile_data.dart';

class chatTileModel extends chatTileData {
  chatTileModel({
    required int id,
    required String name,
    required String imageUrl,
    required String lastSeen,
  }) : super(
          id: id,
          name: name,
          imageUrl: imageUrl,
          lastSeen: lastSeen,
        );

  factory chatTileModel.fromJson(Map<String, dynamic> json) {
    return chatTileModel(
      id: json['id'],
      name: json['name'],
      imageUrl: json['imageURL'],
      lastSeen: json['lastSeen'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'imageURL': imageUrl,
      'lastSeen': lastSeen,
    };
  }
}
