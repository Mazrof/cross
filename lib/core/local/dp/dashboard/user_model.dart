import 'package:hive/hive.dart';
import 'package:telegram/feature/dashboard/domain/entity/user.dart';

part 'user_model.g.dart';

@HiveType(typeId: 0)
class UserModel extends User {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String username;

  @HiveField(2)
  final bool status;

  @HiveField(3)
  final String email;

  @HiveField(4)
  final String bio;

  @HiveField(5)
  final bool activeNow;

  @HiveField(6)
  final String phone;

  UserModel({
    required this.id,
    required this.username,
    required this.status,
    required this.email,
    required this.bio,
    required this.activeNow,
    required this.phone,
  }) : super(
          id: id,
          username: username,
          status: status,
          email: email,
          bio: bio,
          activeNow: activeNow,
          phone: phone,
        );

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      username: json['username'],
      status: json['status'],
      email: json['email'],
      bio: json['bio'],
      activeNow: json['activeNow'],
      phone: json['phone'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'status': status,
      'email': email,
      'bio': bio,
      'activeNow': activeNow,
      'phone': phone,
    };
  }
}
