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
      imageUrl: json['community']['imageURL'],
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

  // copy with
  GroupModel copyWith({
    int? id,
    int? groupSize,
    String? name,
    bool? privacy,
    String? imageUrl,
  }) {
    return GroupModel(
      id: id ?? this.id,
      groupSize: groupSize ?? this.groupSize,
      name: name ?? this.name,
      privacy: privacy ?? this.privacy,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  //empty group
  static GroupModel empty() {
    return GroupModel(
      id: 0,
      groupSize: 0,
      name: '',
      privacy: false,
      imageUrl: '',
    );
  }
}
