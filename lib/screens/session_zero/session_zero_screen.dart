import 'package:flutter/material.dart';
import 'package:prompt/data/questions.dart';
import 'package:prompt/screens/assessments/multi_step_assessment.dart';
import 'package:prompt/screens/assessments/multi_step_questionnaire_future.dart';
import 'package:prompt/screens/assessments/questionnaire_page.dart';
import 'package:prompt/screens/internalisation/emoji_internalisation_screen.dart';
import 'package:prompt/screens/internalisation/waiting_internalisation_screen.dart';
import 'package:prompt/screens/session_zero/mascot_selection_screen.dart';
import 'package:prompt/screens/session_zero/obstacle_enter_screen.dart';
import 'package:prompt/screens/session_zero/outcome_enter_screen.dart';
import 'package:prompt/screens/session_zero/outcome_selection_screen.dart';
import 'package:prompt/screens/session_zero/outcome_sorting_screen.dart';
import 'package:prompt/screens/session_zero/plan_creation_screen.dart';
import 'package:prompt/screens/session_zero/plan_display_screen.dart';
import 'package:prompt/screens/session_zero/text_screen.dart';
import 'package:prompt/screens/session_zero/welcome_screen.dart';
import 'package:prompt/screens/session_zero/who_are_you_screen.dart';
import 'package:prompt/shared/app_strings.dart';
import 'package:prompt/shared/ui_helper.dart';
import 'package:prompt/viewmodels/session_zero_view_model.dart';
import 'package:prompt/widgets/prompt_appbar.dart';
import 'package:prompt/widgets/prompt_drawer.dart';
import 'package:prompt/widgets/video_screen.dart';
import 'package:provider/provider.dart';
import 'package:async/async.dart';

class SessionZeroScreen extends StatefulWidget {
  SessionZeroScreen({Key? key}) : super(key: key);

  @override
  _SessionZeroScreenState createState() => _SessionZeroScreenState();
}

class _SessionZeroScreenState extends State<SessionZeroScreen> {
  List<Widget> _pages = [];

  final AsyncMemoizer _memoizer = AsyncMemoizer();

  late SessionZeroViewModel vm = Provider.of<SessionZeroViewModel>(context);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Map<SessionZeroStep, Widget> _stepScreenMap = {
    //   SessionZeroStep.welcome: welcomeScreen,
    //   SessionZeroStep.whoAreYou: whoAreYouScreen,
    //   SessionZeroStep.video_introduction: introductionVideo,
    //   SessionZeroStep.questions_sociodemographics: questions_sociodemographic,
    //   SessionZeroStep.mascotSelection: mascotSelectionScreen,
    //   SessionZeroStep.video_distributedLearning: videoDistributedLearning,
    //   SessionZeroStep.video_planning: videoPlanning,
    //   SessionZeroStep.planCreation: planCreation,
    //   SessionZeroStep.planDisplay: planDisplay,
    //   SessionZeroStep.planInternalisationEmoji: planInternalisationEmoji,
    //   SessionZeroStep.planInternalisationWaiting: planInternalisationWaiting,
    //   SessionZeroStep.outcomeSelection: outcomeSelection
    // };

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
            )));
  }

  Widget getScreen(SessionZeroStep step) {
    var key = ValueKey(step);
    switch (step) {
      case SessionZeroStep.welcome:
        return WelcomeScreen(key: key);

      case SessionZeroStep.whoAreYou:
        return WhoAreYouScreen(key: key);

      case SessionZeroStep.video_introduction:
        return VideoScreen('assets/videos/videoPlanning.mp4',
            key: key, onVideoCompleted: vm.videoPlanningCompleted);

      case SessionZeroStep.questions_sociodemographics:
        return MultiStepQuestionnairePage(
          key: key,
          vm: vm,
          questionnaire: sociodemographicQuestions,
        );

      case SessionZeroStep.introduction_distributedLearning:
        return TextScreen(paragraphs: [
          AppStrings.SessionZero_Introduction_DistributedLearning_1
        ], key: key);

      case SessionZeroStep.video_distributedLearning:
        return VideoScreen('assets/videos/videoDistributedLearning.mp4',
            key: key, onVideoCompleted: vm.videoDistributedLearningCompleted);

      case SessionZeroStep.introduction_planning:
        return TextScreen(
            paragraphs: [AppStrings.SessionZero_Introduction_Planning_1],
            key: key);

      case SessionZeroStep.video_planning:
        return VideoScreen('assets/videos/videoPlanning.mp4',
            key: key, onVideoCompleted: vm.videoPlanningCompleted);

      case SessionZeroStep.planCreation:
        return PlanCreationScreen(key: key);

      case SessionZeroStep.planDisplay:
        return PlanDisplayScreen(key: key);

      case SessionZeroStep.planInternalisationWaiting:
        return ChangeNotifierProvider.value(
            value: vm.internalisationViewmodelWaiting,
            key: ValueKey(SessionZeroStep.planInternalisationWaiting),
            child: WaitingInternalisationScreen(Duration(seconds: 15),
                onCompleted: vm.onWaitingInternalisationCompleted,
                key: ValueKey(SessionZeroStep.planInternalisationWaiting)));

      case SessionZeroStep.planInternalisationEmoji:
        return ChangeNotifierProvider.value(
            value: vm.internalisationViewmodelEmoji,
            key: ValueKey(SessionZeroStep.planInternalisationEmoji),
            child: EmojiInternalisationScreen(
                onCompleted: vm.onInternalisationCompleted,
                emojiInputIf: true,
                emojiInputThen: true,
                key: ValueKey(SessionZeroStep.planInternalisationEmoji)));

      case SessionZeroStep.obstacleList:
        return TextScreen(
            paragraphs: ["Hier kommt die Obstacle List hin"], key: key);

      case SessionZeroStep.copingPlanCreation:
        return TextScreen(
            paragraphs: ["Hier kommt die Coping Plan Erstellung hin"],
            key: key);

      case SessionZeroStep.mascotSelection:
        return MascotSelectionScreen(key: key);

      case SessionZeroStep.outcomeEnter:
        return OutcomeEnterScreen(key: key);

      case SessionZeroStep.obstacleEnter:
        return ObstacleEnterScreen(key: key);
    }
  }
}
