import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> handler(RemoteMessage message) async {
  print('title${(message.data)!}');
}

class FirebaseService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  static Future<FirebaseService> create() async {
    try {
      await Firebase.initializeApp();
      final notificationSettings =
          await FirebaseMessaging.instance.requestPermission(provisional: true);
      // final apnsToken = await FirebaseMessaging.instance.getAPNSToken();
      // APNS token is available, make FCM plugin API requests...
      final fcmToken = await FirebaseMessaging.instance.getToken();
      print(fcmToken);

      // if (apnsToken != null) {
      //   print(apnsToken);
      // }

      // background
      FirebaseMessaging.onMessageOpenedApp.listen(handler);

      FirebaseMessaging.onMessage.listen(handler);

      final message = await FirebaseMessaging.instance.getInitialMessage();

      if (message != null) {
        handler(message);
      }

      // final message = await _firebaseMessaging.
      FirebaseMessaging.onBackgroundMessage(handler);
    } catch (e) {
      // TODO

      print(e);
    }

    return FirebaseService();
  }

  Future<void> init() async {
    await Firebase.initializeApp();
    final notificationSettings =
        await FirebaseMessaging.instance.requestPermission(provisional: true);
    final apnsToken = await FirebaseMessaging.instance.getAPNSToken();
    // APNS token is available, make FCM plugin API requests...
    if (apnsToken != null) {
      print(apnsToken);
      final fcmToken = await FirebaseMessaging.instance.getToken();

      print(fcmToken);
    }
  }
}
