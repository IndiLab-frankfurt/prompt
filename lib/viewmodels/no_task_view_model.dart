import 'package:prompt/services/data_service.dart';
import 'package:prompt/services/experiment_service.dart';
import 'package:prompt/services/navigation_service.dart';
import 'package:prompt/shared/app_strings.dart';
import 'package:prompt/shared/route_names.dart';
import 'package:prompt/viewmodels/base_view_model.dart';
import 'package:prompt/shared/extensions.dart';

class NoTaskViewModel extends BaseViewModel {
  final ExperimentService _experimentService;
  final DataService _dataService;
  final NavigationService _navigationService;

  bool showLearnedWithCabuuButton = false;
  bool showVocabularyTestReminder = false;
  bool showContinueTomorrowButton = false;

  late int daysActive = _experimentService.getDaysSinceStart();

  late double studyProgress = daysActive / 36;

  String messageContinueAfterCabuu = AppStrings.NoTask_Continue_After_Cabuu;
  String messageContinueTomorrow = AppStrings.NoTask_ContinueTomorrow;

  NoTaskViewModel(
      this._experimentService, this._dataService, this._navigationService) {
    print("Constructor of no task viewmodel");
    // getNextTask();
  }

  Future<bool> getNextTask() async {
    await _dataService.getAssessmentResults();

    showLearnedWithCabuuButton = false;
    showVocabularyTestReminder = false;

    if (daysActive == 0) {
      // notifyListeners();
      return true;
    }

    if (_experimentService.isVocabTestDay()) {
      showLearnedWithCabuuButton = false;
      showVocabularyTestReminder = true;
      // notifyListeners();
      return true;
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
