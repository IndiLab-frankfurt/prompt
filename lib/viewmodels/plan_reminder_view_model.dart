import 'package:flutter/material.dart';
import 'package:prompt/data/questions.dart';
import 'package:prompt/services/data_service.dart';
import 'package:prompt/services/experiment_service.dart';
import 'package:prompt/shared/enums.dart';
import 'package:prompt/shared/route_names.dart';
import 'package:prompt/viewmodels/internalisation_view_model.dart';
import 'package:prompt/viewmodels/multi_step_assessment_view_model.dart';

enum PlanReminderStep {
  planInternalisationEmoji,
  usabilityQuestions,
  efficacyQuestions
}

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
          value ? screenOrder.add(PlanReminderStep.usabilityQuestions) : true)),
      _experimentService.isEfficacyQuestionsDay().then(((value) =>
          value ? screenOrder.add(PlanReminderStep.efficacyQuestions) : true))
    ];

    await Future.wait(futures);

    return true;
  }

  void onInternalisationCompleted(String input) {
    notifyListeners();
  }

  @override
  Future<bool> doStepDependentSubmission(ValueKey currentPageKey) async {
    super.doStepDependentSubmission(currentPageKey);
    var stepKey = currentPageKey.value as PlanReminderStep;

    if (stepKey == PlanReminderStep.efficacyQuestions) {
      submitAssessmentResult(promptEfficacyQuestions.id);
    }
    if (stepKey == PlanReminderStep.usabilityQuestions) {
      submitAssessmentResult(usabilityQuestions.id);
    }

    return true;
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
      case PlanReminderStep.efficacyQuestions:
        return currentAssessmentIsFilledOut;
    }
  }

  @override
  void submit() async {
    if (state == ViewState.idle) {
      setState(ViewState.busy);
      // var oneBigAssessment = this.getOneBisAssessment("usability_efficacy");
      // var f1 = _experimentService.submitAssessment(
      //     oneBigAssessment, usabilityQuestions.id);
      var f2 = _experimentService
          .onPlanReminderComplete(internalisationViewModel.input);

      await Future.wait([f2]);
      // await Future.wait([
      //   dataService.saveSimpleValueWithTimestamp(obstacle, "obstacles"),
      //   dataService.saveSimpleValueWithTimestamp(outcome, "outcomes"),
      //   dataService.saveSimpleValueWithTimestamp(copingPlan, "copingPlans"),
      // ]);

      _experimentService.nextScreen(RouteNames.DISTRIBUTED_LEARNING);
    }
  }
}
