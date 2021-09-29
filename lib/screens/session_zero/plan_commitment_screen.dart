import 'package:flutter/material.dart';
import 'package:prompt/screens/assessments/multi_step_questionnaire_future.dart';
import 'package:prompt/shared/enums.dart';
import 'package:prompt/viewmodels/session_zero_view_model.dart';
import 'package:prompt/widgets/speech_bubble.dart';
import 'package:provider/provider.dart';

class PlanCommitmentScreen extends StatefulWidget {
  PlanCommitmentScreen({Key? key}) : super(key: key);

  @override
  _PlanCommitmentScreenState createState() => _PlanCommitmentScreenState();
}

class _PlanCommitmentScreenState extends State<PlanCommitmentScreen> {
  late final vm = Provider.of<SessionZeroViewModel>(context);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListView(
      children: [
        SpeechBubble(text: vm.plan),
        MultiStepQuestionnaireFuture(
          vm: vm,
          assessmentTypes: AssessmentTypes.planCommitment,
        )
      ],
    ));
  }
}
