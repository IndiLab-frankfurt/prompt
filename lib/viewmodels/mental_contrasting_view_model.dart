import 'package:flutter/material.dart';
import 'package:prompt/services/data_service.dart';
import 'package:prompt/services/experiment_service.dart';
import 'package:prompt/shared/enums.dart';
import 'package:prompt/shared/route_names.dart';
import 'package:prompt/viewmodels/multi_step_assessment_view_model.dart';

enum MentalContrastingStep {
  outcomeEnter,
  obstacleEnter,
  copingPlanCreation,
}

class MentalContrastingViewModel extends MultiStepAssessmentViewModel {
  final ExperimentService _experimentService;

  MentalContrastingViewModel(DataService dataService, this._experimentService)
      : super(dataService);

  static List<MentalContrastingStep> getScreenOrder(int group) {
    List<MentalContrastingStep> screenOrder = [
      MentalContrastingStep.outcomeEnter,
      MentalContrastingStep.obstacleEnter,
      MentalContrastingStep.copingPlanCreation,
    ];

    return screenOrder;
  }

  String _outcome = "";
  String get outcome => _outcome;
  set outcome(String value) {
    _outcome = value;
    notifyListeners();
  }

  String _obstacle = "";
  String get obstacle => _obstacle;
  set obstacle(String value) {
    _obstacle = value;
    notifyListeners();
  }

  String _copingPlan = "";
  String get copingPlan => _copingPlan;
  set copingPlan(String value) {
    _copingPlan = value;
    notifyListeners();
  }

  List<MentalContrastingStep> screenOrder = getScreenOrder(0);

  Future<bool> getInitialValues() async {
    return true;
  }

  @override
  bool canMoveBack(ValueKey currentPageKey) {
    return true;
  }

  @override
  bool canMoveNext(ValueKey currentPageKey) {
    var stepKey = currentPageKey.value as MentalContrastingStep;

    switch (stepKey) {
      case MentalContrastingStep.obstacleEnter:
        return obstacle.isNotEmpty;
      case MentalContrastingStep.outcomeEnter:
        return outcome.isNotEmpty;
      case MentalContrastingStep.copingPlanCreation:
        return copingPlan.isNotEmpty;
    }
  }

  @override
  void submit() async {
    if (state == ViewState.idle) {
      setState(ViewState.busy);

      await Future.wait([
        dataService.saveSimpleValueWithTimestamp(obstacle, "obstacles"),
        dataService.saveSimpleValueWithTimestamp(outcome, "outcomes"),
        dataService.saveSimpleValueWithTimestamp(copingPlan, "copingPlans"),
        _experimentService.onMentalContrastingComplete()
      ]);

      _experimentService.nextScreen(RouteNames.DISTRIBUTED_LEARNING);
    }
  }
}
