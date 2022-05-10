import 'package:flutter/material.dart';
import 'package:prompt/data/questions.dart';
import 'package:prompt/services/data_service.dart';
import 'package:prompt/services/experiment_service.dart';
import 'package:prompt/shared/enums.dart';
import 'package:prompt/shared/route_names.dart';
import 'package:prompt/viewmodels/internalisation_view_model.dart';
import 'package:prompt/viewmodels/multi_step_assessment_view_model.dart';

enum PlanReminderStep { planInternalisationEmoji, usabilityQuestions }

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
    List<Future> futures = [
      dataService
          .getLastPlan()
          .then((value) => internalisationViewModel.plan = value?.plan ?? ""),
      _experimentService.isUsabilityDay().then(((value) =>
          value ? screenOrder.add(PlanReminderStep.usabilityQuestions) : true))
    ];

    await Future.wait(futures);

    // var plan = await dataService.getLastPlan();
    // if (plan != null) {
    //   internalisationViewModel.plan = plan.plan;
    // }

    // if (await _experimentService.isUsabilityDay()) {
    //   screenOrder.add(PlanReminderStep.usabilityQuestions);
    // }

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
        return internalisationViewModel.completed;
      case PlanReminderStep.usabilityQuestions:
        return currentAssessmentIsFilledOut;
    }
  }

  @override
  void submit() async {
    if (state == ViewState.idle) {
      setState(ViewState.busy);
      var oneBigAssessment = this.getOneBisAssessment(usabilityQuestions.id);
      var f1 = _experimentService.submitAssessment(
          oneBigAssessment, usabilityQuestions.id);
      var f2 = _experimentService
          .onPlanReminderComplete(internalisationViewModel.input);

      await Future.wait([f1, f2]);
      // await Future.wait([
      //   dataService.saveSimpleValueWithTimestamp(obstacle, "obstacles"),
      //   dataService.saveSimpleValueWithTimestamp(outcome, "outcomes"),
      //   dataService.saveSimpleValueWithTimestamp(copingPlan, "copingPlans"),
      // ]);

      _experimentService.nextScreen(RouteNames.DISTRIBUTED_LEARNING);
    }
  }
}
