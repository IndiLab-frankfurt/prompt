import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:prompt/screens/assessments/multi_step_assessment.dart';
import 'package:prompt/screens/assessments/multi_step_questionnaire_future.dart';
import 'package:prompt/screens/placeholder_screen.dart';
import 'package:prompt/shared/app_strings.dart';
import 'package:prompt/shared/enums.dart';
import 'package:prompt/shared/ui_helper.dart';
import 'package:prompt/viewmodels/evening_assessment_view_model.dart';
import 'package:provider/provider.dart';

class EveningAssessmentScreen extends StatefulWidget {
  EveningAssessmentScreen({Key? key}) : super(key: key);

  @override
  EveningAssessmentScreenState createState() => EveningAssessmentScreenState();
}

class EveningAssessmentScreenState extends State<EveningAssessmentScreen> {
  List<Widget> _pages = [];

  late EveningAssessmentViewModel vm =
      Provider.of<EveningAssessmentViewModel>(context);

  late Map<EveningAssessmentStep, Widget> _stepScreenMap = {
    EveningAssessmentStep.didLearnCabuuToday: didLearnCabuuTodayQuestionnaire,
    EveningAssessmentStep.continueAfterCabuu: continueAfterCabuuScreen,
    EveningAssessmentStep.assessment_evening_1: evening1,
    EveningAssessmentStep.assessment_evening_2: evening2,
    EveningAssessmentStep.assessment_evening_3: evening3,
    EveningAssessmentStep.completed: completed,
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
            // appBar: SereneAppBar(),
            // drawer: SereneDrawer(),
            body: SafeArea(
                child: Container(
                    margin: UIHelper.containerMargin,
                    child: MultiStepAssessment(
                      vm,
                      _pages,
                      // initialStep: vm.getPreviouslyCompletedStep(),
                    )))));
  }

  late var continueAfterCabuuScreen = PlaceholderScreen(
      text:
          "Mache hier erst weiter, wenn du heute mit cabuu gelernt hast. Falls du heute _nicht_ mit cabuu lernst, sollst du erst morgen mit PROMPT weitermachen.",
      key: ValueKey(EveningAssessmentStep.continueAfterCabuu));

  late var didLearnCabuuTodayQuestionnaire = MultiStepQuestionnaireFuture(
      vm: vm,
      questionnaireName: AssessmentTypes.didLearnToday,
      key: ValueKey(EveningAssessmentStep.didLearnCabuuToday));

  late var evening1 = MultiStepQuestionnaireFuture(
      vm: vm,
      questionnaireName: AssessmentTypes.evening_1,
      key: ValueKey(EveningAssessmentStep.assessment_evening_1));

  late var evening2 = MultiStepQuestionnaireFuture(
      vm: vm,
      questionnaireName: AssessmentTypes.evening_2,
      key: ValueKey(EveningAssessmentStep.assessment_evening_2));

  late var evening3 = MultiStepQuestionnaireFuture(
      vm: vm,
      questionnaireName: AssessmentTypes.evening_3,
      key: ValueKey(EveningAssessmentStep.assessment_evening_3));

  late var completed = ListView(children: [
    UIHelper.verticalSpaceLarge(),
    MarkdownBody(
        data: "# " + AppStrings.EveningAssessment_Completed,
        key: ValueKey(EveningAssessmentStep.completed))
  ]);
}
