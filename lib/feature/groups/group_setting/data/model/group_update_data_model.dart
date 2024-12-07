import 'package:telegram/feature/groups/group_setting/domain/entity/group_update_data.dart';

class GroupUpdateDataModel extends GroupUpdateData {
  GroupUpdateDataModel(
      {required super.name, required super.privacy, required super.groupSize, required super.imageUrl});

  factory GroupUpdateDataModel.fromJson(Map<String, dynamic> json) {
    return GroupUpdateDataModel(

      name: json['name'],
      privacy: json['privacy'],
      groupSize: json['groupSize'],
      imageUrl: json['imageUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'privacy': privacy,
      'groupSize': groupSize,
      'imageUrl': imageUrl,
    };
  }
}
