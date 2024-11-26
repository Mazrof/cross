import 'package:g_recaptcha_v3/g_recaptcha_v3.dart';

class RecaptchaService {
  static const String siteKey = "6LfFCIsqAAAAAFTEdBPkYwT1I2guLlkIleR-lYBU";

  /// Initialize the reCAPTCHA ready state
  Future<bool> initialize() async {
    try {
      return await GRecaptchaV3.ready(siteKey);
    } catch (e) {
      print('Error initializing reCAPTCHA: $e');
      return false;
    }
  }

  /// Execute reCAPTCHA to get a token
  Future<String?> executeRecaptcha(String action) async {
    try {
      String? token = await GRecaptchaV3.execute(action);
      print("Received token: $token");
      return token;
    } catch (e) {
      print('Error executing reCAPTCHA: $e');
      return null;
    }
  }

  /// Wrapper to handle reCAPTCHA execution and retrieve token
  Future<String?> handleRecaptcha() async {
    bool isRecaptchaReady = await initialize();
    if (!isRecaptchaReady) {
      print("reCAPTCHA is not ready");
      return null;
    }

    String? token = await executeRecaptcha('signup');
    return token;
  }
}
