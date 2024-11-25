import 'package:hive/hive.dart';
import 'package:telegram/feature/dashboard/domain/entity/group.dart';

part 'group_model.g.dart';

@HiveType(typeId: 1)
class GroupModel extends Group {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final int groupSize;

  @HiveField(2)
  final String name;

  @HiveField(3)
  final bool privacy;
  @HiveField(4)
  final bool status;

  GroupModel({
    required this.status,
    required this.id,
    required this.groupSize,
    required this.name,
    required this.privacy,
  }) : super(
          status: status,
          id: id,
          groupSize: groupSize,
          name: name,
          privacy: privacy,
        );

  factory GroupModel.fromJson(Map<String, dynamic> json) {
    return GroupModel(
      status: json['status'],
      id: json['id'].toString(),
      groupSize: json['groupSize'],
      name: json['communities']['name'],
      privacy: json['communities']['privacy'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'id': id,
      'groupSize': groupSize,
      'name': name,
      'privacy': privacy,
    };
  }

  @override
  List<Object?> get props => [id, groupSize, name, privacy];

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is GroupModel &&
        other.id == id &&
        other.groupSize == groupSize &&
        other.name == name &&
        other.status == status &&
        other.privacy == privacy;
  }

  @override
  int get hashCode =>
      id.hashCode ^
      groupSize.hashCode ^
      name.hashCode ^
      privacy.hashCode ^
      status.hashCode;

  @override
  String toString() {
    return 'GroupModel(id: $id, groupSize: $groupSize, name: $name, privacy: $privacy)';
  }
}
