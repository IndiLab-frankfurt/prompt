import 'package:flutter/material.dart';
import 'package:prompt/services/data_service.dart';
import 'package:prompt/services/experiment_service.dart';
import 'package:prompt/shared/enums.dart';
import 'package:prompt/shared/route_names.dart';
import 'package:prompt/viewmodels/multi_step_assessment_view_model.dart';

enum DistributedLearningStep {
  introduction_distributedLearning,
  video_distributedLearning,
  questions_vocablearning,
}

class DistributedLearningViewModel extends MultiStepAssessmentViewModel {
  final ExperimentService _experimentService;

  DistributedLearningViewModel(DataService dataService, this._experimentService)
      : super(dataService);

  static List<DistributedLearningStep> getScreenOrder(int group) {
    List<DistributedLearningStep> screenOrder = [
      DistributedLearningStep.questions_vocablearning,
      DistributedLearningStep.introduction_distributedLearning,
      DistributedLearningStep.video_distributedLearning,
    ];

    return screenOrder;
  }

  List<DistributedLearningStep> screenOrder = getScreenOrder(0);

  bool _videoDistributedLearningCompleted = false;
  void videoDistributedLearningCompleted() {
    _videoDistributedLearningCompleted = true;
    notifyListeners();
  }

  Future<bool> getInitialValues() async {
    return true;
  }

  @override
  bool canMoveBack(ValueKey currentPageKey) {
    return true;
  }

  @override
  bool canMoveNext(ValueKey currentPageKey) {
    var stepKey = currentPageKey.value as DistributedLearningStep;

    switch (stepKey) {
      case DistributedLearningStep.introduction_distributedLearning:
        return true;
      case DistributedLearningStep.video_distributedLearning:
        return true;
      case DistributedLearningStep.questions_vocablearning:
        return currentAssessmentIsFilledOut;
    }
  }

  @override
  void submit() async {
    if (state == ViewState.idle) {
      setState(ViewState.busy);
      var oneBigAssessment = this.getOneBisAssessment("DistributedLearning");

      _experimentService.submitAssessment(
          oneBigAssessment, "DistributedLearning");

      await _experimentService.onDistributedLearningComplete();

      _experimentService.nextScreen(RouteNames.DISTRIBUTED_LEARNING);
    }
  }
}
