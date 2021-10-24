import 'dart:io';

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
import 'package:collection/collection.dart';

class ExperimentService {
  static const int NUM_GROUPS = 6;
  static const Duration MAX_STUDY_DURATION = Duration(days: 56);

  final DataService _dataService;
  final NotificationService _notificationService;
  final LoggingService _loggingService;
  final RewardService _rewardService;
  final NavigationService _navigationService;

  // TODO: Schedule according to this
  late Map<int, List<int>> reminderNotificationDays = {
    1: List<int>.generate(54, (int index) => index),
    2: [...List<int>.generate(36, (int index) => index), 45, 54],
    3: [...List<int>.generate(36, (int index) => index), 45, 54],
    4: [...List<int>.generate(36, (int index) => index), 45, 54],
    5: [...List<int>.generate(36, (int index) => index), 45, 54],
    6: [...List<int>.generate(36, (int index) => index), 45, 54],
  };

  final Map<int, List<int>> boosterPrompts = {
    1: [],
    2: [1, 2, 3, 7, 8, 13, 14, 15, 19, 20, 21, 25, 26, 31, 32, 33],
    3: [4, 5, 6, 10, 11, 12, 16, 17, 22, 23, 24, 28, 29, 30, 34, 35],
    4: [],
    5: [1, 2, 3, 7, 8, 13, 14, 15, 19, 20, 21, 25, 26, 31, 32, 33],
    6: [4, 5, 6, 10, 11, 12, 16, 17, 22, 23, 24, 28, 29, 30, 34, 35],
  };

  final Map<int, List<int>> internalisationPrompts = {
    1: [],
    2: [],
    3: [],
    4: [],
    5: [1, 2, 3, 7, 8, 13, 14, 15, 19, 20, 21, 25, 26, 31, 32, 33],
    6: [4, 5, 6, 10, 11, 12, 16, 17, 22, 23, 24, 28, 29, 30, 34, 35],
  };

  final Map<int, List<int>> vocabTestReminder = {
    1: [],
    2: [],
    3: [],
    4: [],
    5: [1, 2, 3, 7, 8, 9, 13, 14, 15, 19, 20, 21, 25, 26, 27, 31, 32, 33],
    6: [4, 5, 6, 10, 11, 12, 16, 17, 18, 22, 23, 24, 28, 29, 30, 34, 35, 36],
  };

  final Map<int, int> finalAssessmentDay = {
    1: 36,
    2: 36,
    3: 36,
    4: 36,
    5: 36,
    6: 54,
  };

  final List<int> vocabTestDays = [9, 18, 27, 36, 45, 54];

  ExperimentService(this._dataService, this._notificationService,
      this._loggingService, this._rewardService, this._navigationService);

  nextScreen(String currentScreen) async {
    if (currentScreen == RouteNames.SESSION_ZERO) {
      if (Platform.isAndroid) {
        UsageStatsService.grantUsagePermission();
      }
      return await _navigationService.navigateTo(RouteNames.NO_TASKS);
    }

    if (currentScreen == RouteNames.ASSESSMENT_EVENING) {
      await _navigationService.navigateTo(RouteNames.NO_TASKS);
    }

    if (currentScreen == RouteNames.ASSESSMENT_FINAL) {
      await _navigationService.navigateTo(RouteNames.NO_TASKS);
    }

    if (currentScreen == RouteNames.ASSESSMENT_MORNING) {
      if (isFinalAssessmentDay()) {
        return await _navigationService.navigateTo(RouteNames.ASSESSMENT_FINAL);
      }
      if (isLastVocabTestDay()) {
        return await _navigationService.navigateTo(RouteNames.STUDY_COMPLETE);
      } else {
        return await _navigationService.navigateTo(RouteNames.NO_TASKS);
      }
    }

    if (currentScreen == RouteNames.ASSESSMENT_EVENING) {
      if (isTimeForFinalQuestionnaire()) {
        return await _navigationService.navigateTo(RouteNames.ASSESSMENT_FINAL);
      }
    }
  }

  DateTime getNextVocabTestDate() {
    var daysAgo = _dataService.getUserDataCache().registrationDate.daysAgo();
    for (var day in vocabTestDays) {
      if (day > daysAgo) {
        return DateTime.now().add(Duration(days: day - daysAgo));
      }
    }
    return DateTime.now();
  }

