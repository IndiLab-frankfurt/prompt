import 'package:flutter/material.dart';
import 'package:prompt/models/learning_tip.dart';
import 'package:prompt/services/data_service.dart';
import 'package:prompt/services/experiment_service.dart';
import 'package:prompt/shared/route_names.dart';
import 'package:prompt/viewmodels/multi_step_assessment_view_model.dart';

enum LearningTipSteps {
  learningTip,
  assessment,
}

class LearningTipViewModel extends MultiStepAssessmentViewModel {
  LearningTip? learningTip;
  ExperimentService _experimentService;

  LearningTipViewModel(this._experimentService, DataService _dataService)
      : super(_dataService);

  static List<LearningTipSteps> getScreenOrder(int group) {
    List<LearningTipSteps> screenOrder = [
      LearningTipSteps.learningTip,
      LearningTipSteps.assessment,
    ];

    return screenOrder;
  }

  Future<bool> getInitialValues() async {
    return true;
  }

  List<LearningTipSteps> screenOrder = getScreenOrder(0);

  Future<LearningTip> getLearningTip() async {
    learningTip = await _experimentService.getCurrentLearningTip();
    return learningTip!;
  }

  void submit() async {
    if (learningTip != null) {
      await _experimentService.onLearningTipComplete(learningTip!);
    }

    var oneBigAssessment = this.getOneBisAssessment("learning_tip_assesment");

    await _experimentService.submitAssessment(
        oneBigAssessment, "learning_tip_assesment");

    _experimentService.nextScreen(RouteNames.SINGLE_LEARNING_TIP);
  }

  @override
  bool canMoveBack(ValueKey currentPageKey) {
    return true;
  }

  @override
  bool canMoveNext(ValueKey currentPageKey) {
    var stepkey = currentPageKey.value as LearningTipSteps;

    if (stepkey == LearningTipSteps.assessment) {
      return currentAssessmentIsFilledOut;
    }

    return true;
  }
}
