import 'package:telegram/feature/dashboard/domain/entity/user.dart';

class UserModel extends User{
  UserModel({required super.id, required super.name, required super.email, required super.status});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      status: json['status'] == 'true' ? true : false,

    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': super.id,
      'name': super.name,
      'email': super.email,
      'status': super.status==true ? 'true' : 'false',
    };
  } 

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is UserModel &&
      other.id == super.id &&
      other.name == super.name &&
      other.email == super.email;
  }

  @override
  int get hashCode => super.id.hashCode ^ super.name.hashCode ^ super.email.hashCode;

  @override
  String toString() => 'UserModel(id: ${super.id}, name: ${super.name}, email: ${super.email})';

}