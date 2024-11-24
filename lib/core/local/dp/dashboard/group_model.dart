import 'package:hive/hive.dart';
import 'package:telegram/feature/dashboard/domain/entity/group.dart';

part 'group_model.g.dart';

@HiveType(typeId: 1)
class GroupModel extends Group {
  @override
  @HiveField(0)
  final String id;

  @override
  @HiveField(1)
  final String name;

  const GroupModel({required this.id, required this.name})
      : super(id: id, name: name);

  factory GroupModel.fromJson(Map<String, dynamic> json) {
    return GroupModel(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
