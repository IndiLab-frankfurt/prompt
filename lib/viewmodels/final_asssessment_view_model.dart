import 'package:flutter/material.dart';
import 'package:prompt/services/data_service.dart';
import 'package:prompt/services/study_service.dart';
import 'package:prompt/shared/enums.dart';
import 'package:prompt/shared/route_names.dart';
import 'package:prompt/viewmodels/multi_page_view_model.dart';

enum FinalAssessmentStep {
  introduction,
  assessment_finalSession_1,
  assessment_finalSession_2,
  assessment_finalSession_3,
  planDisplay,
  assessment_finalSession_4,
  completed
}

class FinalAssessmentViewModel extends MultiPageViewModel {
  List<FinalAssessmentStep> screenOrder = [
    FinalAssessmentStep.introduction,
    FinalAssessmentStep.assessment_finalSession_1,
    FinalAssessmentStep.assessment_finalSession_2,
    FinalAssessmentStep.assessment_finalSession_3,
    FinalAssessmentStep.planDisplay,
    FinalAssessmentStep.assessment_finalSession_4,
    FinalAssessmentStep.completed
  ];

  final StudyService experimentService;

  int group = 0;

  FinalAssessmentViewModel(DataService dataService, this.experimentService)
      : super(dataService);

  @override
  bool canMoveBack(ValueKey? currentPageKey) {
    return false;
  }

  @override
  bool canMoveNext(ValueKey? currentPageKey) {
    var key = currentPageKey!.value as FinalAssessmentStep;

    switch (key) {
      case FinalAssessmentStep.introduction:
      case FinalAssessmentStep.planDisplay:
        return true;
      case FinalAssessmentStep.assessment_finalSession_1:
      case FinalAssessmentStep.assessment_finalSession_2:
      case FinalAssessmentStep.assessment_finalSession_3:
      case FinalAssessmentStep.assessment_finalSession_4:
        return currentAssessmentIsFilledOut;
      case FinalAssessmentStep.completed:
        break;
    }

    return true;
  }

  int getStepIndex(FinalAssessmentStep step) {
    return screenOrder.indexOf(step);
  }

  @override
  int getNextPage(ValueKey? currentPageKey) {
    page += 1;

    var pageKey = currentPageKey!.value as FinalAssessmentStep;

    switch (pageKey) {
      case FinalAssessmentStep.introduction:
        page = getStepIndex(FinalAssessmentStep.assessment_finalSession_1);
        break;
      case FinalAssessmentStep.assessment_finalSession_1:
        break;
      case FinalAssessmentStep.assessment_finalSession_2:
        page = getStepIndex(FinalAssessmentStep.assessment_finalSession_3);
        break;
      case FinalAssessmentStep.assessment_finalSession_3:
        page = getStepIndex(FinalAssessmentStep.assessment_finalSession_4);
        break;
      case FinalAssessmentStep.assessment_finalSession_4:
        page = getStepIndex(FinalAssessmentStep.completed);
        break;
      case FinalAssessmentStep.completed:
        break;
      case FinalAssessmentStep.planDisplay:
        page = getStepIndex(FinalAssessmentStep.assessment_finalSession_4);
        break;
    }

    return page;
  }

  Future<String> getPlan() async {
    var lastPlan = await dataService.getLastPlan();
    if (lastPlan != null) {
      return lastPlan;
    } else {
      return "";
    }
  }

  @override
  void submit() {
    experimentService.submitResponses(questionnaireResponses, FINAL_ASSESSMENT);

    experimentService.nextScreen(RouteNames.ASSESSMENT_FINAL);
  }
}
