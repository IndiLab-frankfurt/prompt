import 'package:flutter/material.dart';
import 'package:prompt/screens/assessments/multi_step_assessment.dart';
import 'package:prompt/screens/session_zero/coping_plan_enter_screen.dart';
import 'package:prompt/screens/session_zero/obstacle_enter_screen.dart';
import 'package:prompt/screens/session_zero/outcome_enter_screen.dart';
import 'package:prompt/shared/ui_helper.dart';
import 'package:prompt/viewmodels/mental_contrasting_view_model.dart';
import 'package:prompt/widgets/prompt_appbar.dart';
import 'package:prompt/widgets/prompt_drawer.dart';
import 'package:provider/provider.dart';
import 'package:async/async.dart';

class MentalContrastingScreens extends StatefulWidget {
  MentalContrastingScreens({Key? key}) : super(key: key);

  @override
  _MentalContrastingScreensState createState() =>
      _MentalContrastingScreensState();
}

class _MentalContrastingScreensState extends State<MentalContrastingScreens> {
  List<Widget> _pages = [];

  final AsyncMemoizer _memoizer = AsyncMemoizer();

  late MentalContrastingViewModel vm =
      Provider.of<MentalContrastingViewModel>(context);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _pages = [];
    for (var screen in vm.screenOrder) {
      _pages.add(getScreen(screen));
    }
  }

  init() async {
    return this._memoizer.runOnce(() async {
      await vm.getInitialValues();
      return true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: Container(
          decoration: UIHelper.defaultBoxDecoration,
          child: Scaffold(
              appBar: PromptAppBar(showBackButton: true),
              drawer: PromptDrawer(),
              body: SafeArea(
                child: FutureBuilder(
                  future: init(),
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.hasData) {
                      return Container(
                          margin: UIHelper.containerMargin,
                          child: MultiStepAssessment(
                            vm,
                            _pages,
                          ));
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              )),
        ));
  }

  Widget getScreen(MentalContrastingStep step) {
    var key = ValueKey(step);
    switch (step) {
      case MentalContrastingStep.outcomeEnter:
        return OutcomeEnterScreen(key: key);

      case MentalContrastingStep.obstacleEnter:
        return ObstacleEnterScreen(key: key);

      case MentalContrastingStep.copingPlanCreation:
        return CopingPlanEnterScreen(key: key);
    }
  }
}
