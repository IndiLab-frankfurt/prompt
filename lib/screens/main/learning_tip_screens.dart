import 'package:flutter/material.dart';
import 'package:prompt/data/questions.dart';
import 'package:prompt/dialogs/single_learning_tip_dialog.dart';
import 'package:prompt/screens/assessments/multi_step_assessment.dart';
import 'package:prompt/screens/assessments/multi_step_questionnaire_future.dart';
import 'package:prompt/screens/main/single_learning_tip_screen.dart';
import 'package:prompt/screens/session_zero/text_screen.dart';
import 'package:prompt/shared/app_strings.dart';
import 'package:prompt/shared/ui_helper.dart';
import 'package:prompt/viewmodels/learning_tip_view_model.dart';
import 'package:prompt/widgets/prompt_appbar.dart';
import 'package:prompt/widgets/prompt_drawer.dart';
import 'package:provider/provider.dart';
import 'package:async/async.dart';

class LearningTipScreens extends StatefulWidget {
  LearningTipScreens({Key? key}) : super(key: key);

  @override
  _LearningTipScreensState createState() => _LearningTipScreensState();
}

class _LearningTipScreensState extends State<LearningTipScreens> {
  List<Widget> _pages = [];

  final AsyncMemoizer _memoizer = AsyncMemoizer();

  late LearningTipViewModel vm = Provider.of<LearningTipViewModel>(context);

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

  Widget getScreen(LearningTipSteps step) {
    var key = ValueKey(step);
    switch (step) {
      case LearningTipSteps.learningTip:
        return SingleLearningTipScreen(key: key);

      case LearningTipSteps.assessment:
        return MultiStepQuestionnairePage(
          key: key,
          vm: vm,
          questionnaire: learningTipQuestions,
        );
    }
  }
}
