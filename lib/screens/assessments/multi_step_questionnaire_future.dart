import 'package:flutter/material.dart';
import 'package:prompt/models/assessment.dart';
import 'package:prompt/screens/assessments/questionnaire_screen.dart';

import 'package:prompt/viewmodels/multi_step_assessment_view_model.dart';

class MultiStepQuestionnaireFuture extends StatelessWidget {
  final MultiStepAssessmentViewModel vm;
  final String questionnaireName;

  const MultiStepQuestionnaireFuture(
      {Key? key, required this.vm, required this.questionnaireName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        key: key,
        future: vm.getQuestionnaire(questionnaireName),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data is Assessment) {
              var assessment = snapshot.data as Assessment;
              return QuestionnaireScreen(
                  assessment, vm.saveQuestionnaireResponse,
                  onAssessmentCompleted: vm.onAssessmentCompleted,
                  onLoaded: vm.onAssessmentLoaded,
                  key: key);
            }
          }
          return Container(child: CircularProgressIndicator());
        });
  }
}
