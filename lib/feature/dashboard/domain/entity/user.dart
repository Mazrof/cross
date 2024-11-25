import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String username;
  final bool status;
  final String email;
  final String bio;
  final bool activeNow;
  final String phone;

  User({
    required this.id,
    required this.username,
    required this.status,
    required this.email,
    required this.bio,
    required this.activeNow,
    required this.phone,
  });
  
  @override
  // TODO: implement props
  List<Object?> get props => [id, username, status, email, bio, activeNow, phone];
}
