import 'dart:io';
import 'package:g_recaptcha_v3/g_recaptcha_v3.dart';

class RecaptchaService {
  RecaptchaService();

  /// Initialize the reCAPTCHA ready state
  Future<bool> initialize() async {
    try {
      return await GRecaptchaV3.ready(
          '6LcfXwqAAAAAPlu80FSm2yTVbNi293Vw7JKfIZU');
    } catch (e) {
      print('Error initializing reCAPTCHA: $e');
      return false;
    }
  }

  /// Execute reCAPTCHA to get a token
  Future<String?> executeRecaptcha(String action) async {
    try {
      String? token = await GRecaptchaV3.execute(action);
      return token;
    } catch (e) {
      print('Error executing reCAPTCHA: $e');
      return null;
    }
  }

  Future<String?> handleRecaptcha() async {
    print('here to handle recaptcha');
    bool isRecaptchaReady = await initialize();
    print('isRecaptchaReady: $isRecaptchaReady');

    if (!isRecaptchaReady) {
      return null;
    }

    String? token = await executeRecaptcha("signup");
    print('recaptchaToken: $token');
    if (token != null) {
      return token;
    } else {
      return null;
    }
  }
}
