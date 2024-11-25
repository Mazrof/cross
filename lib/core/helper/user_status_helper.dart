import 'package:telegram/core/local/cache_helper.dart';

class UserStatusHelper {
  static const String firstTimeKey = 'first_time';

  static Future<String> checkUserStatus() async {
    final firstTime = await CacheHelper.read(key: firstTimeKey);
    final loggedIn = await CacheHelper.read(key: 'token');
    final registered = await CacheHelper.read(key: 'registered');
   
    if (firstTime == null||firstTime=='true') {
      CacheHelper.write(key: firstTimeKey, value: 'false');
      return 'onbording';
    } else if (loggedIn == null) {
      if (registered == 'true') {
        return 'verify_mail';
      } else {
        return 'login';
      }
    } else    return 'home';
  

  }


  static Future<void> setRegisteredNotVerified() async {
    await CacheHelper.write(key: firstTimeKey, value: 'false');
    await CacheHelper.write(key: 'registered', value: 'true');
  }
}
