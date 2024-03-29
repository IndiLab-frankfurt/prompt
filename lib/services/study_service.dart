import 'package:flutter/material.dart';
import 'package:prompt/models/questionnaire_response.dart';
import 'package:prompt/services/data_service.dart';
import 'package:prompt/services/dialog_service.dart';
import 'package:prompt/services/locator.dart';
import 'package:prompt/services/logging_service.dart';
import 'package:prompt/services/navigation_service.dart';
import 'package:prompt/services/notification_service.dart';
import 'package:prompt/services/reward_service.dart';
import 'package:prompt/shared/enums.dart';
import 'package:prompt/shared/extensions.dart';

class StudyService {
  static const Duration FULL_STUDY_DURATION = Duration(days: 63);
  static const Duration DAILY_USE_DURATION = Duration(days: 42);
  static const List<int> VOCAB_TEST_DAYS = [21, 42, 63];

  final DataService _dataService;
  final NotificationService _notificationService;
  final LoggingService _loggingService;
  final RewardService _rewardService;
  final NavigationService _navigationService;

  StudyService(this._dataService, this._notificationService,
      this._loggingService, this._rewardService, this._navigationService);

  nextScreen() async {
    var currentScreen = _navigationService.getRouteName();
    if (currentScreen?.isEmpty ?? true) {
      _loggingService
          .logError("nextScreen called with empty current route name");
      currentScreen = AppScreen.MAINSCREEN.name;
    }
    return await goToNextStateFromState(currentScreen!);
  }

  Future<AppScreen> getNextState(AppScreen current) async {
    return await _dataService.getNextState(current.name);
  }

  Future<void> goToNextStateFromState(String currentScreen) async {
    try {
      var nextState = await _dataService.getNextState(currentScreen);

      if (nextState == AppScreen.MAINSCREEN) {
        _dataService.getRewardScore(currentScreen).then((scoreValue) async {
          if (scoreValue > 0) {
            this._rewardService.addPointsWithDialog(scoreValue);
          }
        });
      }

      await _navigationService.navigateWithReplacement(nextState);
    } catch (e) {
      _loggingService.logError("Error trying to navigate to next state",
          data: "Error getting next state: $e");
    }
  }

  DateTime getNextVocabTestDate() {
    var daysAgo = getDaysSinceStart();
    for (var day in VOCAB_TEST_DAYS) {
      if (day > daysAgo) {
        return DateTime.now().add(Duration(days: day - daysAgo));
      }
    }
    return DateTime.now();
  }

  int getDaysSinceStart() {
    var regDate = _dataService.getUserDataCache().startDate;
    if (regDate == null) {
      return 0;
    }
    var compareDate =
        DateTime(regDate.year, regDate.month, regDate.day, 12, 0, 0);
    var daysAgo = compareDate.daysAgo();
    return daysAgo;
  }

  Future<void> submitResponses(List<QuestionnaireResponse> responses) async {
    await this._dataService.saveQuestionnaireResponses(responses);
  }

  Future onboardingComplete() async {
    await _scheduleFinalTaskReminder();
    await scheduleVocabReminders();
    this._rewardService.addPoints(5);
    _dataService.saveScore(this._rewardService.scoreValue);
    locator<DialogService>().showRewardDialog(title: "", score: 5);
  }

  bool isLastVocabTestDay() {
    return getDaysSinceStart() == VOCAB_TEST_DAYS.last;
  }

  List<DateTime> getDailyScheduleTimes(DateTime dailyReminderTime) {
    // Determine how many reminders we need to schedule
    // by looking at the days since start and the duration of the study
    var daysAgo = getDaysSinceStart();
    var toSchedule = DAILY_USE_DURATION.inDays - daysAgo;

    var nowTime = TimeOfDay.now();

    // However, if it is still before the daily reminder time, we need to schedule one reminder today
    if (toSchedule > 0 &&
        daysAgo > 0 &&
        nowTime.hour < dailyReminderTime.hour) {
      toSchedule++;
    }

    // If the first schedule is for today, this should be zero
    var firstSchedule = 0;

    // check if we are already past the daily reminder time, if that is the case,
    // we need to schedule the first reminder for tomorrow
    // Moreover, if the study started only today, then the first reminder also needs to be tomorrow

    var shouldScheduleFirstReminderToday =
        dailyReminderTime.hour > nowTime.hour ||
            (dailyReminderTime.hour == nowTime.hour &&
                dailyReminderTime.minute > nowTime.minute) ||
            daysAgo == 0;
    if (!shouldScheduleFirstReminderToday) {
      firstSchedule = 1;
    }

    var times = <DateTime>[];
    var today = DateTime.now();

    for (var i = 0; i < toSchedule; i++) {
      var reminderDate = today.add(Duration(days: i + firstSchedule));
      var reminderDateTime = DateTime(reminderDate.year, reminderDate.month,
          reminderDate.day, dailyReminderTime.hour, dailyReminderTime.minute);
      times.add(reminderDateTime);
    }

    return times;
  }

  scheduleDailyReminders(DateTime dailyReminderTime) async {
    var scheduleTimes = getDailyScheduleTimes(dailyReminderTime);
    for (var i = 0; i < scheduleTimes.length; i++) {
      await _notificationService.deleteDailyReminderWithId(i);
      _notificationService.scheduleDailyReminder(scheduleTimes[i], i);
    }
  }

  _scheduleFinalTaskReminder() async {
    var dayAfterFinal = DateTime.now().add(StudyService.FULL_STUDY_DURATION);
    var scheduleDate = DateTime(
        dayAfterFinal.year, dayAfterFinal.month, dayAfterFinal.day, 18, 00);

    print(
        "scheduling final task reminder for ${scheduleDate.toIso8601String()}");
    await _notificationService.scheduleFinalTaskReminder(scheduleDate);
  }

  List<DateTime> getVocabScheduleTimes() {
    var times = <DateTime>[];
    for (var i = 0; i < VOCAB_TEST_DAYS.length; i++) {
      var day = VOCAB_TEST_DAYS[i];
      var reminderDate = DateTime.now().add(Duration(days: day));
      var reminderDateTime = DateTime(
          reminderDate.year, reminderDate.month, reminderDate.day, 6, 00);
      times.add(reminderDateTime);
    }
    return times;
  }

  scheduleVocabReminders() async {
    var scheduleTimes = getVocabScheduleTimes();
    // schedule three vocab reminders: 21, 42, 63 days after start
    for (var i = 0; i < scheduleTimes.length; i++) {
      await _notificationService.deleteVocabReminderWithId(i);
      await _notificationService.scheduleVocabTestReminder(scheduleTimes[i], i);
    }
  }
}
