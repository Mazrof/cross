class GetMessagesModel {
  // final String? email;
  // final String? password; // Or any other relevant fields
  // final bool? rememberMe;

  // final chatId

  GetMessagesModel();

  factory GetMessagesModel.fromJson(Map<String, dynamic> json) {
    return GetMessagesModel(
        // email: json['email'],
        // password: json['password'],
        );
  }

  Map<String, dynamic> toJson() {
    return {
      // 'email': email,
      // 'password': password,
    };
  }
}
