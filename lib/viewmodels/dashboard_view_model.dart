import 'dart:async';

import 'package:prompt/services/data_service.dart';
import 'package:prompt/services/experiment_service.dart';
import 'package:prompt/services/navigation_service.dart';
import 'package:prompt/viewmodels/base_view_model.dart';

class DashboardViewModel extends BaseViewModel {
  final ExperimentService _experimentService;
  final DataService _dataService;
  final NavigationService _navigationService;
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

  late int daysActive = _experimentService.getDaysSinceStart();

  double _timerGoalInSeconds = 5;
  double get timerGoalSeconds => _timerGoalInSeconds;
  set timerGoalSeconds(double timerGoal) {
    _timerGoalInSeconds = timerGoal;
    notifyListeners();
  }

  double timerProgressSeconds = 0;

  DashboardViewModel(
      this._experimentService, this._dataService, this._navigationService);

  int getMaxStudyDays() {
    var group = _dataService.getUserDataCache().group;
    return _experimentService.finalAssessmentDay[group]!;
  }

  Future<void> initialize() async {
    await _dataService.getAssessmentResults();
  }

  Future<bool> getNextTask() async {
    await initialize();

    return false;
  }

  addDaysLearned(int days) {
    daysActive += days;
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
