import 'package:flutter/material.dart';
import 'package:prompt/models/assessment.dart';
import 'package:prompt/shared/enums.dart';
import 'package:prompt/viewmodels/base_view_model.dart';

abstract class MultiStepAssessmentViewModel extends BaseViewModel {
  int step = 0;
  Assessment lastAssessment = Assessment();
  DateTime startDate = DateTime.now();

  String nextButtonText = "Weiter";

  bool canMoveBack(ValueKey currentPageKey);
  bool canMoveNext(ValueKey currentPageKey);
  int getNextPage(ValueKey currentPageKey);
  void submit();

  Map<String, String> currentAssessmentResults = {};
  Map<String, Map<String, String>> allAssessmentResults = {};

  isAssessmentFilledOut(Assessment assessment) {
    if (assessment.id.isEmpty) return false;
    bool canSubmit = true;
    for (var assessmentItem in assessment.items) {
      if (!currentAssessmentResults.containsKey(assessmentItem.id))
        canSubmit = false;
    }
    return canSubmit;
  }

  setAssessmentResult(String assessmentType, String itemId, String value) {
    currentAssessmentResults[itemId] = value;

    if (!allAssessmentResults.containsKey(assessmentType)) {
      allAssessmentResults[assessmentType] = {itemId: value};
    }
    allAssessmentResults[assessmentType]![itemId] = value;

    notifyListeners();
  }

  Future<Assessment> getAssessment(AssessmentTypes assessmentType);

  clearCurrent() {
    lastAssessment = Assessment();
    currentAssessmentResults = {};
  }

  onAssessmentLoaded(Assessment assessment) {
    lastAssessment = assessment;
    currentAssessmentResults = {};
  }
}
