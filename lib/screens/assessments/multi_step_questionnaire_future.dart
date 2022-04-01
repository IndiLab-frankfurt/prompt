import 'package:flutter/material.dart';
import 'package:prompt/models/questionnaire.dart';
import 'package:prompt/screens/assessments/questionnaire_page.dart';
import 'package:prompt/viewmodels/multi_step_assessment_view_model.dart';

class MultiStepQuestionnairePage extends StatelessWidget {
  final MultiStepAssessmentViewModel vm;
  final Questionnaire questionnaire;

  const MultiStepQuestionnairePage(
      {Key? key, required this.vm, required this.questionnaire})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return QuestionnairePage(questionnaire, vm.setAssessmentResult,
        onAssessmentCompleted: vm.onAssessmentCompleted,
        onLoaded: vm.onAssessmentLoaded,
        key: key);
  }
}
