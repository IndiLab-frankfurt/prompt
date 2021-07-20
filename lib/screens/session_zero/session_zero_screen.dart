import 'package:flutter/material.dart';
import 'package:prompt/models/assessment.dart';
import 'package:prompt/screens/assessments/multi_step_assessment.dart';
import 'package:prompt/screens/assessments/questionnaire.dart';
import 'package:prompt/screens/session_zero/cabuu_link_screen.dart';
import 'package:prompt/screens/session_zero/mascot_selection_screen.dart';
import 'package:prompt/screens/session_zero/welcome_screen.dart';
import 'package:prompt/shared/enums.dart';
import 'package:prompt/viewmodels/session_zero_view_model.dart';
import 'package:provider/provider.dart';

class SessionZeroScreen extends StatefulWidget {
  SessionZeroScreen({Key? key}) : super(key: key);

  @override
  _SessionZeroScreenState createState() => _SessionZeroScreenState();
}

class _SessionZeroScreenState extends State<SessionZeroScreen> {
  List<Widget> _pages = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Map<SessionZeroStep, Widget> _stepScreenMap = {
      SessionZeroStep.welcome: welcomeScreen,
      SessionZeroStep.cabuuLink: cabuuLinkScreen,
      SessionZeroStep.mascotSelection: mascotSelectionScreen,
      SessionZeroStep.motivationQuestionnaire: motivationQuestionnaire
    };

    for (var page in ScreenOrder) {
      if (_stepScreenMap.containsKey(page)) {
        _pages.add(_stepScreenMap[page]!);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var vm = Provider.of<SessionZeroViewModel>(context);
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

  var welcomeScreen = WelcomeScreen(key: ValueKey(SessionZeroStep.welcome));

  var cabuuLinkScreen =
      CabuuLinkScreen(key: ValueKey(SessionZeroStep.cabuuLink));

  var mascotSelectionScreen =
      MascotSelectionScreen(key: ValueKey(SessionZeroStep.mascotSelection));

  late var motivationQuestionnaire = questionnaire(AssessmentTypes.motivation,
      ValueKey(SessionZeroStep.motivationQuestionnaire));

  Widget questionnaire(AssessmentTypes assessmentTypes, Key key) {
    var vm = Provider.of<SessionZeroViewModel>(context);
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
