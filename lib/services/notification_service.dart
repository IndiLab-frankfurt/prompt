import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:prompt/locator.dart';
import 'package:prompt/services/logging_service.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:awesome_notifications/awesome_notifications.dart';

class NotificationService {
  late FlutterLocalNotificationsPlugin localNotifications;

  static const String CHANNEL_ID_DAILY_REMINDER = "Tägliche Erinnerung";
  static const String CHANNEL_NAME_DAILY_REMINDER = "Tägliche Erinnerung";
  static const String CHANNEL_DESCRIPTION_DAILY_REMINDER =
      "Tägliche Erinnerung";
  static const String PAYLOAD_MORNING_REMINDER = "Tägliche Erinnerung";

  static const String CHANNEL_ID_EVENING = "Erinnerung Abend";
  static const String CHANNEL_NAME_EVENING = "Erinnerung Abend";
  static const String CHANNEL_DESCRIPTION_EVENING = "Erinnerung Abend";
  static const String PAYLOAD_EVENING = "PAYLOAD_EVENING";

  static const String CHANNEL_ID_BOOSTER_PROMPT = "Strategie Erinnerung";
  static const String CHANNEL_NAME_BOOSTER_PROMPT = "Strategie Erinnerung";
  static const String CHANNEL_DESCRIPTION_BOOSTER_PROMPT =
      "Strategie Erinnerung";
  static const String PAYLOAD_BOOSTER_PROMPT = "PAYLOAD_STRATEGIE_REMINDER";

  static const int ID_PLAN_REMINDER = 2389;
  static const int ID_DAILY = 6969;
  static const int ID_TASK_REMINDER = 42;
  static const int ID_FINAL_TASK_REMINDER = 1901;

  static const String BUTTON_ACTION_LEARNED_TODAY = "LEARNED_TODAY";
  static const String BUTTON_ACTION_NOT_LEARNED_TODAY = "NOT_LEARNED_TODAY";

  Future initialize() async {
    localNotifications = FlutterLocalNotificationsPlugin();

    var initSettingsAndroid =
        new AndroidInitializationSettings('ic_notification');
    var initSettingsIOS = new IOSInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    var initSettings = InitializationSettings(
        android: initSettingsAndroid, iOS: initSettingsIOS);

    await _configureLocalTimeZone();

    await localNotifications.initialize(initSettings,
        onSelectNotification: onSelectNotification);

    return true;
  }

  Future<dynamic> onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) async {
    print("Received Local Notification");
  }

  Future<void> _configureLocalTimeZone() async {
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation("Europe/Berlin"));
  }

  Future onSelectNotification(String? payload) async {
    if (payload != null) {
      debugPrint('notification payload: ' + payload);

      if (payload == PAYLOAD_MORNING_REMINDER) {
        locator
            .get<LoggingService>()
            .logEvent("NotificationClickInternalisation");
      }
      if (payload == PAYLOAD_EVENING) {
        locator.get<LoggingService>().logEvent("NotificationClickRecallTask");
      }
    }
  }

  Future scheduleDailyReminder(DateTime dateTime, int id) async {
    String groupKey = "daily";
    // Check if is already scheduled and cancel all dailies
    try {
      await AwesomeNotifications().cancel(id);
    } catch (e) {
      print(e);
    }

    await AwesomeNotifications().createNotification(
        actionButtons: [
          NotificationActionButton(
              key: BUTTON_ACTION_LEARNED_TODAY, label: "Ja"),
          NotificationActionButton(
              key: BUTTON_ACTION_NOT_LEARNED_TODAY, label: "Nein")
        ],
        content: NotificationContent(
            id: id,
            channelKey: NotificationService.CHANNEL_ID_DAILY_REMINDER,
            title: 'Hast du heute Vokabeln gelernt?',
            body: '',
            wakeUpScreen: true,
            category: NotificationCategory.Reminder,
            groupKey: groupKey),
        schedule: NotificationCalendar(
          hour: dateTime.hour,
          minute: dateTime.minute,
          second: dateTime.second,
          // repeats: true,
          allowWhileIdle: true,
        ));

    locator.get<LoggingService>().logEvent("Schedule Daily Reminder");
  }

  schedulePlanReminder(DateTime dateTime) async {
    String groupKey = "plan";

    try {
      await AwesomeNotifications().cancel(ID_PLAN_REMINDER);
    } catch (e) {
      print(e);
    }

    await AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: ID_PLAN_REMINDER,
            channelKey: CHANNEL_ID_BOOSTER_PROMPT,
            title: 'Schaue dir nochmal deinen Plan an',
            body: '',
            wakeUpScreen: true,
            category: NotificationCategory.Reminder,
            groupKey: groupKey),
        schedule: NotificationCalendar(
            day: dateTime.day,
            month: dateTime.month,
            hour: dateTime.hour,
            minute: dateTime.minute,
            second: dateTime.second,
            allowWhileIdle: true));

    locator.get<LoggingService>().logEvent("Schedule Plan Reminder");
  }

  cancelDailyReminder() async {
    await AwesomeNotifications().cancel(ID_DAILY);
    locator.get<LoggingService>().logEvent("Cancel Daily Reminder");
  }

  sendDebugNotification() async {
    // send a test notification after ten seconds
    await Future.delayed(Duration(seconds: 10));
    AwesomeNotifications().createNotification(
        actionButtons: [
          NotificationActionButton(
              key: BUTTON_ACTION_LEARNED_TODAY, label: "Ja"),
          NotificationActionButton(
              key: BUTTON_ACTION_NOT_LEARNED_TODAY, label: "Nein")
        ],
        content: NotificationContent(
            id: 10,
            channelKey: 'basic_channel',
            title: 'Hast du heute Vokabeln gelernt?',
            category: NotificationCategory.Social,
            body: ''));
  }

  Future<List<PendingNotificationRequest>> getPendingNotifications() async {
    return await localNotifications.pendingNotificationRequests();
  }

  clearPendingNotifications() async {
    await AwesomeNotifications().cancelAll();
  }
}
