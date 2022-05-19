import 'dart:async';
import 'package:prompt/models/value_with_date.dart';
import 'package:prompt/services/data_service.dart';
import 'package:prompt/services/experiment_service.dart';
import 'package:prompt/services/reward_service.dart';
import 'package:prompt/shared/enums.dart';
import 'package:prompt/viewmodels/base_view_model.dart';

class DashboardViewModel extends BaseViewModel {
  final ExperimentService _experimentService;
  final DataService _dataService;
  final RewardService _rewardService;
  int daysLearned = 0;
  int daysNotLearned = 0;
  Timer? timer;

  bool _showTimerConfiguration = false;
  bool get showTimerConfiguration => _showTimerConfiguration;
  set showTimerConfiguration(bool showTimerConfiguration) {
    _showTimerConfiguration = showTimerConfiguration;
    notifyListeners();
  }

  bool _showTimerControls = false;
  bool get showTimerControls => _showTimerControls;
  set showTimerControls(bool showTimerControls) {
    _showTimerControls = showTimerControls;
    notifyListeners();
  }

  bool _showDaysLearned = true;
  bool get showDaysLearned => _showDaysLearned;
  set showDaysLearned(bool showDaysLearned) {
    _showDaysLearned = showDaysLearned;
    notifyListeners();
  }

  bool _hasLearnedToday = false;
  bool get hasLearnedToday => _hasLearnedToday;
  set hasLearnedToday(bool value) {
    _hasLearnedToday = value;
    notifyListeners();
  }

  double _timerGoalInSeconds = 5;
  double get timerGoalSeconds => _timerGoalInSeconds;
  set timerGoalSeconds(double timerGoal) {
    _timerGoalInSeconds = timerGoal;
    notifyListeners();
  }

  List<OpenTasks> openTasks = [];

  addTask(OpenTasks task) {
    if (!openTasks.contains(task)) {
      openTasks.add(task);
      notifyListeners();
    }
  }

  removeTask(OpenTasks task) {
    if (openTasks.contains(task)) {
      openTasks.remove(task);
      notifyListeners();
    }
  }

  double timerProgressSeconds = 0;

  DashboardViewModel(
      this._experimentService, this._dataService, this._rewardService);

  Future<bool> initialize() async {
    OpenTasks? openTask;
    late List<ValueWithDate> datesLearned;

    await Future.wait([
      _dataService.getDatesLearned().then((dl) => datesLearned = dl),
      _experimentService.getOpenTask().then((res) => openTask = res),
      _experimentService.hasLearnedToday().then((res) => hasLearnedToday = res),
    ]);

    var sevenDaysAgo = DateTime.now().subtract(Duration(days: 7));
    daysLearned = _datesLearnedSince(datesLearned, sevenDaysAgo, true);
    daysNotLearned = _datesLearnedSince(datesLearned, sevenDaysAgo, false);

    if (openTask == OpenTasks.ViewDistributedLearning) {
      addTask(OpenTasks.ViewDistributedLearning);
    }
    if (openTask == OpenTasks.ViewMentalContrasting) {
      addTask(OpenTasks.ViewMentalContrasting);
    }
    if (openTask == OpenTasks.LearningTip) {
      addTask(OpenTasks.LearningTip);
    }

    return true;
  }

  List<int> getPendingRewards() {
    return _rewardService.pendingRewardNotifications;
  }

  void clearPendingRewards() {
    return _rewardService.pendingRewardNotifications.clear();
  }

  _datesLearnedSince(
      List<ValueWithDate> datesLearned, DateTime date, hasLearned) {
    // Count how many dates have been learned since the given date
    return datesLearned
        .where((element) =>
            element.date.isAfter(date) && element.value == hasLearned)
        .length;
  }

  addDaysLearned(int days) async {
    daysLearned += days;

    _experimentService.addDayLearned();

    hasLearnedToday = true;

    notifyListeners();
  }

  startTimer(duration) {
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
      timerProgressSeconds += 1;
      notifyListeners();
      if (timerProgressSeconds >= timerGoalSeconds) {
        t.cancel();
        timerProgressSeconds = 0;
      }
    });
  }

  pauseTimer() {
    timer?.cancel();
  }

  stopTimer() {
    timer?.cancel();
    timerProgressSeconds = 0;
    timer = null;
    notifyListeners();
  }
}
