import 'package:flutter/material.dart';

// Validate email
String? validateEmail(String? email) {
  final RegExp emailRegx = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  if (email == null || email.isEmpty) {
    return 'Email is required';
  } else if (!emailRegx.hasMatch(email)) {
    return 'Please enter a valid email';
  }
  return null;
}

String? validatePhoneNumber(String? phoneNumber) {
  final RegExp phoneRgx =
      RegExp(r'^\+\d{1,4}[0-9]+$'); // Regex for country code and digits
  if (phoneNumber == null || phoneNumber.isEmpty) {
    return 'Phone number is required';
  } else if (!phoneRgx.hasMatch(phoneNumber)) {
    return 'Phone number must start with a "+" followed by country code and digits';
  } else if (phoneNumber.length < 10 || phoneNumber.length > 15) {
    return 'Phone number must be between 10 and 15 digits including the country code';
  }
  return null;
}

extension PasswordVaildation on String? {
  bool isNotNullOrBlank() => this != null && this!.trim().isNotEmpty;
  bool hasNumericDigit() => this?.contains(RegExp(r'[0-9]')) == true;
  bool hasSmallLetter() => this?.contains(RegExp(r'[a-z]')) == true;
  bool hasCapitalLetter() => this?.contains(RegExp(r'[A-Z]')) == true;
  bool hasSpecialLetters() =>
      this?.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]')) == true;
  bool isAtLeast8Digits() => (this?.length ?? 0) >= 8;
}

Color getColorFromString(String colorString) {
  if (_isValidHexCode(colorString)) {
    return Color(int.parse('FF$colorString', radix: 16));
  } else {
    switch (colorString.toLowerCase()) {
      case 'black':
        return Colors.black;
      case 'red':
        return Colors.red;
      case 'green':
        return Colors.green;
      case 'blue':
        return Colors.blue;
      case 'yellow':
        return Colors.yellow;
      case 'orange':
        return Colors.orange;
      case 'pink':
        return Colors.pink;
      case 'purple':
        return Colors.purple;
      case 'white':
        return Colors.white;
      case 'grey':
        return Colors.grey;
      default:
        return Colors.black;
    }
  }
}

bool _isValidHexCode(String code) {
  RegExp hexCodeRegExp = RegExp(r'^([0-9a-fA-F]{6}|[0-9a-fA-F]{8})$');
  return hexCodeRegExp.hasMatch(code);
}

String? validatePassword(String? password) {
  if (password == null || password.isEmpty) {
    return 'Password is required';
  } else if (password.length < 6) {
    return 'Password must be at least 6 characters';
  } else if (!password.contains(RegExp(r'[0-9]'))) {
    return 'Password must contain at least one number';
  } else if (!password.contains(RegExp(r'[A-Z]'))) {
    return 'Password must contain at least one uppercase letter';
  } else if (!password.contains(RegExp(r'[a-z]'))) {
    return 'Password must contain at least one lowercase letter';
  } else if (!password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
    return 'Password must contain at least one special character';
  }
  return null;
}

String maskEmail(String email) {
  String emailUsername = email.split('@')[0];
  String emailDomain = email.split('@')[1];

  String maskedUsername =
      "${emailUsername.substring(0, 2)}***${emailUsername[emailUsername.length - 1]}";

  return "$maskedUsername@$emailDomain";
}

class AppValidator {
  bool isFormValid(GlobalKey<FormState> formKey) {
    return formKey.currentState?.validate() ?? false;
  }
}
