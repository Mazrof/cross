class VerifyMailData {
  final String email;
  final String code;
  final String method ;
  VerifyMailData({
    required this.method,
    required this.email,
    required this.code,
  });
}