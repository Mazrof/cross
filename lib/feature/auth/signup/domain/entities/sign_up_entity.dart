class SignUpEntity {
  final String firstName;
  final String lastName;
  final String phone;
  final String email;
  final String password;
  final String recaptchaToken;

  SignUpEntity({
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.email,
    required this.password,
    required this.recaptchaToken,
  });
}
