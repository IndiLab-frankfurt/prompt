import 'package:flutter/foundation.dart';

import 'package:prompt/services/data_service.dart';
import 'package:prompt/services/experiment_service.dart';
import 'package:prompt/shared/route_names.dart';
import 'package:prompt/viewmodels/multi_step_assessment_view_model.dart';

const String eveningItems = "eveningItems";
const String didLearnCabuuToday = "didLearnCabuuToday";

class EveningAssessmentViewModel extends MultiStepAssessmentViewModel {
  final ExperimentService experimentService;

  List<String> screenOrder = [didLearnCabuuToday, eveningItems];

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

  @override
  int getNextPage(ValueKey currentPageKey) {
    step += 1;
    if (currentPageKey.value == didLearnCabuuToday) {
      var answer = allAssessmentResults["didLearnToday"]!["didLearnToday_1"];
      // did learn yesterday
      if (answer == "1") {
        step = getStepIndex(eveningItems);
      } else
        submit();
      // did not learn yesterday
    }

    return step;
  }

  @override
  void submit() {
    experimentService.nextScreen(RouteNames.ASSESSMENT_EVENING);
  }
}
