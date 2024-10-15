import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String id;
  final String firstName;
  final String lastName;
  final String username;
  final String email;
  final String phone;
  final String profileImage;
  final String password;
 



  const UserEntity({
    required this.password,
    required this.profileImage,
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.email,
    required this.phone,
  });

  @override
  // TODO: implement props
  List<Object?> get props =>
      [id, firstName, lastName, username, email, phone, profileImage,password];
}
