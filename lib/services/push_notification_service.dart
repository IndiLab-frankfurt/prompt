import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:prompt/services/base_service.dart';
import 'package:prompt/services/settings_service.dart';
import 'package:prompt/shared/enums.dart';

class PushNotificationService implements BaseService {
  SettingsService _settingsService;

  PushNotificationService(this._settingsService);

  static final FirebaseMessaging _firebaseMessaging =
      FirebaseMessaging.instance;

  initPushNotifications() async {
    _firebaseMessaging.subscribeToTopic("daily");
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      _handleFirebaseMessage(initialMessage);
    }
    // Also handle any interaction when the app is in the background via a
    // Stream listener
    FirebaseMessaging.onMessageOpenedApp.listen(_handleFirebaseMessage);

    await FirebaseMessaging.instance.getToken().then((token) {
      print("FCM TOKEN: $token");
      if (token != null)
        _settingsService.setSetting(SettingsKeys.fcmToken, token);
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
    });
  }

  void _handleFirebaseMessage(RemoteMessage message) {
    print("Handling Firebase Message");
    print(message.data);
    print(message.notification);
  }

  @override
  Future<bool> initialize() async {
    await initPushNotifications();
    return true;
  }
}
