import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:prompt/l10n/localization/generated/l10n.dart';
import 'package:prompt/services/base_service.dart';
import 'package:prompt/services/logging_service.dart';
import 'package:collection/collection.dart';
import 'package:timezone/data/latest_all.dart' as tzdata;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_native_timezone/flutter_native_timezone.dart';

class NotificationService implements BaseService {
  final LoggingService _loggingService;

  NotificationService(this._loggingService);

  FlutterLocalNotificationsPlugin localNotifications =
      FlutterLocalNotificationsPlugin();

  static const String KEY_DAILY = "daily";
  static const String KEY_VOCAB = "vocab";
  static const String KEY_FINAL = "final";

  static const Map<String, String> CHANNEL_IDS = {
    KEY_DAILY: "Channel_Daily_Reminder",
    KEY_VOCAB: "Channel_Vocab_Reminder",
    KEY_FINAL: "Channel_Final_Reminder",
  };

  static const Map<String, String> CHANNEL_NAMES = {
    KEY_DAILY: "Daily Reminder",
    KEY_VOCAB: "Vocab Reminder",
    KEY_FINAL: "Final Reminder",
  };

  static const Map<String, String> CHANNEL_DESCRIPTIONS = {
    KEY_DAILY: "Daily Reminder",
    KEY_VOCAB: "Vocab Reminder",
    KEY_FINAL: "Final Reminder",
  };

  static const Map<String, String> PAYLOADS = {
    KEY_DAILY: "PAYLOAD_DAILY_REMINDER",
    KEY_VOCAB: "PAYLOAD_VOCAB_REMINDER",
    KEY_FINAL: "PAYLOAD_FINAL_REMINDER",
  };

  static const Map<String, int> NOTIFICATION_IDS = {
    KEY_DAILY: 1000,
    KEY_VOCAB: 2000,
    KEY_FINAL: 3000,
  };

  @override
  Future<bool> initialize() async {
    localNotifications = FlutterLocalNotificationsPlugin();

    var initSettingsAndroid =
        new AndroidInitializationSettings('ic_notification');

    DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
            onDidReceiveLocalNotification: onDidReceiveLocalNotification);

    var initSettings = InitializationSettings(
        android: initSettingsAndroid, iOS: initializationSettingsDarwin);

    await _configureLocalTimeZone();

    await localNotifications.initialize(initSettings);

