import 'package:flutter/material.dart';
import 'package:prompt/models/assessment.dart';
import 'package:prompt/screens/assessments/multi_step_assessment.dart';
import 'package:prompt/screens/assessments/questionnaire.dart';
import 'package:prompt/shared/enums.dart';
import 'package:prompt/viewmodels/morning_assessment_view_model.dart';
import 'package:provider/provider.dart';

class MorningAssessmentScreen extends StatefulWidget {
  MorningAssessmentScreen({Key? key}) : super(key: key);

  @override
  MorningAssessmentScreenState createState() => MorningAssessmentScreenState();
}

class MorningAssessmentScreenState extends State<MorningAssessmentScreen> {
  List<Widget> _pages = [];

  late MorningAssessmentViewModel vm =
      Provider.of<MorningAssessmentViewModel>(context);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _pages = [];

    Map<MorningAssessmentStep, Widget> _stepScreenMap = {
      MorningAssessmentStep.selfEfficacy: selfEfficacyQuestionnaire,
    };

    for (var page in ScreenOrder) {
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

  late var selfEfficacyQuestionnaire = questionnaire(
      AssessmentTypes.selfEfficacy,
      ValueKey(MorningAssessmentStep.selfEfficacy));

  Widget questionnaire(AssessmentTypes assessmentTypes, Key key) {
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
