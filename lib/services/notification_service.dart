import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:prompt/locator.dart';
import 'package:prompt/services/logging_service.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:collection/collection.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

class NotificationService {
  late FlutterLocalNotificationsPlugin localNotifications;

  static const String CHANNEL_ID_MORNING_REMINDER = "WDP Erinnerung";
  static const String CHANNEL_NAME_MORNING_REMINDER =
      "Wenn-Dann-Plan Erinnerung";
  static const String CHANNEL_DESCRIPTION_MORNING_REMINDER =
      "Wenn-Dann-Plan Erinnerung";
  static const String PAYLOAD_MORNING_REMINDER = "PAYLOAD_II_REMINDER";

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

  deleteReminderWithId(int id) async {
    var pendingNotifications = await getPendingNotifications();
    var reminderExists =
        pendingNotifications.firstWhereOrNull((n) => n.id == ID_DAILY);
    if (reminderExists == null) {
      localNotifications.cancel(id);
    }
  }

  deleteScheduledRecallReminderTask() async {
    var pendingNotifications = await getPendingNotifications();
    var taskReminderExists =
        pendingNotifications.firstWhereOrNull((n) => n.id == ID_TASK_REMINDER);
    if (taskReminderExists == null) {
      localNotifications.cancel(ID_TASK_REMINDER);
    }
  }

  deleteScheduledFinalReminderTask() async {
    var pendingNotifications = await getPendingNotifications();
    var taskReminderExists = pendingNotifications
        .firstWhereOrNull((n) => n.id == ID_FINAL_TASK_REMINDER);
    if (taskReminderExists == null) {
      localNotifications.cancel(ID_FINAL_TASK_REMINDER);
    }
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

  scheduleDailyReminder(DateTime dateTime, int id) async {
    String groupKey = "daily";
    // Check if is already scheduled and cancel all dailies
    try {
      await AwesomeNotifications().cancelSchedulesByGroupKey(groupKey);
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
            channelKey: 'scheduleddaily',
            title: 'Hast du heute Vokabeln gelernt?',
            body: '',
            wakeUpScreen: true,
            category: NotificationCategory.Alarm,
            groupKey: groupKey),
        schedule: NotificationCalendar(
          // interval: 60 * 60 * 24,
          hour: dateTime.hour,
          // date: dateTime,
          repeats: true,
        ));

    locator.get<LoggingService>().logEvent("Schedule Daily Reminder");
  }

  schedulePlanReminder(DateTime dateTime) async {
    String groupKey = "plan";

    await AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: ID_PLAN_REMINDER,
            channelKey: 'planReminder',
            title: 'Erinnere dich an deinen Plan',
            body: '',
            wakeUpScreen: true,
            category: NotificationCategory.Alarm,
            groupKey: groupKey),
        schedule: NotificationCalendar(
          // interval: 60 * 60 * 24,
          hour: dateTime.hour,
          // date: dateTime,
          repeats: true,
        ));

    locator.get<LoggingService>().logEvent("Schedule Plan Reminder");
  }

  cancelMorningReminder() async {
    await AwesomeNotifications().cancel(ID_DAILY);
    locator.get<LoggingService>().logEvent("Cancel Daily Reminder");
  }

  getMillisecondsUntilMidnight(DateTime time) {
    var now = DateTime.now();
    var midnight = DateTime(now.year, now.month, now.day, 23, 59);

    return midnight.difference(now).inMilliseconds;
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
    await localNotifications.cancelAll();
  }
}
