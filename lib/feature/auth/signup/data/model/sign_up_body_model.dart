import 'package:telegram/feature/auth/signup/domain/entities/sign_up_entity.dart';

class SignUpBodyModel extends SignUpEntity {
  final String username;

  @override
  final String phone;
  @override
  final String email;
  @override
  final String password;
  @override
  final String publicKey;
  @override
  final String privateKey;

  String id;

  SignUpBodyModel({
    this.id = '',
    required this.username,
    required this.phone,
    required this.email,
    required this.password,
    required this.publicKey,
    required this.privateKey,
  }) : super(
          username: username,
          phone: phone,
          email: email,
          password: password,
          publicKey: publicKey,
          privateKey: privateKey,
        );

  Map<String, dynamic> toJson() {
    final body = {
      'username': username,
      'phone': phone,
      'email': email,
      'password': password,
      'id': id,
      'publicKey': publicKey,
      'privateKey': privateKey,
    };
    return body;
  }

  factory SignUpBodyModel.fromEntity(SignUpEntity entity) {
    return SignUpBodyModel(
      username: entity.username,
      phone: entity.phone,
      email: entity.email,
      password: entity.password,
      publicKey: entity.publicKey,
      privateKey: entity.privateKey,
    );
  }
  static empty() {
    return SignUpBodyModel(
      username: '',
      phone: '',
      email: '',
      password: '',
      publicKey: '',
      privateKey: '',
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SignUpBodyModel &&
        other.username == username &&
        other.phone == phone &&
        other.email == email &&
        other.password == password &&
        other.privateKey == privateKey &&
        other.publicKey == publicKey;
  }

  @override
  int get hashCode {
    return username.hashCode ^
        phone.hashCode ^
        email.hashCode ^
        password.hashCode ^
        privateKey.hashCode ^
        publicKey.hashCode;
  }

  SignUpBodyModel copyWith({
    String? firstName,
    String? lastName,
    String? phone,
    String? email,
    String? password,
    String? publicKey,
    String? privateKey,
  }) {
    return SignUpBodyModel(
      username: username ?? this.username,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      password: password ?? this.password,
      publicKey: publicKey ?? this.publicKey,
      privateKey: privateKey ?? this.privateKey,
    );
  }

  @override
  SignUpEntity toEntity() {
    return SignUpEntity(
      username: username,
      phone: phone,
      email: email,
      password: password,
      publicKey: publicKey,
      privateKey: privateKey,
    );
  }

  factory SignUpBodyModel.fromJson(Map<String, dynamic> json) {
    return SignUpBodyModel(
      username: json['username'],
      phone: json['phone'],
      email: json['email'],
      password: json['password'],
      publicKey: json['publicKey'],
      privateKey: json['privateKey'],
     );
  }
}
