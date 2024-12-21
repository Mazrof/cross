import 'package:telegram/feature/dashboard/domain/entity/user.dart';

class UserModel extends User {
  UserModel({
    required String id,
    String? username,
    bool? status,
    String? email,
    String? bio,
    bool? activeNow,
    String? phone,
  }) : super(
          id: id,
          username: username,
          status: status,
          email: email,
          bio: bio,
          activeNow: activeNow,
          phone: phone,
        );

  // factory UserModel.fromJson(Map<String, dynamic> json) {
  //   return UserModel(
  //     id: json['id'].toString(),
  //     username: json['username'] as String?,
  //     status: json['status'] as bool?,
  //     email: json['email'] as String?,
  //     bio: json['bio'] as String?,
  //     activeNow: json['activeNow'] as bool?,
  //     phone: json['phone'] as String?,
  //   );
  // }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    print('Parsing UserModel from: $json');

    if (json['user'] != null && json['user'] is Map) {
      // When 'user' exists and is a Map, parse it.
      final user = Map<String, dynamic>.from(json['user']);
      return UserModel(
        id: user['id'].toString(),
        username: user['username'] as String?,
        status: user['status'] as bool?,
        email: user['email'] as String?,
        bio: user['bio'] as String?,
        activeNow: user['activeNow'] as bool?,
        phone: user['phone'] as String?,
      );
    } else if (json['user'] == null) {
      // When 'user' is missing, assume flat structure.
      return UserModel(
        id: json['id'].toString(),
        username: json['username'] as String?,
        status: json['status'] as bool?,
        email: json['email'] as String?,
        bio: json['bio'] as String?,
        activeNow: json['activeNow'] as bool?,
        phone: json['phone'] as String?,
      );
    } else {
      throw FormatException(
          "Invalid JSON: 'user' field is missing or not a Map.");
    }
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
