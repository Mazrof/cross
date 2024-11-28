class ApiConstants {
  static String register = "auth/signup";

  static const login = 'auth/login';

  static const sendOtpMial = 'auth/send-code';
  static const sendOtpPhone = 'auth/send-code-sms';
  static const logout = 'auth/logout';

  // static const refreshToken = 'auth/refresh-token';
  static const verifyOtp = 'auth/verify-code';
  static const socialLogin = 'auth/social-login';

  static const GoogleSignIn = 'auth/google';
  static const GithubSignIn = 'auth/github';
  static const googleCallBack = 'auth/google/callback';
  static const githubCallBack = 'auth/github/callback';

  static const githubClientId = 'Ov23liNhZ8W3afDrCcjO';
  static const githubClientSecret = '14df323aed985c282ea8eeef2612579434dd3eb8';
  static const githubRedirectUrl =
      'https://telegram-clone-a4785.firebaseapp.com/__/auth/handler';
}
