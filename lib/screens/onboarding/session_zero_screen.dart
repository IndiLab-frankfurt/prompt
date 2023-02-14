import 'package:flutter/material.dart';
import 'package:prompt/screens/assessments/multi_page_screen.dart';
import 'package:prompt/screens/internalisation/emoji_internalisation_screen.dart';
import 'package:prompt/screens/onboarding/cabuu_code_screen.dart';
import 'package:prompt/screens/onboarding/copingplan_enter_screen.dart';
import 'package:prompt/screens/onboarding/instruction_screen_1.dart';
import 'package:prompt/screens/onboarding/instruction_screen_2.dart';
import 'package:prompt/screens/onboarding/instruction_screen_3.dart';
import 'package:prompt/screens/onboarding/instruction_screen_4.dart';
import 'package:prompt/screens/onboarding/instructions_cabuu_1.dart';
import 'package:prompt/screens/onboarding/instructions_cabuu_2.dart';
import 'package:prompt/screens/onboarding/instructions_cabuu_3.dart';
import 'package:prompt/screens/onboarding/instructions_distributed_learning.dart';
import 'package:prompt/screens/onboarding/instructions_implementation_intentions.dart';
import 'package:prompt/screens/onboarding/obstacle_enter_screen.dart';
import 'package:prompt/screens/onboarding/outcome_enter_screen.dart';
import 'package:prompt/screens/onboarding/plan_creation_screen.dart';
import 'package:prompt/screens/onboarding/plan_display_screen.dart';
import 'package:prompt/screens/onboarding/plan_timing_screen.dart';
import 'package:prompt/screens/onboarding/reward_screen_1.dart';
import 'package:prompt/screens/onboarding/rewards_screen_2.dart';
import 'package:prompt/screens/onboarding/welcome_screen.dart';
import 'package:prompt/screens/onboarding/why_learn_vocab_screen.dart';
import 'package:prompt/shared/ui_helper.dart';
import 'package:prompt/viewmodels/onboarding_view_model.dart';
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
              appBar: PromptAppBar(showBackButton: true),
              drawer: PromptDrawer(),
              extendBodyBehindAppBar: true,
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
      case OnboardingStep.rewardScreen2:
        return RewardScreen2(key: key);
      case OnboardingStep.assessment_itLiteracy:
        // TODO: Handle this case.
        break;
      case OnboardingStep.assessment_learningFrequencyDuration:
        // TODO: Handle this case.
        break;
      case OnboardingStep.assessment_motivation:
        // TODO: Handle this case.
        break;
      case OnboardingStep.assessment_learningExpectations:
        // TODO: Handle this case.
        break;
      case OnboardingStep.assessment_distributedLearning:
        // TODO: Handle this case.
        break;
      case OnboardingStep.assessment_selfEfficacy:
        // TODO: Handle this case.
        break;

      case OnboardingStep.whyLearnVocabScreen:
        // TODO: Handle this case.
        break;

      case OnboardingStep.planInternalisationWaiting:
        // TODO: Handle this case.
        break;

      case OnboardingStep.planTiming:
        return PlanTimingScreen(key: key);
      case OnboardingStep.instructions1:
        // TODO: Handle this case.
        break;
      case OnboardingStep.instructions2:
        // TODO: Handle this case.
        break;
      case OnboardingStep.instructions3:
        // TODO: Handle this case.
        break;
      case OnboardingStep.instructions4:
        // TODO: Handle this case.
        break;
      case OnboardingStep.instructions_cabuu_1:
        // TODO: Handle this case.
        break;
      case OnboardingStep.instructions_cabuu_2:
        // TODO: Handle this case.
        break;
      case OnboardingStep.instructions_cabuu_3:
        // TODO: Handle this case.
        break;
      case OnboardingStep.instructions_distributedLearning:
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

  late var rewardScreen2 =
      RewardScreen2(key: ValueKey(OnboardingStep.rewardScreen2));

  late var instructionsCabuu1 =
      InstructionsCabuu1(key: ValueKey(OnboardingStep.instructions_cabuu_1));

  late var instructionsCabuu2 =
      InstructionsCabuu2(key: ValueKey(OnboardingStep.instructions_cabuu_2));

  late var instructionsCabuu3 =
      InstructionsCabuu3(key: ValueKey(OnboardingStep.instructions_cabuu_3));

  late var instructionsDistributedLearning = InstructionsDistributedLearning(
      key: ValueKey(OnboardingStep.instructions_distributedLearning));

  late var instructionScreen1 =
      InstructionScreen1(key: ValueKey(OnboardingStep.instructions1));

  late var instructionScreen2 =
      InstructionScreen2(key: ValueKey(OnboardingStep.instructions2));

  late var instructionScreen3 =
      InstructionScreen3(key: ValueKey(OnboardingStep.instructions3));

  late var instructionScreen4 =
      InstructionScreen4(key: ValueKey(OnboardingStep.instructions4));

  late var instructionsImplementationIntentions =
      InstructionsImplementationIntentions(
          key: ValueKey(OnboardingStep.instructions_implementationIntentions));

  late var planCreation =
      PlanCreationScreen(key: ValueKey(OnboardingStep.planCreation));

  late var planDisplay =
      PlanDisplayScreen(key: ValueKey(OnboardingStep.planDisplay));

  late var whyLearnVocabs =
      WhyLearnVocabScreen(key: ValueKey(OnboardingStep.whyLearnVocabScreen));
}
