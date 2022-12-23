import 'package:flutter/foundation.dart';
import 'package:prompt/models/assessment.dart';
import 'package:prompt/models/assessment_result.dart';
import 'package:prompt/models/questionnaire_response.dart';
import 'package:prompt/services/data_service.dart';
import 'package:collection/collection.dart';
import 'package:prompt/viewmodels/base_view_model.dart';

abstract class MultiStepAssessmentViewModel extends BaseViewModel {
  final DataService dataService;

  bool currentAssessmentIsFilledOut = false;

  int step = 0;
  int initialStep = 0;

  Assessment lastAssessment = Assessment();
  DateTime startDate = DateTime.now();

  String nextButtonText = "Weiter";

  MultiStepAssessmentViewModel(this.dataService);

  bool canMoveBack(ValueKey currentPageKey);
  bool canMoveNext(ValueKey currentPageKey);

  void submit();

  QuestionnaireResponse? currentResponse;
  List<QuestionnaireResponse> questionnaireResponses = [];
  Map<String, Map<String, dynamic>> timings = {};

  int getNextPage(ValueKey currentPageKey) {
    return step + 1;
  }

  saveQuestionnaireResponse(
      String questionnaireName, String itemName, String response) {
    // check if there is already a response for this questionnaire and item id
    var existingResponse = questionnaireResponses.firstWhereOrNull((element) =>
        element.questionnaireName == questionnaireName &&
        element.name == itemName);

    if (existingResponse != null) {
      questionnaireResponses.remove(existingResponse);
    }
    var newResponse = QuestionnaireResponse(
        questionnaireName: questionnaireName,
        name: itemName,
        questionText: "",
        response: response,
        dateSubmitted: DateTime.now());

    questionnaireResponses.add(newResponse);

    notifyListeners();
  }

  void onAssessmentCompleted(Assessment assessment) {
    currentAssessmentIsFilledOut = true;

    notifyListeners();
  }

  Future<Assessment> getQuestionnaire(String name) async {
    Assessment assessment = await dataService.getAssessment(name);
    lastAssessment = assessment;
    currentResponse = null;
    return assessment;
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
    lastAssessment = Assessment();
    currentResponse = null;
  }

  onAssessmentLoaded(Assessment assessment) {
    lastAssessment = assessment;
    currentResponse = null;
  }

  onPageChange() {
    currentAssessmentIsFilledOut = false;
  }
}
