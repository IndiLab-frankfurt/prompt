import 'package:flutter/foundation.dart';
import 'package:prompt/locator.dart';
import 'package:prompt/models/assessment_result.dart';
import 'package:prompt/services/navigation_service.dart';
import 'package:prompt/shared/enums.dart';
import 'package:prompt/shared/extensions.dart';
import 'package:prompt/services/data_service.dart';
import 'package:prompt/services/experiment_service.dart';
import 'package:prompt/shared/route_names.dart';
import 'package:prompt/viewmodels/multi_step_assessment_view_model.dart';

const String eveningItems = "eveningItems";
const String didLearnCabuuToday = "didLearnCabuuToday";
const String distributedLearning = "distributedLearning";
const String continueAfterCabuu = "continueAfterCabuu";

enum EveningAssessmentStep {
  didLearnCabuuToday,
  distributedLearningVideo,
  continueAfterCabuu,
  assessment_distributedLearning,
  assessment_evening_1,
  assessment_evening_2,
  assessment_evening_3,
  completed
}

class EveningAssessmentViewModel extends MultiStepAssessmentViewModel {
  final ExperimentService experimentService;

  List<EveningAssessmentStep> screenOrder = [
    EveningAssessmentStep.didLearnCabuuToday,
    EveningAssessmentStep.continueAfterCabuu,
    EveningAssessmentStep.distributedLearningVideo,
    EveningAssessmentStep.assessment_distributedLearning,
    EveningAssessmentStep.assessment_evening_1,
    EveningAssessmentStep.assessment_evening_2,
    EveningAssessmentStep.assessment_evening_3,
    EveningAssessmentStep.completed
  ];

  EveningAssessmentViewModel(this.experimentService, DataService dataService)
      : super(dataService) {
    this.group = dataService.getUserDataCache().group;
  }

  @override
  bool canMoveBack(ValueKey currentPageKey) {
    return false;
  }

  @override
  bool canMoveNext(ValueKey currentPageKey) {
    var pageKey = currentPageKey.value as EveningAssessmentStep;

    switch (pageKey) {
      case EveningAssessmentStep.didLearnCabuuToday:
      case EveningAssessmentStep.assessment_evening_1:
      case EveningAssessmentStep.assessment_evening_2:
      case EveningAssessmentStep.assessment_evening_3:
        return currentAssessmentIsFilledOut;
      case EveningAssessmentStep.assessment_distributedLearning:
        return _distributedLearningVideoCompleted;
      case EveningAssessmentStep.distributedLearningVideo:
      case EveningAssessmentStep.completed:
      case EveningAssessmentStep.continueAfterCabuu:
        return true;
    }
  }

  bool _distributedLearningVideoCompleted = false;
  onDistributedLearningVideoCompleted() {
    _distributedLearningVideoCompleted = true;
  }

  int group = 0;

  int getStepIndex(EveningAssessmentStep step) {
    return screenOrder.indexOf(step);
  }

  bool didCompleteMorningItemsToday() {
    var last = this.dataService.getLastAssessmentResultCached();

    if (last == null) return false;

    if (last.submissionDate.isToday()) {
      return last.assessmentType == MORNING_ASSESSMENT;
    }
    return false;
  }

  int getStepAfterEveningItems() {
    // TODO: Actual logic
    bool promptWasCompleted = true;

    if (experimentService.isDistributedLearningDay()) {
      return getStepIndex(EveningAssessmentStep.distributedLearningVideo);
    } else {
      return getStepIndex(EveningAssessmentStep.completed);
    }
  }

  @override
  int getNextPage(ValueKey currentPageKey) {
    step += 1;

    step += 1;

    var pageKey = currentPageKey.value as EveningAssessmentStep;

    switch (pageKey) {
      case EveningAssessmentStep.didLearnCabuuToday:
        var answer = allAssessmentResults["didLearnToday"]!["didLearnToday_1"];
        // did learn with cabuu today
        if (answer == "1") {
          step = getStepIndex(EveningAssessmentStep.assessment_evening_1);
        }
        // did not learn with cabuu today
        else {
          step = getStepIndex(EveningAssessmentStep.continueAfterCabuu);
        }
        break;
      case EveningAssessmentStep.assessment_distributedLearning:
        getStepIndex(EveningAssessmentStep.completed);
        break;
      case EveningAssessmentStep.continueAfterCabuu:
        continueWithoutSubmission();
        break;
      case EveningAssessmentStep.assessment_evening_1:
        step = getStepIndex(EveningAssessmentStep.assessment_evening_2);
        break;
      case EveningAssessmentStep.assessment_evening_2:
        step = getStepIndex(EveningAssessmentStep.assessment_evening_3);
        break;
      case EveningAssessmentStep.assessment_evening_3:
        step = getStepAfterEveningItems();
        break;
      case EveningAssessmentStep.distributedLearningVideo:
        getStepIndex(EveningAssessmentStep.assessment_distributedLearning);
        break;
      case EveningAssessmentStep.completed:
        break;
    }

    return step;
  }

  @override
  void submit() {
    Map<String, String> results = {};
    for (var result in allAssessmentResults.values) {
      results.addAll(result);
    }
    var oneBigAssessment =
        AssessmentResult(results, EVENING_ASSESSMENT, DateTime.now());
    oneBigAssessment.startDate = this.startDate;

    experimentService.submitAssessment(oneBigAssessment, EVENING_ASSESSMENT);

    experimentService.nextScreen(RouteNames.ASSESSMENT_EVENING);
  }

  continueWithoutSubmission() {
    locator<NavigationService>().navigateTo(RouteNames.NO_TASKS);
  }
}
