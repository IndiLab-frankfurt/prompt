import 'package:prompt/services/data_service.dart';
import 'package:prompt/services/experiment_service.dart';
import 'package:prompt/services/navigation_service.dart';
import 'package:prompt/shared/app_strings.dart';
import 'package:prompt/shared/route_names.dart';
import 'package:prompt/viewmodels/base_view_model.dart';

class NoTaskViewModel extends BaseViewModel {
  final ExperimentService _experimentService;
  final DataService _dataService;
  final NavigationService _navigationService;

  bool showLearnedWithCabuuButton = false;
  bool showVocabularyTestReminder = false;
  bool showContinueTomorrowButton = false;
  bool showFinalAssessmentButton = false;
  bool startTomorrow = false;

  late int daysActive = _experimentService.getDaysSinceStart();

  late double studyProgress = daysActive / 36;

  String messageContinueAfterCabuu = AppStrings.NoTask_Continue_After_Cabuu;
  String messageContinueTomorrow = AppStrings.NoTask_ContinueTomorrow;

  NoTaskViewModel(
      this._experimentService, this._dataService, this._navigationService) {
    print("Constructor of no task viewmodel");
    // getNextTask();
  }

  String daysUntilVocabTest() {
    var nextDate = _experimentService.getNextVocabTestDate();
    var difference = nextDate.difference(DateTime.now());

    if (difference.inDays > 0) {
      var daysPlural = difference.inDays == 1 ? "Tag" : "Tage";
      return "${difference.inDays} $daysPlural bis zum nächsten Vokabeltest";
    } else {
      return "Dein nächster Vokabeltest ist heute";
    }
  }

  Future<void> initialize() async {
    await _dataService.getAssessmentResults();
  }

  Future<bool> getNextTask() async {
    await initialize();

    showLearnedWithCabuuButton = false;
    showVocabularyTestReminder = false;

    if (!_experimentService.hasCompletedSessionZero()) {
      this._navigationService.navigateTo(RouteNames.SESSION_ZERO);
    }

    if (daysActive == 0) {
      // notifyListeners();
      startTomorrow = true;
      return true;
    }

    if (_experimentService.isVocabTestDay()) {
      if (await _experimentService.isTimeForMorningAssessment()) {
        showLearnedWithCabuuButton = false;
        showVocabularyTestReminder = true;
        // notifyListeners();
        return true;
      } else {
        return false;
      }
    }

    if (await _experimentService.isTimeForMorningAssessment()) {
      this._navigationService.navigateTo(RouteNames.ASSESSMENT_MORNING);
    }

    if (await _experimentService.isTimeForEveningAssessment()) {
      showLearnedWithCabuuButton = true;
      // notifyListeners();
      return true;
    }

    return false;
  }
}
