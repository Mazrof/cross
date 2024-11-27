import 'package:telegram/feature/dashboard/domain/entity/user.dart';

class UserModel extends User {
  UserModel({
    required String id,
    required String username,
    required bool status,
    required String email,
    required String bio,
    required bool activeNow,
    required String phone,
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
      id: json['id'].toString(),
      username: json['username'] as String,
      status: json['status'] as bool,
      email: json['email'] as String,
      bio: json['bio'] as String,
      activeNow: json['activeNow'] as bool,
      phone: json['phone'] as String,
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

  @override
  List<Object?> get props =>
      [id, username, status, email, bio, activeNow, phone];

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.id == id &&
        other.username == username &&
        other.status == status &&
        other.email == email &&
        other.bio == bio &&
        other.activeNow == activeNow &&
        other.phone == phone;
  }

  @override
  int get hashCode =>
      id.hashCode ^
      username.hashCode ^
      status.hashCode ^
      email.hashCode ^
      bio.hashCode ^
      activeNow.hashCode ^
      phone.hashCode;

  @override
  String toString() {
    return 'UserModel(id: $id, username: $username, status: $status, email: $email, bio: $bio, activeNow: $activeNow, phone: $phone)';
  }
}
