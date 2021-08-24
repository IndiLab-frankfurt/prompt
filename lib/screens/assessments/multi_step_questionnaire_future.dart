import 'package:flutter/material.dart';
import 'package:prompt/models/assessment.dart';
import 'package:prompt/screens/assessments/questionnaire.dart';
import 'package:prompt/shared/enums.dart';

import 'package:prompt/viewmodels/multi_step_assessment_view_model.dart';

class MultiStepQuestionnaireFuture extends StatelessWidget {
  final MultiStepAssessmentViewModel vm;
  final AssessmentTypes assessmentTypes;

  const MultiStepQuestionnaireFuture(
      {Key? key, required this.vm, required this.assessmentTypes})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        key: key,
        future: vm.getAssessment(assessmentTypes),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data is Assessment) {
              var assessment = snapshot.data as Assessment;
              return Questionnaire(assessment, vm.setAssessmentResult,
                  onLoaded: vm.onAssessmentLoaded, key: key);
            }
          }
          return Container(child: CircularProgressIndicator());
        });
  }
}
