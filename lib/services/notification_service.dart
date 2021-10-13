import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:prompt/locator.dart';
import 'package:prompt/services/logging_service.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:collection/collection.dart';

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

  static const String CHANNEL_ID_FINAL_REMINDER =
      "Erinnerung Abschlussbefragung";
  static const String CHANNEL_NAME_FINAL_REMINDER =
      "Erinnerung Abschlussbefragung";
  static const String CHANNEL_DESCRIPTION_FINAL_REMINDER =
      "Erinnerung Abschlussbefragung";
  static const String PAYLOAD_FINAL_REMINDER = "PAYLOAD_FINAL_REMINDER";

  static const int ID_LDT_REMINDER = 87;
  static const int ID_MORNING = 6969;
  static const int ID_TASK_REMINDER = 42;
  static const int ID_FINAL_TASK_REMINDER = 1901;

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
        pendingNotifications.firstWhereOrNull((n) => n.id == ID_MORNING);
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
    // final String timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
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
      if (payload == PAYLOAD_FINAL_REMINDER) {
        locator.get<LoggingService>().logEvent("NotificationClickFinalTask");
      }
    }
  }

  scheduleMorningReminder(DateTime time, int id) async {
    var timeoutAfter = getMillisecondsUntilMidnight(time);
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        CHANNEL_ID_MORNING_REMINDER, CHANNEL_NAME_MORNING_REMINDER,
        channelDescription: CHANNEL_DESCRIPTION_MORNING_REMINDER,
        timeoutAfter: timeoutAfter,
        ongoing: true);
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var notificationDetails = new NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);

    locator.get<LoggingService>().logEvent("ScheduleNotificationTaskReminder");

    String title = "Mache jetzt weiter mit PROMPT!";
    String body = "";

    var scheduledDate = tz.TZDateTime(
        tz.local, time.year, time.month, time.day, time.hour, time.minute);

    var reminderId = ID_MORNING + id;

    print("Scheduling Morning Reminder for $scheduledDate with id $reminderId");

    await localNotifications.zonedSchedule(
        reminderId, title, body, scheduledDate, notificationDetails,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        payload: reminderId.toString(),
        androidAllowWhileIdle: true);
  }

  getMillisecondsUntilMidnight(DateTime time) {
    var now = DateTime.now();
    var midnight = DateTime(now.year, now.month, now.day, 23, 59);

    return midnight.difference(now).inMilliseconds;
  }

  scheduleEveningReminder(DateTime time) async {
    await deleteScheduledRecallReminderTask();

    var timeoutAfter = getMillisecondsUntilMidnight(time);
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        CHANNEL_ID_EVENING, CHANNEL_NAME_EVENING,
        channelDescription: CHANNEL_DESCRIPTION_EVENING,
        ongoing: true,
        timeoutAfter: timeoutAfter);
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var notificationDetails = new NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);

    var scheduledDate = tz.TZDateTime(
        tz.local, time.year, time.month, time.day, time.hour, time.minute);

    String title = "Mache jetzt weiter mit PROMPT!";
    String body = "";

    locator.get<LoggingService>().logEvent("ScheduleEveningReminder");

    await localNotifications.zonedSchedule(
        ID_TASK_REMINDER, title, body, scheduledDate, notificationDetails,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        payload: PAYLOAD_EVENING,
        androidAllowWhileIdle: true);
  }

  scheduleBoosterPrompt(DateTime time) async {
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        CHANNEL_ID_BOOSTER_PROMPT, CHANNEL_NAME_BOOSTER_PROMPT,
        channelDescription: CHANNEL_DESCRIPTION_BOOSTER_PROMPT, ongoing: true);
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var notificationDetails = new NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);

    String title = "Mache jetzt weiter mit PROMPT!";
    String body = "";

    var scheduledDate = tz.TZDateTime(
        tz.local, time.year, time.month, time.day, time.hour, time.minute);

    await localNotifications.zonedSchedule(
        ID_LDT_REMINDER, title, body, scheduledDate, notificationDetails,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        payload: PAYLOAD_BOOSTER_PROMPT,
        androidAllowWhileIdle: true);
  }

  scheduleFinalTaskReminder(DateTime dateTime) async {
    await deleteScheduledFinalReminderTask();

    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        CHANNEL_ID_FINAL_REMINDER, CHANNEL_NAME_FINAL_REMINDER,
        channelDescription: CHANNEL_DESCRIPTION_FINAL_REMINDER, ongoing: true);
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var notificationDetails = new NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);

    var scheduledDate = tz.TZDateTime(tz.local, dateTime.year, dateTime.month,
        dateTime.day, dateTime.hour, dateTime.minute);

    String title = "Wir haben noch ein paar Fragen an dich!";
    String body =
        "Nimm jetzt an der PROMPT-Abschlussbefragung teil und sichere dir die letzten 💎";

    await localNotifications.zonedSchedule(
        ID_FINAL_TASK_REMINDER, title, body, scheduledDate, notificationDetails,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        payload: PAYLOAD_FINAL_REMINDER,
        androidAllowWhileIdle: true);
  }

  sendDebugReminder() async {
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        "WURST", CHANNEL_NAME_EVENING,
        channelDescription: CHANNEL_DESCRIPTION_EVENING);
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var notificationDetails = new NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);

    var now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate = tz.TZDateTime(tz.local, now.year, now.month,
        now.day, now.hour, now.minute, now.second + 20);

    await localNotifications.zonedSchedule(
        123123123,
        "Ich bin eine Benachrichtigung",
        "Ich bin eine Benachrichtigung",
        scheduledDate,
        notificationDetails,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        payload: PAYLOAD_EVENING,
        androidAllowWhileIdle: true);
  }

  Future<List<PendingNotificationRequest>> getPendingNotifications() async {
    return await localNotifications.pendingNotificationRequests();
  }

  clearPendingNotifications() async {
    await localNotifications.cancelAll();
  }
}
