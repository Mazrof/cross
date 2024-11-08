import 'package:g_recaptcha_v3/g_recaptcha_v3.dart';

class RecaptchaService {
  final String siteKey = '6LcFx2wqAAAAACsC9_PqBh15E-40sOioz2hQ9ml9';

  RecaptchaService();

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

  Future<String?> handleRecaptcha() async {
    bool isRecaptchaReady = await initialize();

    if (!isRecaptchaReady) {
      return null;
    }

    String? token = await executeRecaptcha("signup_action");
    if (token != null) {
      return token;
    } else {
      return null;
    }
  }
}
