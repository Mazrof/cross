import 'package:telegram/feature/groups/add_new_group/domain/entity/group.dart';
import 'package:telegram/feature/groups/add_new_group/domain/use_case/create_group_use_case.dart';

class GroupsModel extends Group {
  GroupsModel(
      {required super.id,
      required super.name,
      required super.privacy,
      required super.groupSize,
      required super.imageUrl,

      required super.admins});

  factory GroupsModel.fromJson(Map<String, dynamic> json) {
    return GroupsModel(
      imageUrl: json['imageUrl'],
      admins: [],
      id: json['id'],
      groupSize: json['groupSize'],
      name: json['community']['name'],
      privacy: json['community']['privacy'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'imageUrl': imageUrl, 
      'name': name,
      'privacy': privacy,
      'groupSize': groupSize,
      'admins': admins,
    };
  }

  @override
  String toString() {
    return 'GroupsModel{name: $name, privacy: $privacy, groupSize: $groupSize, admins: $admins}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GroupsModel &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          privacy == other.privacy &&
          groupSize == other.groupSize &&
          admins == other.admins;

  @override
  int get hashCode =>
      name.hashCode ^ privacy.hashCode ^ groupSize.hashCode ^ admins.hashCode;
}
