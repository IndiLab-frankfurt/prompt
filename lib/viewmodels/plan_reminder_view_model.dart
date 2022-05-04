import 'package:flutter/material.dart';
import 'package:prompt/services/data_service.dart';
import 'package:prompt/services/experiment_service.dart';
import 'package:prompt/shared/enums.dart';
import 'package:prompt/shared/route_names.dart';
import 'package:prompt/viewmodels/internalisation_view_model.dart';
import 'package:prompt/viewmodels/multi_step_assessment_view_model.dart';

enum PlanReminderStep { planInternalisationEmoji }

class PlanReminderViewModel extends MultiStepAssessmentViewModel {
  final ExperimentService _experimentService;
  InternalisationViewModel internalisationViewModel =
      InternalisationViewModel.withCondition(InternalisationCondition.emojiIf);

  PlanReminderViewModel(DataService dataService, this._experimentService)
      : super(dataService);

  static List<Enum> getScreenOrder(int group) {
    List<Enum> screenOrder = [
      PlanReminderStep.planInternalisationEmoji,
    ];

    return screenOrder;
  }

  List<Enum> screenOrder = getScreenOrder(0);

  Future<bool> getInitialValues() async {
    return true;
  }

  void onInternalisationCompleted(String input) {
    notifyListeners();
  }

  @override
  bool canMoveBack(ValueKey currentPageKey) {
    return true;
  }

  @override
  bool canMoveNext(ValueKey currentPageKey) {
    var stepKey = currentPageKey.value as PlanReminderStep;

    switch (stepKey) {
      case PlanReminderStep.planInternalisationEmoji:
        return true;
    }
  }

  @override
  void submit() async {
    if (state == ViewState.idle) {
      setState(ViewState.busy);
      // var oneBigAssessment = this.getOneBisAssessment("MentalContrasting");

      // await Future.wait([
      //   dataService.saveSimpleValueWithTimestamp(obstacle, "obstacles"),
      //   dataService.saveSimpleValueWithTimestamp(outcome, "outcomes"),
      //   dataService.saveSimpleValueWithTimestamp(copingPlan, "copingPlans"),
      // ]);

      _experimentService.nextScreen(RouteNames.DISTRIBUTED_LEARNING);
    }
  }
}
