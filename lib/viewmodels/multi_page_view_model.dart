import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:prompt/models/assessment.dart';
import 'package:prompt/models/assessment_result.dart';
import 'package:prompt/models/questionnaire_response.dart';
import 'package:prompt/services/data_service.dart';
import 'package:collection/collection.dart';
import 'package:prompt/viewmodels/base_view_model.dart';

abstract class MultiPageViewModel extends BaseViewModel {
  final DataService dataService;

  List<dynamic> pages = [];

  bool currentAssessmentIsFilledOut = false;

  final StreamController _currentPageController =
      StreamController<int>.broadcast();

  Sink get currentPage => _currentPageController.sink;

  Stream<int> get currentPageStream =>
      _currentPageController.stream.map((currentIndex) => currentIndex);

  int page = 0;

  int initialPage = 0;

  Assessment lastAssessment = Assessment();

  DateTime startDate = DateTime.now();

  QuestionnaireResponse? currentResponse;

  List<QuestionnaireResponse> questionnaireResponses = [];

  Map<String, Map<String, dynamic>> timings = {};

  MultiPageViewModel(this.dataService);

  bool canMoveBack(ValueKey currentPageKey);

  bool canMoveNext(ValueKey currentPageKey);

  void submit();

  int nextPage(ValueKey currentPageKey) {
    if (page >= pages.length - 1) {
      return page;
    }
    page += 1;
    currentPage.add(page);
    return page;
  }

  int previousPage(ValueKey currentPageKey) {
    if (page <= 0) {
      return page;
    }
    page -= 1;
    currentPage.add(page);
    return page;
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

  @override
  void dispose() {
    _currentPageController.close();
    super.dispose();
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

  Future<bool> doStepDependentSubmission(ValueKey currentPageKey) async {
    return true;
  }
}
