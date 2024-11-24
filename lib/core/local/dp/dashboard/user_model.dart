import 'package:hive/hive.dart';
import 'package:telegram/feature/dashboard/domain/entity/user.dart';


part  'user_model.g.dart';

@HiveType(typeId: 0)
class UserModel extends User {
  @override
  @HiveField(0)
  final String id;

  @override
  @HiveField(1)
  final String name;

  @override
  @HiveField(2)
  final String email;



  @override
  @HiveField(3)
  final bool status;




  UserModel({required this.id, required this.name, required this.email, required this.status})
      : super(id: id, name: name, email: email, status: status);

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      status: json['status']=='true'?true:false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'status': status == true ? 'true' : 'false',
    };
  }
}