  bool isFinalAssessmentDay() {
    var daysSince = getDaysSinceStart();
    var group = _dataService.getUserDataCache().group;
    return finalAssessmentDay[group] == daysSince;
  }

  bool isVocabTestDay() {
    return vocabTestDays.contains(getDaysSinceStart());
  }

  bool wasVocabDayYesterday() {
    return vocabTestDays.contains(getDaysSinceStart() + 1);
  }

  bool didCompletePreVocabToday() {
    var last =
        _dataService.getLastAssessmentResultForCached("preVocabCompleted");

    if (last == null) return false;

    return (last.submissionDate.isToday());
  }

  int getDaysSinceStart() {
    var ud = _dataService.getUserDataCache();
    return ud.registrationDate.daysAgo();
  }

  Future<bool> _shouldIncrementStreakDay() async {
    var lastRecall =
        await _dataService.getLastAssessmentResultFor(MORNING_ASSESSMENT);
    if (lastRecall == null) {
      var userData = await _dataService.getUserData();
      return userData!.registrationDate.isYesterday();
    }

    return lastRecall.submissionDate.isYesterday();
  }

  Future<void> submitAssessment(
      AssessmentResult assessment, String type) async {
    this._dataService.saveAssessment(assessment);

    if (type == MORNING_ASSESSMENT) {
      if (await _shouldIncrementStreakDay()) {
        await _rewardService.addStreakDays(1);
      } else {
        await _rewardService.clearStreakDays();
      }
      await _rewardService.onMorningAssessment();

      if (Platform.isAndroid) {
        saveUsageStats();
      }
    }
  }

  bool isLastVocabTestDay() {
    return getDaysSinceStart() == vocabTestDays.last;
  }

  bool isFirstDay() {
    var userData = _dataService.getUserDataCache();
    var daysAgo = userData.registrationDate.daysAgo();

    return daysAgo == 1;
  }

  isBoosterPromptDay() {
    var userData = _dataService.getUserDataCache();
    var daysAgo = userData.registrationDate.daysAgo();

    return boosterPrompts[userData.group]!.contains(daysAgo);
  }

  isInternalisationDay() {
    var userData = _dataService.getUserDataCache();
    var daysAgo = userData.registrationDate.daysAgo();

    return internalisationPrompts[userData.group]!.contains(daysAgo);
  }

  isDistributedLearningDay() {
    var userData = _dataService.getUserDataCache();
    var daysAgo = userData.registrationDate.daysAgo();

    return (daysAgo == 18) && (userData.group == 1);
  }

  bool isTimeForFinalQuestionnaire() {
    var userData = _dataService.getUserDataCache();
    var daysAgo = userData.registrationDate.daysAgo();

    return daysAgo == MAX_STUDY_DURATION.inDays;
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

    var daysAgo = userData.registrationDate.daysAgo();

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
    var daysAgo = ud.registrationDate.daysAgo();
    return (ud.group == 1) && (daysAgo == 18);
  }

  InternalisationCondition getInternalisationCondition() {
    var userData = _dataService.getUserDataCache();
    var daysAgo = userData.registrationDate.daysAgo();

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

    for (var i = 1; i <= MAX_STUDY_DURATION.inDays; i++) {
      var scheduleDay = schedule.add(Duration(days: i));
      // In order to prevent hour of day skips during winter/summer time, explictly set the hour again
      var scheduleDayWithTime = DateTime(scheduleDay.year, scheduleDay.month,
          scheduleDay.day, reminderHour, 00);
      _notificationService.scheduleMorningReminder(scheduleDayWithTime, i);
    }

    scheduleFinalTaskReminder();
  }

  scheduleFinalTaskReminder() {
    var dayAfterFinal =
        DateTime.now().add(ExperimentService.MAX_STUDY_DURATION);
    print(
        "scheduling final task reminder for ${dayAfterFinal.toIso8601String()}");
    _notificationService.scheduleFinalTaskReminder(dayAfterFinal);
  }

  saveUsageStats() async {
    var startDate = DateTime.now().subtract(Duration(days: 35));
    var endDate = DateTime.now();
    var stats =
        await UsageStatsService.queryUsageStats(startDate, DateTime.now());
    _dataService.saveUsageStats(stats, startDate, endDate);
  }
}
