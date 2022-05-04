import 'dart:io';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:prompt/models/assessment_result.dart';
import 'package:prompt/services/data_service.dart';
import 'package:prompt/services/logging_service.dart';
import 'package:prompt/services/navigation_service.dart';
import 'package:prompt/services/notification_service.dart';
import 'package:prompt/services/reward_service.dart';
import 'package:prompt/services/usage_stats/usage_stats_service.dart';
import 'package:prompt/shared/enums.dart';
import 'package:prompt/shared/route_names.dart';
import 'package:prompt/shared/extensions.dart';
import 'package:prompt/viewmodels/session_zero_view_model.dart';

class ExperimentService {
  static const int NUM_GROUPS = 2;
  static const Duration MAX_STUDY_DURATION = Duration(days: 56);

  final DataService _dataService;
  final NotificationService _notificationService;
  final LoggingService _loggingService;
  final RewardService _rewardService;
  final NavigationService _navigationService;

  late Map<int, List<int>> reminderNotificationDays = {
    1: List<int>.generate(54, (int index) => 1 + index),
    2: [...List<int>.generate(36, (int index) => 1 + index), 45, 54],
    3: [...List<int>.generate(36, (int index) => 1 + index), 45, 54],
    4: [...List<int>.generate(36, (int index) => 1 + index), 45, 54],
    5: [...List<int>.generate(36, (int index) => 1 + index), 45, 54],
    6: [...List<int>.generate(36, (int index) => 1 + index), 45, 54],
    7: [...List<int>.generate(36, (int index) => 1 + index), 45, 54]
  };

  final Map<int, List<int>> boosterPrompts = {
    1: [],
    2: [1, 2, 3, 7, 8, 13, 14, 15, 19, 20, 21, 25, 26, 31, 32, 33],
    3: [4, 5, 6, 10, 11, 12, 16, 17, 22, 23, 24, 28, 29, 30, 34, 35],
    4: [],
    5: [1, 2, 3, 7, 8, 13, 14, 15, 19, 20, 21, 25, 26, 31, 32, 33],
    6: [4, 5, 6, 10, 11, 12, 16, 17, 22, 23, 24, 28, 29, 30, 34, 35],
    7: [],
  };

  final Map<int, List<int>> internalisationPrompts = {
    1: [],
    2: [],
    3: [],
    4: [],
    5: [1, 2, 3, 7, 8, 13, 14, 15, 19, 20, 21, 25, 26, 31, 32, 33],
    6: [4, 5, 6, 10, 11, 12, 16, 17, 22, 23, 24, 28, 29, 30, 34, 35],
    7: [],
  };

  final Map<int, List<int>> vocabTestReminder = {
    1: [],
    2: [],
    3: [],
    4: [],
    5: [1, 2, 3, 7, 8, 9, 13, 14, 15, 19, 20, 21, 25, 26, 27, 31, 32, 33],
    6: [4, 5, 6, 10, 11, 12, 16, 17, 18, 22, 23, 24, 28, 29, 30, 34, 35, 36],
    7: [],
  };

  final Map<int, int> finalAssessmentDay = {
    1: 54,
    2: 36,
    3: 36,
    4: 36,
    5: 36,
    6: 36,
    7: 36
  };

  final List<int> vocabTestDays = [9, 18, 27, 36, 45, 54];

  ExperimentService(this._dataService, this._notificationService,
      this._loggingService, this._rewardService, this._navigationService);

  Future onSessionZeroComplete() async {
    var dt = DateTime.now();
    await _notificationService.scheduleMorningReminder(dt, 2);
  }

  Future onDistributedLearningComplete() async {
    await _rewardService.addPoints(5);
    await _dataService.saveSimpleValueWithTimestamp(
        "distributedLearning", "distributedLearning");
  }

  Future onMentalContrastingComplete() async {
    await _rewardService.addPoints(5);
    await _dataService.saveSimpleValueWithTimestamp(
        "mentalContrasting", "mentalContrasting");
  }

  nextScreen(String currentScreen) async {
    if (currentScreen == RouteNames.SESSION_ZERO) {
      return await _navigationService
          .navigateWithReplacement(RouteNames.NO_TASKS);
    } else if (currentScreen == RouteNames.ASSESSMENT_EVENING) {
      return await _navigationService.navigateTo(RouteNames.NO_TASKS);
    } else if (currentScreen == RouteNames.ASSESSMENT_FINAL) {
      return await _navigationService.navigateTo(RouteNames.NO_TASKS);
    } else if (currentScreen == RouteNames.ASSESSMENT_MORNING) {
      return await _navigationService.navigateTo(RouteNames.NO_TASKS);
    } else {
      await _navigationService.navigateWithReplacement(RouteNames.NO_TASKS);
    }
  }

  int getDaysSinceStart() {
    var regDate = _dataService.getUserDataCache().registrationDate;
    var compareDate =
        DateTime(regDate.year, regDate.month, regDate.day, 3, 0, 0);
    var daysAgo = compareDate.daysAgo();
    return daysAgo;
  }

  bool _shouldIncrementStreakDay() {
    var last =
        _dataService.getLastAssessmentResultForCached(MORNING_ASSESSMENT);
    if (last == null) {
      return getDaysSinceStart() == 1;
    }

    var adequateSubmissionDate =
        last.submissionDate.isYesterday() || last.submissionDate.isToday();
    return adequateSubmissionDate;
  }

