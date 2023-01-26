import 'package:prompt/services/data_service.dart';
import 'package:prompt/services/study_service.dart';
import 'package:prompt/services/navigation_service.dart';
import 'package:prompt/shared/app_strings.dart';
import 'package:prompt/shared/extensions.dart';
import 'package:prompt/shared/route_names.dart';
import 'package:prompt/viewmodels/base_view_model.dart';

class DashboardViewModel extends BaseViewModel {
  final StudyService _studyService;
  final DataService _dataService;
  final NavigationService _navigationService;

  bool showLearnedWithCabuuButton = false;
  bool showVocabularyTestReminder = false;
  bool showContinueTomorrowButton = false;
  bool showFinalAssessmentButton = false;
  bool startTomorrow = false;

  late int daysActive = _studyService.getDaysSinceStart();

  late double studyProgress = daysActive / 36;

  String messageContinueAfterCabuu = AppStrings.NoTask_Continue_After_Cabuu;
  String messageContinueTomorrow = AppStrings.NoTask_ContinueTomorrow;

  DashboardViewModel(
      this._studyService, this._dataService, this._navigationService);

  String daysUntilVocabTestString() {
    var nextDate = _studyService.getNextVocabTestDate();
    var difference = nextDate.weekDaysAgo(DateTime.now());

    if (nextDate.isToday()) {
      return "Dein nächster Vokabeltest ist heute";
    } else if (nextDate.isTomorrow()) {
      return "Dein nächster Vokabeltest ist morgen";
    } else {
      var daysPlural = difference == 1 ? "Tag" : "Tage";
      return "Noch $difference $daysPlural bis zum nächsten Vokabeltest";
    }
  }

  int daysUntilVocabTest() {
    var nextDate = _studyService.getNextVocabTestDate();
    return nextDate.weekDaysAgo(DateTime.now());
  }

  int getMaxStudyDays() {
    return 200;
  }

  Future<void> initialize() async {}

  Future<bool> getNextTask() async {
    await initialize();

    showLearnedWithCabuuButton = false;
    showVocabularyTestReminder = false;

    if (daysActive == 0) {
      startTomorrow = true;
      return true;
    }

    return false;
  }
}
