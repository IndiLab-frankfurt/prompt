import 'package:flutter/material.dart';
import 'package:prompt/models/assessment_result.dart';
import 'package:prompt/services/data_service.dart';
import 'package:prompt/services/experiment_service.dart';
import 'package:prompt/shared/enums.dart';
import 'package:prompt/shared/route_names.dart';
import 'package:prompt/viewmodels/multi_step_assessment_view_model.dart';

enum FinalAssessmentStep {
  introduction,
  assessment_finalSession_1,
  assessment_finalSession_2,
  assessment_finalSession_3,
  planDisplay,
  assessment_finalSession_4,
  completed
}

class FinalAssessmentViewModel extends MultiStepAssessmentViewModel {
  List<FinalAssessmentStep> screenOrder = [
    FinalAssessmentStep.introduction,
    FinalAssessmentStep.assessment_finalSession_1,
    FinalAssessmentStep.assessment_finalSession_2,
    FinalAssessmentStep.assessment_finalSession_3,
    FinalAssessmentStep.planDisplay,
    FinalAssessmentStep.assessment_finalSession_4,
    FinalAssessmentStep.completed
  ];

  final ExperimentService experimentService;

  int group = 0;

  FinalAssessmentViewModel(DataService dataService, this.experimentService)
      : super(dataService);

  @override
  bool canMoveBack(ValueKey currentPageKey) {
    return false;
  }

  @override
  bool canMoveNext(ValueKey currentPageKey) {
    var key = currentPageKey.value as FinalAssessmentStep;

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
        // TODO: Handle this case.
        break;
    }

    return true;
  }

  int getStepIndex(FinalAssessmentStep step) {
    return screenOrder.indexOf(step);
  }

  @override
  int getNextPage(ValueKey currentPageKey) {
    step += 1;

    var pageKey = currentPageKey.value as FinalAssessmentStep;

    switch (pageKey) {
      case FinalAssessmentStep.introduction:
        step = getStepIndex(FinalAssessmentStep.assessment_finalSession_1);
        break;
      case FinalAssessmentStep.assessment_finalSession_1:
        var answer =
            allAssessmentResults["final_1"]!["mc_distributed_practice_1"];
        if (["1", "2"].contains(answer)) {
          step = getStepIndex(FinalAssessmentStep.assessment_finalSession_2);
        } else {
          step = getStepIndex(FinalAssessmentStep.assessment_finalSession_3);
        }
        break;
      case FinalAssessmentStep.assessment_finalSession_2:
        step = getStepIndex(FinalAssessmentStep.assessment_finalSession_3);
        break;
      case FinalAssessmentStep.assessment_finalSession_3:
        step = getStepIndex(FinalAssessmentStep.assessment_finalSession_4);
        break;
      case FinalAssessmentStep.assessment_finalSession_4:
        step = getStepIndex(FinalAssessmentStep.completed);
        break;
      case FinalAssessmentStep.completed:
        break;
      case FinalAssessmentStep.planDisplay:
        step = getStepIndex(FinalAssessmentStep.assessment_finalSession_4);
        break;
    }

    return step;
  }

  Future<String> getPlan() async {
    var lastPlan = await dataService.getLastPlan();
    if (lastPlan != null) {
      return lastPlan.plan;
    } else {
      return "";
    }
  }

  @override
  void submit() {
    Map<String, String> results = {};
    for (var result in allAssessmentResults.values) {
      results.addAll(result);
    }
    var oneBigAssessment =
        AssessmentResult(results, FINAL_ASSESSMENT, DateTime.now());
    oneBigAssessment.startDate = this.startDate;

    experimentService.submitAssessment(oneBigAssessment, FINAL_ASSESSMENT);

    experimentService.nextScreen(RouteNames.ASSESSMENT_FINAL);
  }
}