  int getPointsForMorningAssessment() {
    if (_shouldIncrementStreakDay()) {
      return 1 +
          RewardService.pointsForMorningAssessment +
          _rewardService.streakDays;
    } else {
      return RewardService.pointsForMorningAssessment;
    }
  }

  Future<void> submitAssessment(
      AssessmentResult assessment, String type) async {
    await this._dataService.saveAssessment(assessment);
  }

  bool isFirstDay() {
    var daysAgo = getDaysSinceStart();

    return daysAgo == 1;
  }

  Future<void> addDayLearned() async {
    await Future.wait(<Future>[
      _dataService.saveDateLearned(DateTime.now(), true),
      _rewardService.addPoints(5)
    ]);
  }

  Future<void> addDayNotLearned() async {
    await Future.wait(<Future>[
      _dataService.saveDateLearned(DateTime.now(), false),
      _rewardService.addPoints(5)
    ]);
  }

  isInternalisationDay() {
    var userData = _dataService.getUserDataCache();
    var daysAgo = getDaysSinceStart();

    return internalisationPrompts[userData.group]!.contains(daysAgo);
  }

  void reactToNotifications(context) {
    try {
      AwesomeNotifications()
          .actionStream
          .listen((ReceivedNotification receivedNotification) {
        print('Received notification ${receivedNotification.title}');
        if (receivedNotification is ReceivedAction) {
          var pressedButton = receivedNotification.buttonKeyPressed;

          if (pressedButton ==
              NotificationService.BUTTON_ACTION_LEARNED_TODAY) {
            addDayLearned();
          }
          if (pressedButton ==
              NotificationService.BUTTON_ACTION_NOT_LEARNED_TODAY) {
            addDayNotLearned();
          }
        }
      });
    } catch (e) {
      print(e);
    }
  }

  isDistributedLearningDay() {
    var userData = _dataService.getUserDataCache();
    var daysAgo = getDaysSinceStart();
    var hasSeen = userData.hasSeenDistributedPracticeIntervention;

    return (daysAgo >= 18) && (userData.group == 1) && !hasSeen;
  }

  bool hasCompletedSessionZero() {
    var userData = _dataService.getUserDataCache();
    var group = userData.group;
    var numSteps = SessionZeroViewModel.getScreenOrder(group).length;

    return (userData.initSessionStep > (numSteps - 5));
  }

  Future<bool> isTimeForMorningAssessment() async {
    var lastMorningAssessment =
        await _dataService.getLastAssessmentResultFor(MORNING_ASSESSMENT);

    var userData = _dataService.getUserDataCache();

    // If the user has only registered today, then there should be no assessment yet
    if (userData.registrationDate.isToday()) {
      return false;
    }
    // If there is no last result, none has been submitted, so the first should be done
    if (lastMorningAssessment == null) return true;

    if (lastMorningAssessment.submissionDate.isToday()) {
      return false;
    }

    var daysAgo = getDaysSinceStart();

    return reminderNotificationDays[userData.group]!.contains(daysAgo);
  }

  Future<bool> isTimeForEveningAssessment() async {
    var lastMorningAssessment =
        await _dataService.getLastAssessmentResultFor(MORNING_ASSESSMENT);

    var lastEveningAssessment =
        await _dataService.getLastAssessmentResultFor(EVENING_ASSESSMENT);
    // If there is no prior morning assessment, this should be done first.
    if (lastMorningAssessment == null) return false;
    // If the morning assessment has been completed today
    if (lastMorningAssessment.submissionDate.isToday()) {
      // Check if the evening assessment has been completed today as well
      if (lastEveningAssessment != null) {
        if (lastEveningAssessment.submissionDate.isToday()) {
          return false;
        } else {
          return true;
        }
      }
    }

    return true;
  }

  bool shouldShowDistributedLearningVideo() {
    var ud = _dataService.getUserDataCache();
    var daysAgo = getDaysSinceStart();
    return (ud.group == 1) && (daysAgo == 18);
  }

  InternalisationCondition getInternalisationCondition() {
    var userData = _dataService.getUserDataCache();
    var daysAgo = getDaysSinceStart();

    var condition =
        getInternalisationConditionForGroupAndDay(daysAgo, userData.group);
    return InternalisationCondition.values[condition];
  }

  int getInternalisationConditionForGroupAndDay(int group, int day) {
    var number = (group + day) % InternalisationCondition.values.length;

    return number;
  }

  schedulePrompts(int group) {
    var now = DateTime.now();
    var reminderHour = 5;
    var schedule = DateTime(now.year, now.month, now.day, reminderHour, 00);

    var numReminders = 1;
    for (var day in reminderNotificationDays[group]!) {
      var scheduleDay = schedule.add(Duration(days: day));
      // In order to prevent hour of day skips during winter/summer time, explictly set the hour again
      var scheduleDayWithTime = DateTime(scheduleDay.year, scheduleDay.month,
          scheduleDay.day, reminderHour, 00);
      _notificationService.scheduleMorningReminder(scheduleDayWithTime, day);

      print("Scheduled Reminder ${numReminders++}");
    }
  }

  saveUsageStats() async {
    var startDate = DateTime.now().subtract(Duration(days: 35));
    var endDate = DateTime.now();
    var stats =
        await UsageStatsService.queryUsageStats(startDate, DateTime.now());
    _dataService.saveUsageStats(stats, startDate, endDate);
  }
}
