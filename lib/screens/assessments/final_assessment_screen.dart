import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:prompt/screens/assessments/multi_step_assessment.dart';
import 'package:prompt/screens/assessments/multi_step_questionnaire_future.dart';
import 'package:prompt/shared/enums.dart';
import 'package:prompt/shared/ui_helper.dart';
import 'package:prompt/viewmodels/final_asssessment_view_model.dart';
import 'package:provider/provider.dart';

class FinalAssessmentScreen extends StatefulWidget {
  const FinalAssessmentScreen({Key? key}) : super(key: key);

  @override
  _FinalAssessmentScreenState createState() => _FinalAssessmentScreenState();
}

class _FinalAssessmentScreenState extends State<FinalAssessmentScreen> {
  List<Widget> _pages = [];

  late FinalAssessmentViewModel vm =
      Provider.of<FinalAssessmentViewModel>(context);

  late Map<FinalAssessmentStep, Widget> _stepScreenMap = {
    FinalAssessmentStep.assessment_finalSession_1: finalSession1,
    FinalAssessmentStep.assessment_finalSession_2: finalSession2,
    FinalAssessmentStep.assessment_finalSession_3: finalSession3,
    FinalAssessmentStep.assessment_finalSession_4: finalSession4,
    FinalAssessmentStep.completed: completed
  };

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _pages = [];

    for (var page in vm.screenOrder) {
      if (_stepScreenMap.containsKey(page)) {
        _pages.add(_stepScreenMap[page]!);
      } else {
        throw Exception("The requested screen is not mapped");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
            body: Container(
                margin: UIHelper.containerMargin,
                child: MultiStepAssessment(
                  vm,
                  _pages,
                ))));
  }

  late var finalSession1 = MultiStepQuestionnaireFuture(
      vm: vm,
      assessmentTypes: AssessmentTypes.finalSession_1,
      key: ValueKey(FinalAssessmentStep.assessment_finalSession_1));

  late var finalSession2 = MultiStepQuestionnaireFuture(
      vm: vm,
      assessmentTypes: AssessmentTypes.finalSession_2,
      key: ValueKey(FinalAssessmentStep.assessment_finalSession_2));

  late var finalSession3 = MultiStepQuestionnaireFuture(
      vm: vm,
      assessmentTypes: AssessmentTypes.finalSession_3,
      key: ValueKey(FinalAssessmentStep.assessment_finalSession_3));

  late var finalSession4 = MultiStepQuestionnaireFuture(
      vm: vm,
      assessmentTypes: AssessmentTypes.finalSession_4,
      key: ValueKey(FinalAssessmentStep.assessment_finalSession_4));

  late var completed = ListView(children: [
    UIHelper.verticalSpaceLarge(),
    MarkdownBody(
        data: "### " +
            "Du bist jetzt fertig mit der Studie! Vielen Dank, dass du so toll mitgemacht hast!"),
    UIHelper.verticalSpaceMedium(),
    MarkdownBody(
        data: "### " +
            "Wir senden dir in den kommenden Wochen den Amazon-Gutschein zu. Bitte habe etwas Geduld - du solltest im Januar von uns hören."),
    UIHelper.verticalSpaceMedium(),
    MarkdownBody(
        data: "### " +
            "Die App cabuu kannst du nun kostenlos weiter verwenden. Die App PROMPT kannst du deinstallieren."),
  ]);
}
