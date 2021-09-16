import 'package:flutter/foundation.dart';
import 'package:prompt/models/assessment_result.dart';
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

class EveningAssessmentViewModel extends MultiStepAssessmentViewModel {
  final ExperimentService experimentService;

  List<String> screenOrder = [
    didLearnCabuuToday,
    continueAfterCabuu,
    eveningItems
  ];

  EveningAssessmentViewModel(this.experimentService, DataService dataService)
      : super(dataService);

  @override
  bool canMoveBack(ValueKey currentPageKey) {
    return false;
  }

  @override
  bool canMoveNext(ValueKey currentPageKey) {
    if (currentPageKey.value == didLearnCabuuToday) {
      return allAssessmentResults.containsKey("didLearnToday");
    }

    return true;
  }

  int getStepIndex(String step) {
    return screenOrder.indexOf(step);
  }

  bool didCompleteMorningItemsToday() {
    var last = dataService.getLastAssessmentResultCached();

    if (last == null) return false;

    if (last.submissionDate.isToday()) {
      return last.assessmentType == MORNING_ASSESSMENT;
    }
    return false;
  }

  @override
  int getNextPage(ValueKey currentPageKey) {
    step += 1;
    if (currentPageKey.value == didLearnCabuuToday) {
      var answer = allAssessmentResults["didLearnToday"]!["didLearnToday_1"];
      // did learn with cabuu today
      if (answer == "1") {
        step = getStepIndex(eveningItems);
      }
      // did not learn with cabuu today
      else {
        step = getStepIndex(continueAfterCabuu);
      }
    }

    if (currentPageKey.value == eveningItems) {
      step = getStepIndex(distributedLearning);
    }

    if (currentPageKey.value == continueAfterCabuu) {
      continueWithoutSubmission();
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
    experimentService.nextScreen(RouteNames.ASSESSMENT_EVENING);
  }
}
