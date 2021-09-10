import 'package:prompt/models/assessment_result.dart';
import 'package:prompt/services/data_service.dart';
import 'package:prompt/services/logging_service.dart';
import 'package:prompt/services/navigation_service.dart';
import 'package:prompt/services/notification_service.dart';
import 'package:prompt/services/reward_service.dart';
import 'package:prompt/shared/enums.dart';
import 'package:prompt/shared/route_names.dart';
import 'package:prompt/shared/extensions.dart';

class ExperimentService {
  static const int NUM_GROUPS = 6;
  static const Duration MAX_STUDY_DURATION = Duration(days: 36);

  final DataService _dataService;
  final NotificationService _notificationService;
  final LoggingService _loggingService;
  final RewardService _rewardService;
  final NavigationService _navigationService;

  final Map<int, List<int>> boosterPrompts = {
    1: [],
    2: [1, 2, 3, 7, 8, 9, 13, 14, 15, 19, 20, 21, 25, 26, 27, 31, 32, 33],
    3: [4, 5, 6, 10, 11, 12, 16, 17, 18, 22, 23, 24, 28, 29, 30, 34, 35, 36],
    4: [],
    5: [1, 2, 3, 7, 8, 9, 13, 14, 15, 19, 20, 21, 25, 26, 27, 31, 32, 33],
    6: [4, 5, 6, 10, 11, 12, 16, 17, 18, 22, 23, 24, 28, 29, 30, 34, 35, 36],
  };

  final Map<int, List<int>> internalisationPrompts = {
    1: [],
    2: [],
    3: [],
    4: [],
    5: [1, 2, 3, 7, 8, 9, 13, 14, 15, 19, 20, 21, 25, 26, 27, 31, 32, 33],
    6: [4, 5, 6, 10, 11, 12, 16, 17, 18, 22, 23, 24, 28, 29, 30, 34, 35, 36],
  };

  ExperimentService(this._dataService, this._notificationService,
      this._loggingService, this._rewardService, this._navigationService);

  nextScreen(String currentScreen) async {
    if (currentScreen == RouteNames.SESSION_ZERO ||
        currentScreen == RouteNames.ASSESSMENT_EVENING ||
        currentScreen == RouteNames.ASSESSMENT_MORNING) {
      return await _navigationService.navigateTo(RouteNames.NO_TASKS);
    }

    if (currentScreen == RouteNames.ASSESSMENT_EVENING) {
      if (isTimeForFinalQuestionnaire()) {
        return await _navigationService.navigateTo(RouteNames.ASSESSMENT_FINAL);
      }
    }
  }

  Future<bool> _shouldIncrementStreakDay() async {
    var lastRecall =
        await _dataService.getLastAssessmentResultFor("morningAssessment");
    if (lastRecall == null) {
      var userData = await _dataService.getUserData();
      return userData!.registrationDate.isYesterday();
    }

    return lastRecall.submissionDate.isYesterday();
  }

  Future<void> submitAssessment(
      AssessmentResult assessment, String type) async {
    this._dataService.saveAssessment(assessment);

    if (type == "morningAssessment") {
      await _rewardService.addStreakDays(1);
    }
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

  shouldShowDistributedLearningVideo() {
    var userData = _dataService.getUserDataCache();
    var daysAgo = userData.registrationDate.daysAgo();

    return daysAgo == 18;
  }

  bool isTimeForFinalQuestionnaire() {
    var userData = _dataService.getUserDataCache();
    var daysAgo = userData.registrationDate.daysAgo();

    return daysAgo == MAX_STUDY_DURATION.inDays;
  }

  Future<bool> isTimeForMorningAssessment() async {
    var last = await _dataService.getLastAssessmentResult();

    var userData = _dataService.getUserDataCache();

    // If the user has only registered today, then there should be no assessment yet
    if (userData.registrationDate.isToday()) {
      return false;
    }
    // If there is no last result, none has been submitted, so the first should be done
    if (last == null) return true;

    if (last.submissionDate.isToday()) {
      // If morning questions have already been submitted
      if (last.assessmentType == "morningAssessment") {
        return false;
      } else {
        return true;
      }
    }

    return true;
  }

  Future<bool> isTimeForEveningAssessment() async {
    var last = await _dataService.getLastAssessmentResult();

    // If there is no last result, none has been submitted, so the first should be done
    if (last == null) return false;

    if (last.submissionDate.isToday()) {
      // If morning questions have already been submitted today
      if (last.assessmentType == "morningAssessment") {
        return false;
      }
      // If Evening assessment has already been submitted today
      if (last.assessmentType == "eveningAssessment") {
        return false;
      } else {
        return true;
      }
    }

    return true;
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
    var schedule = DateTime(now.year, now.month, now.day, 5, 00);

    for (var i = 1; i <= MAX_STUDY_DURATION.inDays; i++) {
      var scheduleDay = schedule.add(Duration(days: i));
      _notificationService.scheduleMorningReminder(scheduleDay, i);
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
}
