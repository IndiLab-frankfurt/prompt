import 'dart:io';
import 'package:prompt/models/questionnaire_response.dart';
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

class StudyService {
  static const int NUM_GROUPS = 7;
  static const Duration MAX_STUDY_DURATION = Duration(days: 56);

  final DataService _dataService;
  final NotificationService _notificationService;
  final LoggingService _loggingService;
  final RewardService _rewardService;
  final NavigationService _navigationService;

  final List<int> vocabTestDays = [9, 18, 27, 36, 45, 54];

  StudyService(this._dataService, this._notificationService,
      this._loggingService, this._rewardService, this._navigationService);

  getNextState(StudyState currentState) {
    print(currentState.toString());
  }

  nextScreen(String currentScreen) async {
    if (currentScreen == RouteNames.SESSION_ZERO) {
      if (Platform.isAndroid) {
        UsageStatsService.grantUsagePermission();
      }
      return await _navigationService
          .navigateWithReplacement(RouteNames.NO_TASKS);
    }

    if (currentScreen == RouteNames.ASSESSMENT_EVENING) {
      await _navigationService.navigateTo(RouteNames.NO_TASKS);
    }

    if (currentScreen == RouteNames.ASSESSMENT_FINAL) {
      await _navigationService.navigateTo(RouteNames.NO_TASKS);
    }

    if (currentScreen == RouteNames.ASSESSMENT_MORNING) {
      return await _navigationService.navigateTo(RouteNames.NO_TASKS);
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

  bool isVocabTestDay() {
    return vocabTestDays.contains(getDaysSinceStart());
  }

  bool wasVocabDayYesterday() {
    return vocabTestDays.contains(getDaysSinceStart() - 1);
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

  Future<void> submitResponses(
      List<QuestionnaireResponse> responses, String type) async {
    await this._dataService.saveQuestionnaireResponses(responses);

    if (type == MORNING_ASSESSMENT) {
      if (_shouldIncrementStreakDay()) {
        await _rewardService.addStreakDays(1);
      } else {
        await _rewardService.clearStreakDays();
      }
      await _rewardService.onMorningAssessment();
    }
  }

  bool isLastVocabTestDay() {
    return getDaysSinceStart() == vocabTestDays.last;
  }

  int getNextVocabListNumber() {
    var listNumber = getDaysSinceStart() ~/ 9;
    return listNumber;
  }

  bool isFirstDay() {
    var daysAgo = getDaysSinceStart();

    return daysAgo == 1;
  }

  isTimeForFinalQuestions() {
    return false;
  }

  isDistributedLearningDay() {
    var userData = _dataService.getUserDataCache();
    var daysAgo = getDaysSinceStart();

    return (daysAgo >= 18) && (userData.group == "1");
  }

  bool shouldShowDistributedLearningVideo() {
    var ud = _dataService.getUserDataCache();
    var daysAgo = getDaysSinceStart();
    return (ud.group == "1") && (daysAgo == 18);
  }

  scheduleFinalTaskReminder() {
    var dayAfterFinal = DateTime.now().add(StudyService.MAX_STUDY_DURATION);
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
