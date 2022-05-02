import 'dart:async';

import 'package:prompt/services/data_service.dart';
import 'package:prompt/services/experiment_service.dart';
import 'package:prompt/services/navigation_service.dart';
import 'package:prompt/shared/extensions.dart';
import 'package:prompt/viewmodels/base_view_model.dart';

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

  bool _showHabitButton = true;
  bool get showHabitButton => _showHabitButton;
  set showHabitButton(bool value) {
    _showHabitButton = value;
    notifyListeners();
  }

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

  Future<bool> initialize() async {
    await Future.wait([_dataService.getDatesLearned()]);

    var datesLearned = await _dataService.getDatesLearned();
    if (datesLearned != null) {
      showHabitButton = !datesLearned.last.isToday();
      daysActive = datesLearned.length;
    } else {
      showHabitButton = true;
      daysActive = 0;
    }

    return true;
  }

  addDaysLearned(int days) async {
    daysActive += days;

    await _dataService.saveDateLearned(DateTime.now());

    showHabitButton = false;
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
