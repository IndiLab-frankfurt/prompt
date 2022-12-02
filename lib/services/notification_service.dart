import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:prompt/locator.dart';
import 'package:prompt/services/logging_service.dart';
import 'package:prompt/services/navigation_service.dart';
import 'package:prompt/shared/app_strings.dart';
import 'package:prompt/shared/route_names.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

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

  static const String CHANNEL_ID_PLAN_REMINDER = "Strategie Erinnerung";
  static const String CHANNEL_NAME_PLAN_REMINDER = "Strategie Erinnerung";
  static const String CHANNEL_DESCRIPTION_PLAN_REMINDER =
      "Strategie Erinnerung";
  static const String PAYLOAD_PLAN_REMINDER = "PAYLOAD_STRATEGIE_REMINDER";

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
      // this is an annoying hack, but due to the limitations of the flutter
      // local notifications plugin, we can only use the payload to identify
      var date = DateTime.tryParse(payload);
      if (date != null) {
        locator.get<NavigationService>().navigateTo(RouteNames.PLAN_REMINDER);
      }
    }
  }

  Future scheduleDailyReminder(DateTime dateTime, int id) async {
    // Check if is already scheduled and cancel all dailies
    try {
      await localNotifications.cancel(ID_DAILY);
    } catch (e) {
      print(e);
    }

    var timeoutAfter = getMillisecondsUntilMidnight(dateTime);
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        CHANNEL_ID_DAILY_REMINDER, CHANNEL_NAME_DAILY_REMINDER,
        channelDescription: CHANNEL_DESCRIPTION_DAILY_REMINDER,
        timeoutAfter: timeoutAfter,
        ongoing: true);
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var notificationDetails = new NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);

    var scheduledDate = tz.TZDateTime.from(dateTime, tz.local);

    await localNotifications.zonedSchedule(
        ID_DAILY,
        AppStrings.Notification_Title_VocabReminder,
        "",
        scheduledDate,
        notificationDetails,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.wallClockTime,
        matchDateTimeComponents: DateTimeComponents.time);

    locator.get<LoggingService>().logEvent(
      "Schedule Daily Reminder",
      data: {"date": dateTime.toString()},
    );
  }

  // Future<bool> hasPermissions() async {
  //   var hasPermission = await localNotifications.resolvePlatformSpecificImplementation<
  //           IOSFlutterLocalNotificationsPlugin>().
  //   return hasPermission;
  // }

  Future<bool?> requestPermissions() async {
    var result = await localNotifications
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(alert: true, badge: true, sound: true);
    return result;
  }

  getMillisecondsUntilMidnight(DateTime time) {
    var now = DateTime.now();
    var midnight = DateTime(now.year, now.month, now.day, 23, 59);

    return midnight.difference(now).inMilliseconds;
  }

  Future<void> schedulePlanReminder(DateTime dateTime) async {
    try {
      await localNotifications.cancel(ID_PLAN_REMINDER);
    } catch (e) {
      print(e);
    }

    var timeoutAfter = getMillisecondsUntilMidnight(dateTime);
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        CHANNEL_ID_PLAN_REMINDER, CHANNEL_NAME_PLAN_REMINDER,
        channelDescription: CHANNEL_DESCRIPTION_PLAN_REMINDER,
        timeoutAfter: timeoutAfter,
        ongoing: true);
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var notificationDetails = new NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);

    var scheduledDate = tz.TZDateTime.from(dateTime, tz.local);

    await localNotifications.zonedSchedule(
        ID_PLAN_REMINDER,
        AppStrings.Notification_Title_PlanReminder,
        "",
        scheduledDate,
        notificationDetails,
        androidAllowWhileIdle: true,
        payload: dateTime.toIso8601String(),
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.wallClockTime);

    locator.get<LoggingService>().logEvent(
      "Schedule Plan Reminder",
      data: {"date": dateTime.toString()},
    );
  }

  Future<List<PendingNotificationRequest>> getPendingNotifications() async {
    var scheduled = await localNotifications.pendingNotificationRequests();
    print(scheduled);
    return scheduled;
  }

  clearPendingNotifications() async {
    await localNotifications.cancelAll();
  }
}
