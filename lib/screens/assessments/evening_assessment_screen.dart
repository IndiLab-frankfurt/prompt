import 'package:flutter/material.dart';
import 'package:prompt/models/assessment.dart';
import 'package:prompt/screens/assessments/multi_step_assessment.dart';
import 'package:prompt/screens/assessments/multi_step_questionnaire_future.dart';
import 'package:prompt/screens/assessments/questionnaire.dart';
import 'package:prompt/shared/enums.dart';
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

  late Map<String, Widget> _stepScreenMap = {
    didLearnCabuuToday: didLearnCabuuTodayQuestionnaire,
    eveningItems: eveningQuestionnaire,
  };
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _pages = [];

    for (var page in vm.screenOrder) {
      if (_stepScreenMap.containsKey(page)) {
        _pages.add(_stepScreenMap[page]!);
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
            body: Container(
                child: MultiStepAssessment(
          vm,
          _pages,
          // initialStep: vm.getPreviouslyCompletedStep(),
        ))));
  }

  late var didLearnCabuuTodayQuestionnaire = MultiStepQuestionnaireFuture(
      vm: vm,
      assessmentTypes: AssessmentTypes.didLearnToday,
      key: ValueKey(didLearnCabuuToday));

  late var eveningQuestionnaire = MultiStepQuestionnaireFuture(
      vm: vm,
      assessmentTypes: AssessmentTypes.selfEfficacy,
      key: ValueKey(eveningItems));
}
