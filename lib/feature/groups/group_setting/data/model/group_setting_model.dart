import 'package:telegram/feature/groups/group_setting/domain/entity/group_setting.dart';

class GroupModel extends GroupEntity {
  GroupModel({
    required int id,
    required int groupSize,
    required String name,
    required bool privacy,
    required String imageUrl,
  }) : super(
          id: id,
          groupSize: groupSize,
          name: name,
          privacy: privacy,
          imageUrl: imageUrl,
        );

  factory GroupModel.fromJson(Map<String, dynamic> json) {
    return GroupModel(
      id: json['id'],
      groupSize: json['groupSize'],
      name: json['community']['name'],
      privacy: json['community']['privacy'],
      imageUrl: json['imageUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'groupSize': groupSize,
      'name': name,
      'privacy': privacy,
      'imageUrl': imageUrl,
    };
  }
}
