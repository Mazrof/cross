import 'package:g_recaptcha_v3/g_recaptcha_v3.dart';

class RecaptchaService {
  final String siteKey;

  RecaptchaService({required this.siteKey});

  /// Initialize the reCAPTCHA ready state
  Future<bool> initialize() async {
    bool ready = await GRecaptchaV3.ready(siteKey);
    return ready;
  }

  /// Execute reCAPTCHA to get a token
  Future<String?> executeRecaptcha(String action) async {
    String? token = await GRecaptchaV3.execute(action);
    return token;
  }
}
