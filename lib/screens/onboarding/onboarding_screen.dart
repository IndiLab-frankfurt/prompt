import 'package:flutter/material.dart';
import 'package:prompt/screens/assessments/multi_page_screen.dart';
import 'package:prompt/screens/internalisation/emoji_internalisation_screen.dart';
import 'package:prompt/screens/onboarding/cabuu_code_screen.dart';
import 'package:prompt/screens/onboarding/copingplan_enter_screen.dart';
import 'package:prompt/screens/onboarding/horizontal_questionnaire.dart';
import 'package:prompt/screens/onboarding/instructions_distributed_learning.dart';
import 'package:prompt/screens/onboarding/instructions_implementation_intentions.dart';
import 'package:prompt/screens/onboarding/obstacle_enter_screen.dart';
import 'package:prompt/screens/onboarding/outcome_enter_screen.dart';
import 'package:prompt/screens/onboarding/plan_creation_screen.dart';
import 'package:prompt/screens/onboarding/plan_display_screen.dart';
import 'package:prompt/screens/onboarding/plan_timing_screen.dart';
import 'package:prompt/screens/onboarding/reward_screen_1.dart';
import 'package:prompt/screens/onboarding/welcome_screen.dart';
import 'package:prompt/shared/ui_helper.dart';
import 'package:prompt/viewmodels/onboarding_view_model.dart';
import 'package:prompt/widgets/keep_alive_page.dart';
import 'package:prompt/widgets/prompt_appbar.dart';
import 'package:prompt/widgets/prompt_drawer.dart';
import 'package:prompt/screens/main/video_screen.dart';
import 'package:provider/provider.dart';
import 'package:async/async.dart';

class OnboardingScreen extends StatefulWidget {
  OnboardingScreen({Key? key}) : super(key: key);

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final AsyncMemoizer _memoizer = AsyncMemoizer();

  late OnboardingViewModel vm = Provider.of<OnboardingViewModel>(context);

  init() async {
    return this._memoizer.runOnce(() async {
      await vm.getInitialValues();

      List<Widget> _pages = [];

      for (var screen in vm.pages) {
        _pages.add(getScreen(screen));
      }

      return _pages;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: Container(
          decoration: UIHelper.defaultBoxDecoration,
          child: Scaffold(
              appBar: PromptAppBar(
                showBackButton: true,
                title: vm.pages[vm.page]
                    .toString()
                    .replaceAll("OnboardingStep.", ""),
              ),
              drawer: PromptDrawer(),
              resizeToAvoidBottomInset: false,
              body: FutureBuilder(
                future: init(),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.hasData) {
                    return Container(
                        decoration: UIHelper.defaultBoxDecoration,
                        padding: UIHelper.containerPadding,
                        child: MultiPageScreen(
                          vm,
                          snapshot.data,
                        ));
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              )),
        ));
  }

  Widget getScreen(OnboardingStep step) {
    var key = ValueKey(step);
    switch (step) {
      case OnboardingStep.welcome:
        return WelcomeScreen(key: key);
      case OnboardingStep.rewardScreen1:
        return RewardScreen1(key: key);
      case OnboardingStep.video_introduction:
        return VideoScreen(
          'assets/videos/intro_prompt_compressed.mp4',
          onVideoCompleted: vm.videoWelcomeCompleted,
          key: key,
        );
      case OnboardingStep.cabuuCode:
        return CabuuCodeScreen(key: key);
      case OnboardingStep.video_distributedLearning:
        return VideoScreen('assets/videos/videoDistributedLearning.mp4',
            key: key, onVideoCompleted: vm.videoDistributedLearningCompleted);
      case OnboardingStep.outcome:
        return OutcomeEnterScreen(key: key);
      case OnboardingStep.obstacle:
        return ObstacleEnterScreen(key: key);
      case OnboardingStep.copingPlan:
        return CopingPlanEnterScreen(key: key);
      case OnboardingStep.instructions_implementationIntentions:
        return InstructionsImplementationIntentions(key: key);
      case OnboardingStep.video_Planning:
        return VideoScreen('assets/videos/videoPlanning.mp4',
            key: key, onVideoCompleted: vm.videoPlanningCompleted);
      case OnboardingStep.planCreation:
        return PlanCreationScreen(key: key);
      case OnboardingStep.planDisplay:
        return PlanDisplayScreen(key: key);
      case OnboardingStep.planInternalisationEmoji:
        return ChangeNotifierProvider.value(
          value: vm.internalisationViewmodelEmoji,
          key: key,
          child: EmojiInternalisationScreen(
              onCompleted: vm.onInternalisationCompleted,
              emojiInputIf: true,
              emojiInputThen: true,
              key: key),
        );
      case OnboardingStep.assessment_vocabRoutine:
        return KeepAlivePage(
            child: ChangeNotifierProvider(
                create: (_) => vm.questionnaireVocabRoutine,
                child: HorizontalQuestionnaire()));

      case OnboardingStep.instructions_distributedLearning:
        return InstructionsDistributedLearning(key: key);
      case OnboardingStep.assessment_motivation:
        return ChangeNotifierProvider(
            create: (_) => vm.questionnaireMotivation,
            child: HorizontalQuestionnaire());
      case OnboardingStep.assessment_ToB:
        return ChangeNotifierProvider(
            create: (_) => vm.questionnaireToB,
            child: HorizontalQuestionnaire());
        break;
      case OnboardingStep.whyLearnVocabScreen:
        // TODO: Handle this case.
        break;
      case OnboardingStep.planTiming:
        return PlanTimingScreen(key: key);
      case OnboardingStep.instructions_cabuu_1:
        // TODO: Handle this case.
        break;
      case OnboardingStep.instructions_cabuu_2:
        // TODO: Handle this case.
        break;
      case OnboardingStep.instructions_cabuu_3:
        // TODO: Handle this case.
        break;

      case OnboardingStep.endOfSession:
        // TODO: Handle this case.
        break;
    }
    return Container(
      key: key,
      child: Text('Not implemented: $step'),
    );
  }
}
