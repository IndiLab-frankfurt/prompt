import 'package:flutter/foundation.dart';
import 'package:prompt/services/data_service.dart';
import 'package:prompt/services/experiment_service.dart';
import 'package:prompt/shared/enums.dart';
import 'package:prompt/shared/route_names.dart';
import 'package:prompt/viewmodels/internalisation_view_model.dart';
import 'package:prompt/viewmodels/multi_step_assessment_view_model.dart';

enum MorningAssessmentStep {
  didLearnCabuuYesterday,
  alternativeItems,
  eveningItems,
  morningItems,
  boosterPrompt,
  internalisation,
  completed
}

class MorningAssessmentViewModel extends MultiStepAssessmentViewModel {
  final ExperimentService experimentService;

  InternalisationViewModel internalisationViewmodel =
      InternalisationViewModel();

  int group = 0;

  List<MorningAssessmentStep> screenOrder = [
    MorningAssessmentStep.didLearnCabuuYesterday,
    MorningAssessmentStep.alternativeItems,
    MorningAssessmentStep.eveningItems,
    MorningAssessmentStep.morningItems,
    MorningAssessmentStep.boosterPrompt,
    MorningAssessmentStep.internalisation,
    MorningAssessmentStep.completed
  ];

  MorningAssessmentViewModel(this.experimentService, DataService dataService)
      : super(dataService);

  @override
  bool canMoveBack(ValueKey currentPageKey) {
    return false;
  }

  @override
  bool canMoveNext(ValueKey currentPageKey) {
    if (currentPageKey.value == MorningAssessmentStep.didLearnCabuuYesterday) {
      return allAssessmentResults.containsKey("didLearnYesterday");
    }

    return true;
  }

  int getStepIndex(MorningAssessmentStep morningAssessmentStep) {
    return screenOrder.indexOf(morningAssessmentStep);
  }

  @override
  int getNextPage(ValueKey currentPageKey) {
    step += 1;
    if (currentPageKey.value == MorningAssessmentStep.didLearnCabuuYesterday) {
      var answer =
          allAssessmentResults["didLearnYesterday"]!["didLearnYesterday_1"];
      // did learn yesterday
      if (answer == "1") {
        step = getStepIndex(MorningAssessmentStep.alternativeItems);
      } else
        step = getStepIndex(MorningAssessmentStep.eveningItems);
      // did not learn yesterday
    }

    if (currentPageKey.value == MorningAssessmentStep.alternativeItems) {
      step = getStepIndex(MorningAssessmentStep.morningItems);
    }

    if (currentPageKey.value == MorningAssessmentStep.morningItems) {
      if (experimentService.isBoosterPromptDay()) {
        step = getStepIndex(MorningAssessmentStep.boosterPrompt);
      } else {
        step = getStepIndex(MorningAssessmentStep.completed);
      }
    }

    if (currentPageKey.value == MorningAssessmentStep.boosterPrompt) {
      if (experimentService.isInternalisationDay()) {
        step = getStepIndex(MorningAssessmentStep.internalisation);
      } else {
        step = getStepIndex(MorningAssessmentStep.completed);
      }
    }

    return step;
  }

  InternalisationCondition getInternalisationCondition() {
    return experimentService.getInternalisationCondition();
  }

  @override
  void submit() async {
    experimentService.nextScreen(RouteNames.ASSESSMENT_MORNING);
  }
}