    return true;
  }

  Future<dynamic> onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) async {
    print("Received Local Notification");
  }

  deleteDailyReminderWithId(int id) async {
    var dailyId = NOTIFICATION_IDS[KEY_DAILY]! + id;
    return deleteNotification(dailyId);
  }

  deleteScheduledFinalReminderTask() async {
    return deleteNotification(NOTIFICATION_IDS[KEY_FINAL]!);
  }

  deleteVocabReminderWithId(int id) async {
    var vocabId = NOTIFICATION_IDS[KEY_VOCAB]! + id;
    return deleteNotification(vocabId);
  }

  deleteNotification(int id) async {
    var pendingNotifications = await getPendingNotifications();
    var reminderExists =
        pendingNotifications.firstWhereOrNull((n) => n.id == id);
    if (reminderExists == null) {
      localNotifications.cancel(id);
    }
  }

  Future<void> _configureLocalTimeZone() async {
    tzdata.initializeTimeZones();
    String currentTimeZone = await FlutterNativeTimezone.getLocalTimezone();
    // The emulator doesn't have the correct timezone set
    if (kDebugMode || currentTimeZone.isEmpty) {
      currentTimeZone = "Europe/Berlin";
    }
    tz.setLocalLocation(tz.getLocation(currentTimeZone));
  }

  Future onSelectNotification(String? payload) async {
    if (payload != null) {
      debugPrint('notification payload: ' + payload);

      if (payload == PAYLOADS[KEY_DAILY]) {
        _loggingService.logEvent("NotificationClickInternalisation");
      }
      if (payload == PAYLOADS[KEY_FINAL]) {
        _loggingService.logEvent("NotificationClickFinalTask");
      }
    }
  }

  scheduleDailyReminder(DateTime time, int id) async {
    var timeoutAfter = getMillisecondsUntilMidnight(time);
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        CHANNEL_IDS[KEY_DAILY]!, CHANNEL_NAMES[KEY_DAILY]!,
        channelDescription: CHANNEL_DESCRIPTIONS[KEY_DAILY]!,
        timeoutAfter: timeoutAfter,
        // TODO: Change back to ongoing: true
        ongoing: false);
    var notificationDetails =
        new NotificationDetails(android: androidPlatformChannelSpecifics);

    // _loggingService.logEvent("ScheduleNotificationTaskReminder");

    String title = S.current.notificationMessage_daily;
    String body = "";
    String payload = time.toIso8601String();

    var scheduledDate = tz.TZDateTime(
        tz.local, time.year, time.month, time.day, time.hour, time.minute);

    var reminderId = NOTIFICATION_IDS[KEY_DAILY]! + id;

    print("Scheduling Daily Reminder for $scheduledDate with id $reminderId");

    await localNotifications.zonedSchedule(
        reminderId, title, body, scheduledDate, notificationDetails,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        payload: payload,
        androidAllowWhileIdle: true);
  }

  scheduleVocabTestReminder(DateTime time, int id) async {
    var timeoutAfter = getMillisecondsUntilMidnight(time);
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        CHANNEL_IDS[KEY_VOCAB]!, CHANNEL_NAMES[KEY_VOCAB]!,
        channelDescription: CHANNEL_DESCRIPTIONS[KEY_VOCAB]!,
        timeoutAfter: timeoutAfter);
    var notificationDetails =
        new NotificationDetails(android: androidPlatformChannelSpecifics);

    _loggingService.logEvent("Scheduled Notification Vocab Reminder");

    String title = S.current.notificationMessage_vocabTest;
    String body = "";
    String payload = time.toIso8601String();

    var scheduledDate = tz.TZDateTime(
        tz.local, time.year, time.month, time.day, time.hour, time.minute);

    var reminderId = NOTIFICATION_IDS[KEY_VOCAB]! + id;

    print("Scheduling Vocab Reminder for $scheduledDate ");

    await localNotifications.zonedSchedule(
        reminderId, title, body, scheduledDate, notificationDetails,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        payload: payload,
        androidAllowWhileIdle: true);
  }

  getMillisecondsUntilMidnight(DateTime time) {
    var now = DateTime.now();
    var midnight = DateTime(now.year, now.month, now.day, 23, 59);

    return midnight.difference(now).inMilliseconds;
  }

  Future scheduleFinalTaskReminder(DateTime dateTime) async {
    await deleteScheduledFinalReminderTask();

    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        CHANNEL_IDS[KEY_FINAL]!, CHANNEL_NAMES[KEY_FINAL]!,
        channelDescription: CHANNEL_DESCRIPTIONS[KEY_FINAL]!, ongoing: true);
    var notificationDetails =
        new NotificationDetails(android: androidPlatformChannelSpecifics);

    var scheduledDate = tz.TZDateTime(tz.local, dateTime.year, dateTime.month,
        dateTime.day, dateTime.hour, dateTime.minute);

    String title = S.current.notificationTitle_final;
    String body = S.current.notificationBody_final;
    String payload = dateTime.toIso8601String();

    await localNotifications.zonedSchedule(NOTIFICATION_IDS[KEY_FINAL]!, title,
        body, scheduledDate, notificationDetails,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        payload: payload,
        androidAllowWhileIdle: true);
  }

  sendDebugReminder() async {
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        "WURST", "DEBUG",
        channelDescription: "DEBUG");
    var notificationDetails =
        new NotificationDetails(android: androidPlatformChannelSpecifics);

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
        payload: "DEBUG",
        androidAllowWhileIdle: true);
  }

  Future<List<PendingNotificationRequest>> getPendingNotifications() async {
    return await localNotifications.pendingNotificationRequests();
  }

  clearPendingNotifications() async {
    await localNotifications.cancelAll();
  }
}
