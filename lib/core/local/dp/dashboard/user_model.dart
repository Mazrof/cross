import 'package:hive/hive.dart';
import 'package:telegram/feature/dashboard/domain/entity/user.dart';


part  'user_model.g.dart';

@HiveType(typeId: 0)
class UserModel extends User {
  @override
  @HiveField(0)
  final int id;

  @override
  @HiveField(1)
  final String name;

  @override
  @HiveField(2)
  final String email;

  UserModel({required this.id, required this.name, required this.email})
      : super(id: id, name: name, email: email);

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
    };
  }
}
