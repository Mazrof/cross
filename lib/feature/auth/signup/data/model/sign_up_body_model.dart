import 'package:telegram/feature/auth/signup/domain/entities/sign_up_entity.dart';

class SignUpBodyModel extends SignUpEntity {
  final String firstName;
  final String lastName;
  final String phone;
  final String email;
  final String password;
  final String recaptchaToken;

  SignUpBodyModel({
    
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.email,
    required this.password,
    required this.recaptchaToken,
  }) : super(
            firstName: firstName,
            lastName: lastName,
            phone: phone,
            email: email,
            password: password,
            recaptchaToken: recaptchaToken,
            );

  Map<String, dynamic> toJson() {
    final body = {
      'first_name': firstName,
      'last_name': lastName,
      'primary_mobile': phone,
      'email': email,
      'password': password,
      'recaptcha_token': recaptchaToken,
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
      recaptchaToken: entity.recaptchaToken,
    );

  }
  static empty()
  {
    return SignUpBodyModel(
      firstName: '',
      lastName: '',
      phone: '',
      email: '',
      password: '',
      recaptchaToken: '',
    );
  }
}
