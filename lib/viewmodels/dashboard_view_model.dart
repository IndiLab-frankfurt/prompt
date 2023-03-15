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
    }

    if (daysAgo > StudyService.FULL_STUDY_DURATION.inDays) {
      return S.current.dashboard_studyCompletelyFinished;
    }

    if (daysAgo > StudyService.FULL_STUDY_DURATION.inDays) {
      return S.current.dashboard_inFollowUpPhase;
    }

    // Still in study phase. show message only if it is earlier than 6pm
    if (DateTime.now().toLocal().hour < 18) {
      return S.current.dashboard_mainmessage_beforeEvening;
    }

    // Still in study phase. After 6pm this screen should only be reached if the
    // user has done their last task for the day.
    if (DateTime.now().toLocal().hour >= 18) {
      return S.current.dashboard_continueTomorrow;
    }

    notifyListeners();

    return "";
  }

  int daysUntilVocabTest() {
    var nextDate = _studyService.getNextVocabTestDate();
    return nextDate.weekDaysAgo(DateTime.now());
  }

  int getMaxStudyDays() {
    return StudyService.DAILY_USE_DURATION.inDays;
  }

  double getVocabProgress() {
    return (21 - daysUntilVocabTest()) / 21;
  }

  Future<void> initialize() async {}

  Future<String> getNextTask() async {
    await initialize();

    return await getButtonText();
  }
}
