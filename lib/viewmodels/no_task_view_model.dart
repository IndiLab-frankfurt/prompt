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

  late int daysActive =
      _dataService.getUserDataCache().registrationDate.daysAgo();

  late double studyProgress = daysActive / 36;

  String message = AppStrings.NoTask_Continue_After_Cabuu;

  NoTaskViewModel(
      this._experimentService, this._dataService, this._navigationService) {
    print("Constructor of no task viewmodel");
    getNextTask();
  }

  Future<void> getNextTask() async {
    _dataService.getLastAssessmentResult();

    if (await _experimentService.isTimeForMorningAssessment()) {
      this._navigationService.navigateTo(RouteNames.ASSESSMENT_MORNING);
    }

    if (await _experimentService.isTimeForEveningAssessment()) {
      showLearnedWithCabuuButton = true;
      notifyListeners();
    }
  }
}
