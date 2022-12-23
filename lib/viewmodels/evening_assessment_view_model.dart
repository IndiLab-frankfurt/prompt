import 'package:flutter/foundation.dart';
import 'package:prompt/locator.dart';
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
  continueAfterCabuu,
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
      case EveningAssessmentStep.completed:
      case EveningAssessmentStep.continueAfterCabuu:
        return true;
    }
  }

  String group = "0";

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
    return getStepIndex(EveningAssessmentStep.completed);
  }

  @override
  int getNextPage(ValueKey currentPageKey) {
    step += 1;

    step += 1;

    var pageKey = currentPageKey.value as EveningAssessmentStep;

    switch (pageKey) {
      case EveningAssessmentStep.didLearnCabuuToday:
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
      case EveningAssessmentStep.completed:
        break;
    }

    addTiming(pageKey.toString(), screenOrder[step].toString());

    return step;
  }

  @override
  void submit() {
    if (state == ViewState.idle) {
      setState(ViewState.busy);

      experimentService.submitResponses(
          questionnaireResponses, EVENING_ASSESSMENT);

      experimentService.nextScreen(RouteNames.ASSESSMENT_EVENING);
      setState(ViewState.idle);
    }
  }

  continueWithoutSubmission() {
    locator<NavigationService>().navigateTo(RouteNames.NO_TASKS);
  }
}
