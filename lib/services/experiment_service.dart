import 'dart:math';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:prompt/data/learning_tips.dart';
import 'package:prompt/models/assessment_result.dart';
import 'package:prompt/models/learning_tip.dart';
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

  ExperimentService(this._dataService, this._notificationService,
      this._loggingService, this._rewardService, this._navigationService);

  Future onSessionZeroComplete() async {
    var now = DateTime.now();
    var dt = DateTime(now.year, now.month, now.day, 18, 0, 0);

    _notificationService
        .scheduleDailyReminder(dt, NotificationService.ID_DAILY)
        .then((_) => {scheduleNextPlanReminder()});
  }

  Future scheduleNextPlanReminder() async {
    var now = DateTime.now();
    var random = Random().nextInt(4) + 4;
    var duration = Duration(days: random);
    var planReminderSchedule = now.add(duration);
    await _notificationService.schedulePlanReminder(planReminderSchedule);
  }

  Future onDistributedLearningComplete() async {
    _rewardService.addPoints(20);
    await onLearningTrickComplete("distributedLearning");
    await _dataService.saveSimpleValueWithTimestamp(
        "distributedLearning", "distributedLearning");
  }

  Future onMentalContrastingComplete() async {
    _rewardService.addPoints(20);
    await onLearningTrickComplete("mentalContrasting");
    await _dataService.saveSimpleValueWithTimestamp(
        "mentalContrasting", "mentalContrasting");
  }

  Future onLearningTipComplete(LearningTip learningTip) async {
    _rewardService.addPoints(20);
    await onLearningTrickComplete(learningTip.id);
    await _dataService.saveSimpleValueWithTimestamp(
        learningTip.id, "learningTipsSeen");
  }

  Future onLearningTrickComplete(String typeOfTrick) async {
    await _dataService.saveSimpleValueWithTimestamp(
        typeOfTrick, "learningTricksSeen");
  }

  Future onPlanReminderComplete(String planInput) async {
    await _dataService.saveSimpleValueWithTimestamp(planInput, "planReminders");
  }

  Future<OpenTasks?> getOpenTask() async {
    // First, check if the last learning Trick was seen at least one day ago
    var learningTrickSeen =
        await _dataService.getValuesWithDates("learningTricksSeen");
    if (learningTrickSeen.length > 0 && learningTrickSeen.last.date.isToday()) {
      return null;
    }

    if (await isDistributedLearningDay()) {
      return OpenTasks.ViewDistributedLearning;
    }

    if (await isMentalContrastingDay()) {
      return OpenTasks.ViewMentalContrasting;
    }

    if (await isLearningTipDay()) {
      return OpenTasks.LearningTip;
    }

    return null;
  }

  Future nextScreen(String currentScreen) async {
    if (currentScreen == RouteNames.SESSION_ZERO) {
      return await _navigationService
          .navigateWithReplacement(RouteNames.NO_TASKS);
    } else if (currentScreen == RouteNames.ASSESSMENT_EVENING) {
      return await _navigationService.navigateTo(RouteNames.NO_TASKS);
    } else if (currentScreen == RouteNames.ASSESSMENT_FINAL) {
      return await _navigationService.navigateTo(RouteNames.NO_TASKS);
    } else if (currentScreen == RouteNames.ASSESSMENT_MORNING) {
      return await _navigationService.navigateTo(RouteNames.NO_TASKS);
    } else if (currentScreen == RouteNames.EDIT_PLAN) {
      return await _navigationService.navigateTo(RouteNames.NO_TASKS);
    } else if (currentScreen == RouteNames.NO_TASKS) {
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
      _rewardService.addPoints(2)
    ]);
  }

  Future<void> addDayNotLearned() async {
    await Future.wait(<Future>[
      _dataService.saveDateLearned(DateTime.now(), false),
      _rewardService.addPoints(2)
    ]);
  }

  Future<LearningTip> getCurrentLearningTip() async {
    var learningTipsSeen =
        await _dataService.getValuesWithDates("learningTipsSeen");

    if (learningTipsSeen.length == 0) {
      return LearningTips[0];
    }

    var lastLearningTip = learningTipsSeen.last;
    var index = learningTipsSeen.indexOf(lastLearningTip);

    // If we have seen all learning tips, we return a random learning tip instead
    if (index == -1 || index == LearningTips.length - 1) {
      // return a random learning tip
      return LearningTips[Random().nextInt(LearningTips.length)];
    }

    return LearningTips[index + 1];
  }

  void reactToNotifications(context) {
    // AwesomeNotifications().setListeners(
    //     onActionReceivedMethod: onActionNotification,
    //     onDismissActionReceivedMethod: onNotificationDismissed);

    try {
      AwesomeNotifications()
          .actionStream
          .listen((ReceivedNotification receivedNotification) {
        print('Received notification ${receivedNotification.title}');
        _loggingService
            .logEvent("Received notification ${receivedNotification.title}");
        if (receivedNotification is ReceivedAction) {
          onActionNotification(receivedNotification);
        }
        if (receivedNotification.id == NotificationService.ID_PLAN_REMINDER) {
          onPlanReminderNotificationClicked();
        }
      });
    } catch (e) {
      print(e);
    }

    try {
      AwesomeNotifications().dismissedStream.listen((dismissedNotification) {
        print('Dismissed notification ${dismissedNotification.title}');

        if (dismissedNotification.id == NotificationService.ID_PLAN_REMINDER) {
          scheduleNextPlanReminder();
        }
      });
    } catch (e) {}
  }

  // Future<void> onActionReceived(ReceivedAction action) async {}

  //   try {
  //     AwesomeNotifications()
  //         .actionStream
  //         .listen((ReceivedNotification receivedNotification) {
  //       print('Received notification ${receivedNotification.title}');
  //       _loggingService
  //           .logEvent("Received notification ${receivedNotification.title}");
  //       if (receivedNotification is ReceivedAction) {
  //         onActionNotification(receivedNotification);
  //       }
  //       if (receivedNotification.id == NotificationService.ID_PLAN_REMINDER) {
  //         onPlanReminderNotificationClicked();
  //       }
  //     });
  //   } catch (e) {
  //     print(e);
  //   }

  //   try {
  //     AwesomeNotifications().dismissedStream.listen((dismissedNotification) {
  //       print('Dismissed notification ${dismissedNotification.title}');

  //       if (dismissedNotification.id == NotificationService.ID_PLAN_REMINDER) {
  //         scheduleNextPlanReminder();
  //       }
  //     });
  //   } catch (e) {}
  // }

  Future<void> onNotificationDismissed(ReceivedAction action) async {
    if (action.id == NotificationService.ID_PLAN_REMINDER) {
      scheduleNextPlanReminder();
    }
  }

  Future<void> onActionNotification(ReceivedAction receivedAction) async {
    var pressedButton = receivedAction.buttonKeyPressed;

    if (pressedButton == NotificationService.BUTTON_ACTION_LEARNED_TODAY) {
      if (!await hasLearnedToday()) {
        addDayLearned();
      }

      return await _navigationService.navigateTo(RouteNames.NO_TASKS);
    }
    if (pressedButton == NotificationService.BUTTON_ACTION_NOT_LEARNED_TODAY) {
      return await _navigationService.navigateTo(RouteNames.NO_TASKS);
    }
  }

  Future<bool> hasLearnedToday() async {
    var datesLearned = await _dataService.getDatesLearned();
    var hasLearnedToday = datesLearned.length > 0 &&
        datesLearned.last.date.isToday() &&
        datesLearned.last.value == true;
    return hasLearnedToday;
  }

  onPlanReminderNotificationClicked() async {
    scheduleNextPlanReminder().then((value) {
      _loggingService.logEvent("Scheduled next plan reminder");
      _navigationService.navigateTo(RouteNames.PLAN_REMINDER);
    });
  }

  Future<bool> isDistributedLearningDay() async {
    var distributedLearnings =
        await _dataService.getValuesWithDates("distributedLearning");
    if (distributedLearnings.length == 0) {
      return true;
    }

    return false;
  }

  Future<bool> isLearningTipDay() async {
    var learningTipsSeen =
        await _dataService.getValuesWithDates("learningTipsSeen");
    if (learningTipsSeen.length < LearningTips.length) {
      if (learningTipsSeen.length > 0) {
        // Only one learning tip per day
        return !learningTipsSeen.last.date.isToday();
      }
      return true;
    }

    return false;
  }

  Future<bool> isMentalContrastingDay() async {
    var mentalContrastings =
        await _dataService.getValuesWithDates("mentalContrasting");
    if (mentalContrastings.length == 0) {
      return true;
    }

    var daysAgo = mentalContrastings.last.date.daysAgo();

    // TODO: Find actual interval
    return daysAgo >= 14;
  }

  Future<bool> isUsabilityDay() async {
    var planReminders = await _dataService.getValuesWithDates("planReminders");

    return (planReminders.length == 0 || planReminders.length == 2);
  }

  Future<bool> isEfficacyQuestionsDay() async {
    var planReminders = await _dataService.getValuesWithDates("planReminders");

    return (planReminders.length == 1 || planReminders.length == 3);
  }

  bool hasCompletedSessionZero() {
    var userData = _dataService.getUserDataCache();
    var group = userData.group;
    var numSteps = SessionZeroViewModel.getScreenOrder(group).length;

    return (userData.initSessionStep > (numSteps - 5));
  }

  saveUsageStats() async {
    var startDate = DateTime.now().subtract(Duration(days: 35));
    var endDate = DateTime.now();
    var stats =
        await UsageStatsService.queryUsageStats(startDate, DateTime.now());
    _dataService.saveUsageStats(stats, startDate, endDate);
  }
}
