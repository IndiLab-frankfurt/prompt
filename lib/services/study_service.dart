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

  final DataService _dataService;
  final NotificationService _notificationService;
  final LoggingService _loggingService;
  final RewardService _rewardService;
  final NavigationService _navigationService;

  final List<int> vocabTestDays = [21, 42, 63];

  StudyService(this._dataService, this._notificationService,
      this._loggingService, this._rewardService, this._navigationService);

  nextScreen() async {
    var currentScreen = _navigationService.getRouteName();
    if (currentScreen?.isEmpty ?? true) {
      _loggingService
          .logError("nextScreen called with empty current route name");
      currentScreen = AppScreen.Mainscreen.name;
    }
    return await nextScreenForScreenName(currentScreen!);
  }

  Future<dynamic> nextScreenForScreenName(String currentScreen) async {
    try {
      var nextState = await _dataService.getNextState(currentScreen);
      return await _navigationService.navigateTo(nextState);
    } catch (e) {
      _loggingService.logError("Error trying to navigate to next state",
          data: "Error getting next state: $e");
    }
  }

  DateTime getNextVocabTestDate() {
    var daysAgo = getDaysSinceStart();
    for (var day in vocabTestDays) {
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
    var responseData =
        await this._dataService.saveQuestionnaireResponses(responses);
    var score = responseData["score"];
    if (score > 0) {
      this._rewardService.addPoints(score);
      locator<DialogService>().showRewardDialog(title: "", score: score);
    }
  }

  Future onboardingComplete() async {
    await _scheduleFinalTaskReminder();
    await _scheduleVocabReminders();
    this._rewardService.addPoints(5);
    locator<DialogService>().showRewardDialog(title: "", score: 5);
  }

  bool isLastVocabTestDay() {
    return getDaysSinceStart() == vocabTestDays.last;
  }

  scheduleDailyReminders(TimeOfDay dailyReminderTime) async {
    var userData = _dataService.getUserDataCache();
    // check how many reminders we have to schedule
    var daysAgo = getDaysSinceStart();
    var toSchedule = DAILY_USE_DURATION.inDays - daysAgo;
    for (var i = 0; i <= toSchedule; i++) {
      var reminderDate = userData.startDate!.add(Duration(days: i));
      var reminderDateTime = DateTime(reminderDate.year, reminderDate.month,
          reminderDate.day, dailyReminderTime.hour, dailyReminderTime.minute);
      await _notificationService.deleteDailyReminderWithId(i);
      _notificationService.scheduleDailyReminder(reminderDateTime, i);
    }
  }

  _scheduleFinalTaskReminder() async {
    var dayAfterFinal = DateTime.now().add(StudyService.FULL_STUDY_DURATION);
    print(
        "scheduling final task reminder for ${dayAfterFinal.toIso8601String()}");
    _notificationService.scheduleFinalTaskReminder(dayAfterFinal);
  }

  _scheduleVocabReminders() async {
    // schedule three vocab reminders: 21, 42, 63 days after start
    for (var day in vocabTestDays) {
      var reminderDate = DateTime.now().add(Duration(days: day));
      await _notificationService.scheduleVocabTestReminder(reminderDate);
    }
  }
}
