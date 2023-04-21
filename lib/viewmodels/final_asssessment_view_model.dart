import 'package:prompt/services/data_service.dart';
import 'package:prompt/services/study_service.dart';
import 'package:prompt/viewmodels/multi_page_view_model.dart';

enum FinalAssessmentStep {
  introduction,
  assessment_finalSession_1,
  assessment_finalSession_2,
  assessment_finalSession_3,
  planDisplay,
  assessment_finalSession_4,
  completed
}

class FinalAssessmentViewModel extends MultiPageViewModel {
  List<FinalAssessmentStep> screenOrder = [
    FinalAssessmentStep.introduction,
    FinalAssessmentStep.assessment_finalSession_1,
    FinalAssessmentStep.assessment_finalSession_2,
    FinalAssessmentStep.assessment_finalSession_3,
    FinalAssessmentStep.planDisplay,
    FinalAssessmentStep.assessment_finalSession_4,
    FinalAssessmentStep.completed
  ];

  final StudyService experimentService;
  final DataService _dataService;

  int group = 0;

  FinalAssessmentViewModel(this._dataService, this.experimentService);

  @override
  bool canMoveBack() {
    return false;
  }

  @override
  bool canMoveNext() {
    return true;
  }

  int getStepIndex(FinalAssessmentStep step) {
    return screenOrder.indexOf(step);
  }

  Future<String> getPlan() async {
    var lastPlan = await _dataService.getLastPlan();
    if (lastPlan != null) {
      return lastPlan;
    } else {
      return "";
    }
  }

  @override
  void submit() {
    // experimentService.submitResponses(questionnaireResponses, FINAL_ASSESSMENT);

    experimentService.nextScreen();
  }
}
