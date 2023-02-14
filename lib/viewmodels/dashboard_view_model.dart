import 'package:prompt/services/study_service.dart';
import 'package:prompt/shared/app_strings.dart';
import 'package:prompt/shared/extensions.dart';
import 'package:prompt/viewmodels/base_view_model.dart';

class DashboardViewModel extends BaseViewModel {
  final StudyService _studyService;

  bool showLearnedWithCabuuButton = false;
  bool showVocabularyTestReminder = false;
  bool showContinueTomorrowButton = false;
  bool showFinalAssessmentButton = false;
  bool startTomorrow = false;

  late int daysActive = _studyService.getDaysSinceStart();

  late double studyProgress = daysActive / getMaxStudyDays();

  String messageContinueAfterCabuu = AppStrings.NoTask_Continue_After_Cabuu;
  String messageContinueTomorrow = AppStrings.NoTask_ContinueTomorrow;

  DashboardViewModel(this._studyService);

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

  Future<String> getButtonText() async {
    var daysAgo = _studyService.getDaysSinceStart();

    if (daysAgo == 0) {
      return AppStrings.Dashboard_MainMessage_FirstDay;
    } else if (daysAgo > getMaxStudyDays()) {
      return "";
    }
    if (daysAgo >= 1 && daysAgo < getMaxStudyDays()) {
      // show message only if it is earlier than 6pm
      if (DateTime.now().hour < 18) {
        return AppStrings.Dashboard_MainMessage_BeforeEvening;
      }
    }

    return "";
  }

  int daysUntilVocabTest() {
    var nextDate = _studyService.getNextVocabTestDate();
    return nextDate.weekDaysAgo(DateTime.now());
  }

  int getMaxStudyDays() {
    return StudyService.STUDY_DURATION.inDays;
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
