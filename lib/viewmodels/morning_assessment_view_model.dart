import 'package:flutter/foundation.dart';
import 'package:prompt/models/assessment_result.dart';
import 'package:prompt/services/data_service.dart';
import 'package:prompt/services/experiment_service.dart';
import 'package:prompt/shared/enums.dart';
import 'package:prompt/shared/route_names.dart';
import 'package:prompt/viewmodels/internalisation_view_model.dart';
import 'package:prompt/viewmodels/multi_step_assessment_view_model.dart';
import 'package:prompt/shared/extensions.dart';

enum MorningAssessmentStep {
  didLearn,
  rememberToUsePromptAfterCabuu,
  alternativeItems,
  eveningItems,
  morningItems,
  boosterPrompt,
  internalisation,
  completed
}

class MorningAssessmentViewModel extends MultiStepAssessmentViewModel {
  final ExperimentService experimentService;
  final DataService dataService;

  InternalisationCondition _internalisationCondition =
      InternalisationCondition.emoji;

  InternalisationViewModel internalisationViewmodel =
      InternalisationViewModel();

  int group = 0;

  List<MorningAssessmentStep> screenOrder = [
    MorningAssessmentStep.didLearn,
    MorningAssessmentStep.rememberToUsePromptAfterCabuu,
    MorningAssessmentStep.alternativeItems,
    MorningAssessmentStep.eveningItems,
    MorningAssessmentStep.morningItems,
    MorningAssessmentStep.boosterPrompt,
    MorningAssessmentStep.internalisation,
    MorningAssessmentStep.completed
  ];

  MorningAssessmentViewModel(this.experimentService, this.dataService)
      : super(dataService);

  @override
  bool canMoveBack(ValueKey currentPageKey) {
    return false;
  }

  @override
  bool canMoveNext(ValueKey currentPageKey) {
    if (currentPageKey.value == MorningAssessmentStep.didLearn) {
      return allAssessmentResults.containsKey("didLearnWhen");
    }

    if (currentPageKey.value == MorningAssessmentStep.internalisation) {
      return internalisationViewmodel.completed;
    }

    return true;
  }

  int getStepIndex(MorningAssessmentStep morningAssessmentStep) {
    return screenOrder.indexOf(morningAssessmentStep);
  }

  bool didCompleteEveningItemsYesterday() {
    var last = dataService.getLastAssessmentResultCached();

    if (last == null) return false;

    if (last.submissionDate.daysAgo() == 1) {
      return last.assessmentType == "eveningAssessment";
    }
    return false;
  }

  int getNextStepForDidLearn() {
    var step = 0;

    var answer = allAssessmentResults["didLearnWhen"]!["didLearnWhen_1"];

    // did learn cabuu today
    if (answer == "1") {
      step = getStepIndex(MorningAssessmentStep.eveningItems);
    }

    // did learn yesterday
    else if (answer == "2") {
      if (didCompleteEveningItemsYesterday()) {
        step =
            getStepIndex(MorningAssessmentStep.rememberToUsePromptAfterCabuu);
      } else {
        step = getStepIndex(MorningAssessmentStep.eveningItems);
      }
    }

    // did learn some other time
    else if (answer == "3") if (didCompleteEveningItemsYesterday()) {
      step = getStepIndex(MorningAssessmentStep.morningItems);
    } else {
      step = getStepIndex(MorningAssessmentStep.eveningItems);
    }

    return step;
  }

  int getNextStepForEveningItems() {
    var step = 0;
    var answer = allAssessmentResults["didLearnWhen"]!["didLearnWhen_1"];
    if (answer == "1") {
      if (experimentService.isBoosterPromptDay()) {
        step = getStepIndex(MorningAssessmentStep.boosterPrompt);
      } else {
        step = getStepIndex(MorningAssessmentStep.completed);
      }
    } else {
      step = getStepIndex(MorningAssessmentStep.morningItems);
    }
    return step;
  }

  @override
  int getNextPage(ValueKey currentPageKey) {
    step += 1;

    if (currentPageKey.value == MorningAssessmentStep.didLearn) {
      step = getNextStepForDidLearn();
    }

    if (currentPageKey.value == MorningAssessmentStep.alternativeItems) {
      step = getStepIndex(MorningAssessmentStep.morningItems);
    }

    if (currentPageKey.value ==
        MorningAssessmentStep.rememberToUsePromptAfterCabuu) {
      step = getStepIndex(MorningAssessmentStep.morningItems);
    }

    if (currentPageKey.value == MorningAssessmentStep.morningItems) {
      if (experimentService.isBoosterPromptDay()) {
        step = getStepIndex(MorningAssessmentStep.boosterPrompt);
      } else {
        step = getStepIndex(MorningAssessmentStep.completed);
      }
    }

    if (currentPageKey.value == MorningAssessmentStep.eveningItems) {
      step = getNextStepForEveningItems();
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
    _internalisationCondition = experimentService.getInternalisationCondition();
    return _internalisationCondition;
  }

  void onInternalisationCompleted(String input) {
    this.internalisationViewmodel.completed = true;
    print("Internalisation completed with input $input");
    notifyListeners();
  }

  @override
  void submit() async {
    Map<String, String> results = {};
    for (var result in allAssessmentResults.values) {
      results.addAll(result);
    }
    var oneBigAssessment =
        AssessmentResult(results, "morningAssessment", DateTime.now());
    oneBigAssessment.startDate = this.startDate;

    experimentService.submitAssessment(oneBigAssessment, "morningAssessment");

    experimentService.nextScreen(RouteNames.ASSESSMENT_MORNING);
  }
}
