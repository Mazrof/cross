import 'package:telegram/feature/dashboard/domain/entity/group.dart';

class GroupModel extends Group{
  const GroupModel({required super.name, required super.id});

  factory GroupModel.fromJson(Map<String, dynamic> json) {
    return GroupModel(
      name: json['name'],
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': super.name,
      'id': super.id,
    };
  }


  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is GroupModel &&
      other.name == super.name &&
      other.id == super.id;
  }


  @override
  int get hashCode => super.name.hashCode ^ super.id.hashCode;

  @override
  String toString() => 'GroupModel(name: ${super.name}, id: ${super.id})';



}

