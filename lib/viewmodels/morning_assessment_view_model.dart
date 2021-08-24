import 'package:flutter/foundation.dart';
import 'package:prompt/services/data_service.dart';
import 'package:prompt/services/experiment_service.dart';
import 'package:prompt/shared/route_names.dart';
import 'package:prompt/viewmodels/multi_step_assessment_view_model.dart';

enum MorningAssessmentStep { selfEfficacy }

const List<MorningAssessmentStep> ScreenOrder = [
  MorningAssessmentStep.selfEfficacy
];

class MorningAssessmentViewModel extends MultiStepAssessmentViewModel {
  final ExperimentService experimentService;

  MorningAssessmentViewModel(this.experimentService, DataService dataService)
      : super(dataService);

  @override
  bool canMoveBack(ValueKey currentPageKey) {
    return false;
  }

  @override
  bool canMoveNext(ValueKey currentPageKey) {
    return true;
  }

  @override
  void submit() async {
    experimentService.nextScreen(RouteNames.ASSESSMENT_MORNING);
  }
}
