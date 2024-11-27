class LoginRequestBody {
  final String? email;
  final String? password; // Or any other relevant fields
  final bool? rememberMe;

  LoginRequestBody({
    this.email,
    this.password,
    this.rememberMe,
  });

  factory LoginRequestBody.fromJson(Map<String, dynamic> json) {
    return LoginRequestBody(
      email: json['email'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }
}
