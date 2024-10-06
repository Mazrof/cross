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
 final RegExp phoneRgx = RegExp(r'^[0-9]+$');
    if (phoneNumber == null || phoneNumber.isEmpty) {
      return 'Phone number is required';
    } else if (phoneNumber.length != 10) {
      return 'Phone number must be 10 digits';
    } else if (!phoneRgx.hasMatch(phoneNumber)) {
      return 'Phone number must contain only digits';
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


