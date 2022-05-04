import 'dart:async';

import 'package:prompt/services/data_service.dart';
import 'package:prompt/services/experiment_service.dart';
import 'package:prompt/services/navigation_service.dart';
import 'package:prompt/shared/extensions.dart';
import 'package:prompt/viewmodels/base_view_model.dart';

enum OpenTasks {
  LearnVocabulary,
  ViewDistributedLearning,
  ViewMentalContrasting
}

class DashboardViewModel extends BaseViewModel {
  final ExperimentService _experimentService;
  final DataService _dataService;
  final NavigationService _navigationService;
  int daysActive = 0;
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

  List<OpenTasks> openTasks = [
    OpenTasks.LearnVocabulary,
    OpenTasks.ViewDistributedLearning,
    OpenTasks.ViewMentalContrasting
  ];

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
      this._experimentService, this._dataService, this._navigationService);

  int getMaxStudyDays() {
    var group = _dataService.getUserDataCache().group;
    return _experimentService.finalAssessmentDay[group]!;
  }

  Future<bool> initialize() async {
    await Future.wait([_dataService.getDatesLearned()]);

    var datesLearned = await _dataService.getDatesLearned();
    hasLearnedToday = datesLearned.length > 0 && datesLearned.last.isToday();
    daysActive = datesLearned.length;

    return true;
  }

  addDaysLearned(int days) async {
    daysActive += days;

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
