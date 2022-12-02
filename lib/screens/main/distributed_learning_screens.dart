import 'package:flutter/material.dart';
import 'package:prompt/data/questions.dart';
import 'package:prompt/screens/assessments/multi_step_assessment.dart';
import 'package:prompt/screens/assessments/multi_step_questionnaire_future.dart';
import 'package:prompt/screens/session_zero/text_screen.dart';
import 'package:prompt/shared/app_strings.dart';
import 'package:prompt/shared/ui_helper.dart';
import 'package:prompt/viewmodels/distributed_learning_view_model.dart';
import 'package:prompt/widgets/prompt_appbar.dart';
import 'package:prompt/widgets/prompt_drawer.dart';
import 'package:prompt/widgets/video_screen.dart';
import 'package:provider/provider.dart';
import 'package:async/async.dart';

class DistributedLearningScreens extends StatefulWidget {
  DistributedLearningScreens({Key? key}) : super(key: key);

  @override
  _DistributedLearningScreensState createState() =>
      _DistributedLearningScreensState();
}

class _DistributedLearningScreensState
    extends State<DistributedLearningScreens> {
  List<Widget> _pages = [];

  final AsyncMemoizer _memoizer = AsyncMemoizer();

  late DistributedLearningViewModel vm =
      Provider.of<DistributedLearningViewModel>(context);

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

  Widget getScreen(DistributedLearningStep step) {
    var key = ValueKey(step);
    switch (step) {
      case DistributedLearningStep.introduction_distributedLearning:
        return TextScreen(paragraphs: [
          AppStrings.SessionZero_Introduction_DistributedLearning_1
        ], key: key);

      case DistributedLearningStep.video_distributedLearning:
        return VideoScreen(
            videoURL: "assets/videos/VerteiltesLernen.mp4",
            onVideoCompleted: vm.videoDistributedLearningCompleted,
            key: key);

      case DistributedLearningStep.questions_vocablearning:
        return MultiStepQuestionnairePage(
          key: key,
          vm: vm,
          questionnaire: vocabQuestionGoal,
        );
    }
  }
}
