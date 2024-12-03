import 'package:telegram/core/local/cache_helper.dart';

class UserStatusHelper {
  static const String firstTimeKey = 'first_time';

  static Future<String> checkUserStatus() async {
    final firstTime = await CacheHelper.read(key: firstTimeKey);
    final loggedIn = await CacheHelper.read(key: 'loged');
    final registered = await CacheHelper.read(key: 'registered');

    if (firstTime == null || firstTime == 'true') {
      CacheHelper.write(key: firstTimeKey, value: 'false');
      return 'onbording';
    } else if (loggedIn == null || loggedIn == 'false') {
      if (registered == null || registered == 'false') {
        return 'login';
      } else {
        return 'verify_mail';
      }
    } else if (loggedIn == "true") {
      return 'home';
    } else {
      return 'login';
    }
  }

  static Future<void> setRegisteredNotVerified() async {
    await CacheHelper.write(key: firstTimeKey, value: 'false');
    await CacheHelper.write(key: 'registered', value: 'true');
    await CacheHelper.write(key: 'loged', value: 'false');
  }
}
