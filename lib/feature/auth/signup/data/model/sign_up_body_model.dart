import 'package:telegram/feature/auth/signup/domain/entities/sign_up_entity.dart';

class SignUpBodyModel extends SignUpEntity {
  final String username;

  @override
  final String phone;
  @override
  final String email;
  @override
  final String password;
  String id;

  SignUpBodyModel({
    this.id = '',
    required this.username,
    required this.phone,
    required this.email,
    required this.password,
  }) : super(
          username: username,
          phone: phone,
          email: email,
          password: password,
        );

  Map<String, dynamic> toJson() {
    final body = {
      'username': username,
      'phone': phone,
      'email': email,
      'password': password,
      'id': id,
    };
    return body;
  }

  factory SignUpBodyModel.fromEntity(SignUpEntity entity) {
    return SignUpBodyModel(
      username: entity.username,
      phone: entity.phone,
      email: entity.email,
      password: entity.password,
    );
  }
  static empty() {
    return SignUpBodyModel(
      username: '',
      phone: '',
      email: '',
      password: '',
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SignUpBodyModel &&
        other.username == username &&
        other.phone == phone &&
        other.email == email &&
        other.password == password;
  }

  @override
  int get hashCode {
    return username.hashCode ^
        phone.hashCode ^
        email.hashCode ^
        password.hashCode;
  }

  SignUpBodyModel copyWith({
    String? firstName,
    String? lastName,
    String? phone,
    String? email,
    String? password,
  }) {
    return SignUpBodyModel(
      username: username ?? this.username,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  @override
  SignUpEntity toEntity() {
    return SignUpEntity(
      username: username,
      phone: phone,
      email: email,
      password: password,
    );
  }

  factory SignUpBodyModel.fromJson(Map<String, dynamic> json) {
    return SignUpBodyModel(
      username: json['username'],
      phone: json['phone'],
      email: json['email'],
      password: json['password'],
    );
  }
}
