import 'package:flutter/material.dart';
import 'package:prompt/screens/assessments/multi_step_assessment.dart';
import 'package:prompt/screens/session_zero/cabuu_link_screen.dart';
import 'package:prompt/screens/session_zero/welcome_screen.dart';
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

  Widget welcomeScreen = WelcomeScreen(key: ValueKey(SessionZeroStep.welcome));

  Widget cabuuLinkScreen =
      CabuuLinkScreen(key: ValueKey(SessionZeroStep.cabuuLink));
}
