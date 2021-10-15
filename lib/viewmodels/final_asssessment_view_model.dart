import 'package:flutter/material.dart';
import 'package:prompt/services/data_service.dart';
import 'package:prompt/services/experiment_service.dart';
import 'package:prompt/viewmodels/multi_step_assessment_view_model.dart';

enum FinalAssessmentStep { completed }

class FinalAssessmentViewModel extends MultiStepAssessmentViewModel {
  final ExperimentService experimentService;

  FinalAssessmentViewModel(DataService dataService, this.experimentService)
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
  void submit() {
    // TODO: implement submit
  }
}
