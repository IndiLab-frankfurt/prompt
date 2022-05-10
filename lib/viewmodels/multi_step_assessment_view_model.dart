import 'package:flutter/foundation.dart';
import 'package:prompt/models/questionnaire.dart';
import 'package:prompt/models/assessment_result.dart';
import 'package:prompt/services/data_service.dart';
import 'package:prompt/shared/enums.dart';
import 'package:prompt/viewmodels/base_view_model.dart';

abstract class MultiStepAssessmentViewModel extends BaseViewModel {
  final DataService dataService;

  bool currentAssessmentIsFilledOut = false;

  int step = 0;
  int initialStep = 0;

  Questionnaire? lastQuestionnaire;
  DateTime startDate = DateTime.now();

  String nextButtonText = "Weiter";

  MultiStepAssessmentViewModel(this.dataService);

  bool canMoveBack(ValueKey currentPageKey);
  bool canMoveNext(ValueKey currentPageKey);

  // @mustCallSuper
  void submit() {
    setState(ViewState.busy);
  }

  Map<String, String> currentAssessmentResults = {};
  Map<String, Map<String, String>> allAssessmentResults = {};
  Map<String, Map<String, dynamic>> timings = {};
  List<String> submittedResults = [];

  int getNextPage(ValueKey currentPageKey) {
    doStepDependentSubmission(currentPageKey);
    return step + 1;
  }

  void doStepDependentSubmission(ValueKey currentPageKey) {}

  void submitAssessmentResult(assessmentName) {
    if (!allAssessmentResults.containsKey(assessmentName)) {
      return;
    }
    var assessmentResult = AssessmentResult(
        allAssessmentResults[assessmentName]!, assessmentName, DateTime.now());
    assessmentResult.startDate = this.startDate;
    dataService.saveAssessment(assessmentResult);
    submittedResults.add(assessmentName);
  }

  setAssessmentResult(String assessmentType, String itemId, String value) {
    currentAssessmentResults[itemId] = value;

    if (!allAssessmentResults.containsKey(assessmentType)) {
      allAssessmentResults[assessmentType] = {itemId: value};
    }
    allAssessmentResults[assessmentType]![itemId] = value;

    notifyListeners();
  }

  void onAssessmentCompleted(Questionnaire assessment) {
    currentAssessmentIsFilledOut = true;

    notifyListeners();
  }

  Future<Questionnaire> getAssessment(AssessmentTypes assessmentType) async {
    String name = describeEnum(assessmentType);
    Questionnaire assessment = await dataService.getAssessment(name);
    lastQuestionnaire = assessment;
    currentAssessmentResults = {};
    return assessment;
  }

  AssessmentResult getOneBisAssessment(String assessmentName) {
    Map<String, String> results = {};
    for (var result in allAssessmentResults.values) {
      results.addAll(result);
    }
    var oneBigAssessment =
        AssessmentResult(results, assessmentName, DateTime.now());
    oneBigAssessment.startDate = this.startDate;
    oneBigAssessment.timings = this.timings;

    return oneBigAssessment;
  }

  addTiming(String previous, String next) {
    var nowString = DateTime.now().toIso8601String();

    if (!timings.containsKey(previous)) {
      timings[previous] = {"start": nowString, "end": nowString};
    }
    if (!timings.containsKey(next)) {
      timings[next] = {"start": nowString, "end": nowString};
    }

    timings[next]!["start"] = nowString;
    timings[previous]!["end"] = nowString;
  }

  clearCurrent() {
    lastQuestionnaire = null;
    currentAssessmentResults = {};
  }

  onAssessmentLoaded(Questionnaire assessment) {
    lastQuestionnaire = assessment;
    currentAssessmentResults = {};
  }

  onPageChange() {
    currentAssessmentIsFilledOut = false;
  }
}
