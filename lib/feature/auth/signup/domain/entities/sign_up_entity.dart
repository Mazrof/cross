class SignUpEntity {
  final String username;
  final String phone;
  final String email;
  final String password;
  final String publicKey;
  final String privateKey;
  String id;

  SignUpEntity({
    this.id = '',
    required this.username,
    required this.phone,
    required this.email,
    required this.password,
    required this.publicKey,
    required this.privateKey,
  });
}
