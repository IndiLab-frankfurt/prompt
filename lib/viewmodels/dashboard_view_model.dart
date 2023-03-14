import 'package:prompt/l10n/localization/generated/l10n.dart';
import 'package:prompt/services/study_service.dart';
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

  DashboardViewModel(this._studyService);

  String daysUntilVocabTestString() {
    var nextDate = _studyService.getNextVocabTestDate();
    var difference = nextDate.weekDaysAgo(DateTime.now());

    if (nextDate.isToday()) {
      return S.current.dashboard_nextVocabToday;
    } else if (nextDate.isTomorrow()) {
      return S.current.dashboard_nextVocabTomorrow;
    } else {
      return S.current.dashboard_daysUntilVocabTest(difference);
    }
  }

  Future<String> getButtonText() async {
    var daysAgo = _studyService.getDaysSinceStart();

    if (daysAgo == 0) {
      return S.current.dashboard_mainmessage_firstday;
    } else if (daysAgo > getMaxStudyDays()) {
      return "";
    }
    if (daysAgo >= 1 && daysAgo < getMaxStudyDays()) {
      // show message only if it is earlier than 6pm
      if (DateTime.now().toLocal().hour < 18) {
        return S.current.dashboard_mainmessage_beforeEvening;
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

  double getVocabProgress() {
    return (21 - daysUntilVocabTest()) / 21;
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
