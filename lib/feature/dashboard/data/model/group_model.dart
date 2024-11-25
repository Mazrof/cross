import 'package:telegram/feature/dashboard/domain/entity/group.dart';

class GroupModel extends Group {
  const GroupModel({
    required String id,
    required int groupSize,
    required String name,
    required bool privacy,
    required bool hasFilter, // Add status field
  }) : super(
          id: id,
          groupSize: groupSize,
          name: name,
          privacy: privacy,
          hasFilter: hasFilter, // Add status field
        );

  factory GroupModel.fromJson(Map<String, dynamic> json) {
    return GroupModel(
      id: json['id'].toString(),
      groupSize: json['groupSize'],
      name: json['community']['name'],
      privacy: json['community']['privacy'],
      hasFilter: json['hasFilter'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'groupSize': groupSize,
      'name': name,
      'privacy': privacy,
      'hasFilter': hasFilter, // Add status field
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is GroupModel &&
        other.id == id &&
        other.groupSize == groupSize &&
        other.name == name &&
        other.privacy == privacy &&
        other.hasFilter == hasFilter; // Add status field
  }

  @override
  int get hashCode =>
      id.hashCode ^
      groupSize.hashCode ^
      name.hashCode ^
      privacy.hashCode ^
      hasFilter.hashCode; // Add status field

  @override
  String toString() {
    return 'GroupModel(id: $id, groupSize: $groupSize, name: $name, privacy: $privacy, status: $hasFilter)'; // Add status field
  }
}
