import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String? username;
  final bool? status;
  final String? email;
  final String? bio;
  final bool? activeNow;
  final String? phone;

  User({
    required this.id,
    this.username,
    this.status,
    this.email,
    this.bio,
    this.activeNow,
    this.phone,
  });

  @override
  List<Object?> get props =>
      [id, username, status, email, bio, activeNow, phone];
}
