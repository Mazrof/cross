import 'package:telegram/feature/auth/signup/domain/entities/sign_up_entity.dart';

class SignUpBodyModel extends SignUpEntity {
  final String firstName;
  final String lastName;
  final String phone;
  final String email;
  final String password;

  SignUpBodyModel({
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.email,
    required this.password,
  }) : super(
          firstName: firstName,
          lastName: lastName,
          phone: phone,
          email: email,
          password: password,
        );

  Map<String, dynamic> toJson() {
    final body = {
      'first-name': firstName,
      'last-name': lastName,
      'phone': phone,
      'email': email,
      'password': password,
    };
    return body;
  }

  factory SignUpBodyModel.fromEntity(SignUpEntity entity) {
    return SignUpBodyModel(
      firstName: entity.firstName,
      lastName: entity.lastName,
      phone: entity.phone,
      email: entity.email,
      password: entity.password,
    );
  }
  static empty() {
    return SignUpBodyModel(
      firstName: '',
      lastName: '',
      phone: '',
      email: '',
      password: '',
    );
  }

  @override
  String toString() {
    return 'SignUpBodyModel(firstName: $firstName, lastName: $lastName, phone: $phone, email: $email, password: $password)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SignUpBodyModel &&
        other.firstName == firstName &&
        other.lastName == lastName &&
        other.phone == phone &&
        other.email == email &&
        other.password == password;
  }

  @override
  int get hashCode {
    return firstName.hashCode ^
        lastName.hashCode ^
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
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  @override
  SignUpEntity toEntity() {
    return SignUpEntity(
      firstName: firstName,
      lastName: lastName,
      phone: phone,
      email: email,
      password: password,
    );
  }

  factory SignUpBodyModel.fromJson(Map<String, dynamic> json) {
    return SignUpBodyModel(
      firstName: json['first-name'],
      lastName: json['last-name'],
      phone: json['phone'],
      email: json['email'],
      password: json['password'],
    );
  }
}
