import 'package:telegram/feature/groups/add_new_group/domain/member.dart';

class MemberModel extends Member{
  MemberModel({
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

  factory MemberModel.fromJson(Map<String, dynamic> json) {
    return MemberModel(
      id: json['id'],
      name: json['name'],
      imageUrl: json['imageUrl'],
      lastSeen: json['lastSeen'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'lastSeen': lastSeen,
    };
  }
  
}