import 'package:flutter/material.dart';
import 'package:prompt/screens/assessments/multi_step_assessment.dart';
import 'package:prompt/screens/assessments/multi_step_questionnaire_future.dart';
import 'package:prompt/screens/internalisation/emoji_internalisation_screen.dart';
import 'package:prompt/screens/internalisation/waiting_internalisation_screen.dart';
import 'package:prompt/screens/session_zero/cabuu_code_screen.dart';
import 'package:prompt/screens/session_zero/copingplan_enter_screen.dart';
import 'package:prompt/screens/session_zero/end_of_session_screen.dart';
import 'package:prompt/screens/session_zero/instruction_screen_1.dart';
import 'package:prompt/screens/session_zero/instruction_screen_2.dart';
import 'package:prompt/screens/session_zero/instruction_screen_3.dart';
import 'package:prompt/screens/session_zero/instruction_screen_4.dart';
import 'package:prompt/screens/session_zero/instructions_cabuu_1.dart';
import 'package:prompt/screens/session_zero/instructions_cabuu_2.dart';
import 'package:prompt/screens/session_zero/instructions_cabuu_3.dart';
import 'package:prompt/screens/session_zero/instructions_distributed_learning.dart';
import 'package:prompt/screens/session_zero/instructions_implementation_intentions.dart';
import 'package:prompt/screens/session_zero/obstacle_enter_screen.dart';
import 'package:prompt/screens/session_zero/outcome_enter_screen.dart';
import 'package:prompt/screens/session_zero/plan_commitment_screen.dart';
import 'package:prompt/screens/session_zero/plan_creation_screen.dart';
import 'package:prompt/screens/session_zero/plan_display_screen.dart';
import 'package:prompt/screens/session_zero/plan_timing_screen.dart';
import 'package:prompt/screens/session_zero/reward_screen_1.dart';
import 'package:prompt/screens/session_zero/rewards_screen_2.dart';
import 'package:prompt/screens/session_zero/welcome_screen.dart';
import 'package:prompt/screens/session_zero/why_learn_vocab_screen.dart';
import 'package:prompt/shared/enums.dart';
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
  List<Widget> _screens = [];

  final AsyncMemoizer _memoizer = AsyncMemoizer();

  late SessionZeroViewModel vm = Provider.of<SessionZeroViewModel>(context);

  init() async {
    return this._memoizer.runOnce(() async {
      await vm.getInitialValues();

      _screens = [];

      for (var screen in vm.screenOrder) {
        _screens.add(getScreen(screen));
      }

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
              appBar: PromptAppBar(showBackButton: false),
              drawer: PromptDrawer(),
              resizeToAvoidBottomInset: false,
              // extendBodyBehindAppBar: true,
              body: SafeArea(
                child: FutureBuilder(
                  future: init(),
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.hasData) {
                      return Container(
                          decoration: UIHelper.defaultBoxDecoration,
                          padding: UIHelper.containerPadding,
                          child: MultiStepAssessment(
                            vm,
                            _screens,
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

  Widget getScreen(SessionZeroStep step) {
    var key = ValueKey(step);
    switch (step) {
      case SessionZeroStep.welcome:
        return WelcomeScreen(key: key);
      case SessionZeroStep.rewardScreen1:
        return RewardScreen1(key: key);
      case SessionZeroStep.video_introduction:
        return VideoScreen(
          'assets/videos/intro_prompt_compressed.mp4',
          onVideoCompleted: vm.videoWelcomeCompleted,
          key: key,
        );
      case SessionZeroStep.cabuuCode:
        return CabuuCodeScreen(key: key);
      case SessionZeroStep.video_distributedLearning:
        return VideoScreen('assets/videos/videoDistributedLearning.mp4',
            key: key, onVideoCompleted: vm.videoDistributedLearningCompleted);
      case SessionZeroStep.outcome:
        return OutcomeEnterScreen(key: key);
      case SessionZeroStep.obstacle:
        return ObstacleEnterScreen(key: key);
      case SessionZeroStep.copingPlan:
        return CopingPlanEnterScreen(key: key);
      case SessionZeroStep.instructions_implementationIntentions:
        return InstructionsImplementationIntentions(key: key);
      case SessionZeroStep.video_Planning:
        return VideoScreen('assets/videos/videoPlanning.mp4',
            key: key, onVideoCompleted: vm.videoPlanningCompleted);
      case SessionZeroStep.planCreation:
        return PlanCreationScreen(key: key);

      case SessionZeroStep.planDisplay:
        return PlanDisplayScreen(key: key);
      case SessionZeroStep.planInternalisationEmoji:
        return ChangeNotifierProvider.value(
          value: vm.internalisationViewmodelEmoji,
          key: ValueKey(SessionZeroStep.planInternalisationEmoji),
          child: EmojiInternalisationScreen(
              onCompleted: vm.onInternalisationCompleted,
              emojiInputIf: true,
              emojiInputThen: true,
              key: ValueKey(SessionZeroStep.planInternalisationEmoji)),
        );
      case SessionZeroStep.assessment_itLiteracy:
        // TODO: Handle this case.
        break;
      case SessionZeroStep.assessment_learningFrequencyDuration:
        // TODO: Handle this case.
        break;
      case SessionZeroStep.assessment_motivation:
        // TODO: Handle this case.
        break;
      case SessionZeroStep.assessment_learningExpectations:
        // TODO: Handle this case.
        break;
      case SessionZeroStep.assessment_distributedLearning:
        // TODO: Handle this case.
        break;
      case SessionZeroStep.assessment_selfEfficacy:
        // TODO: Handle this case.
        break;

      case SessionZeroStep.whyLearnVocabScreen:
        // TODO: Handle this case.
        break;

      case SessionZeroStep.planInternalisationWaiting:
        // TODO: Handle this case.
        break;

      case SessionZeroStep.planTiming:
        // TODO: Handle this case.
        break;
      case SessionZeroStep.instructions1:
        // TODO: Handle this case.
        break;
      case SessionZeroStep.instructions2:
        // TODO: Handle this case.
        break;
      case SessionZeroStep.instructions3:
        // TODO: Handle this case.
        break;
      case SessionZeroStep.instructions4:
        // TODO: Handle this case.
        break;
      case SessionZeroStep.instructions_cabuu_1:
        // TODO: Handle this case.
        break;
      case SessionZeroStep.instructions_cabuu_2:
        // TODO: Handle this case.
        break;
      case SessionZeroStep.instructions_cabuu_3:
        // TODO: Handle this case.
        break;
      case SessionZeroStep.instructions_distributedLearning:
        // TODO: Handle this case.
        break;

      case SessionZeroStep.rewardScreen2:
        // TODO: Handle this case.
        break;
      case SessionZeroStep.endOfSession:
        // TODO: Handle this case.
        break;
    }
    return Container(
      key: key,
      child: Text('Not implemented: $step'),
    );
  }

  late var rewardScreen2 =
      RewardScreen2(key: ValueKey(SessionZeroStep.rewardScreen2));

  late var endOfSessionScreen =
      EndOfSessionScreen(key: ValueKey(SessionZeroStep.endOfSession));

  late var instructionsCabuu1 =
      InstructionsCabuu1(key: ValueKey(SessionZeroStep.instructions_cabuu_1));

  late var instructionsCabuu2 =
      InstructionsCabuu2(key: ValueKey(SessionZeroStep.instructions_cabuu_2));

  late var instructionsCabuu3 =
      InstructionsCabuu3(key: ValueKey(SessionZeroStep.instructions_cabuu_3));

  late var instructionsDistributedLearning = InstructionsDistributedLearning(
      key: ValueKey(SessionZeroStep.instructions_distributedLearning));

  late var instructionScreen1 =
      InstructionScreen1(key: ValueKey(SessionZeroStep.instructions1));

  late var instructionScreen2 =
      InstructionScreen2(key: ValueKey(SessionZeroStep.instructions2));

  late var instructionScreen3 =
      InstructionScreen3(key: ValueKey(SessionZeroStep.instructions3));

  late var instructionScreen4 =
      InstructionScreen4(key: ValueKey(SessionZeroStep.instructions4));

  late var instructionsImplementationIntentions =
      InstructionsImplementationIntentions(
          key: ValueKey(SessionZeroStep.instructions_implementationIntentions));

  late var motivationQuestionnaire = MultiStepQuestionnaireFuture(
      vm: vm,
      questionnaireName: AssessmentTypes.motivation,
      key: ValueKey(SessionZeroStep.assessment_motivation));

  late var selfEfficacyQuestionnaire = MultiStepQuestionnaireFuture(
      vm: vm,
      questionnaireName: AssessmentTypes.selfEfficacy,
      key: ValueKey(SessionZeroStep.assessment_selfEfficacy));

  late var itLiteracyQuestionnaire = MultiStepQuestionnaireFuture(
      vm: vm,
      questionnaireName: AssessmentTypes.itLiteracy,
      key: ValueKey(SessionZeroStep.assessment_itLiteracy));

  late var learningFrequencyDuration = MultiStepQuestionnaireFuture(
      vm: vm,
      questionnaireName: AssessmentTypes.learningFrequencyDuration,
      key: ValueKey(SessionZeroStep.assessment_learningFrequencyDuration));

  late var learningExpectations = MultiStepQuestionnaireFuture(
      vm: vm,
      questionnaireName: AssessmentTypes.learningExpectations,
      key: ValueKey(SessionZeroStep.assessment_learningExpectations));

  late var planCreation =
      PlanCreationScreen(key: ValueKey(SessionZeroStep.planCreation));

  late var planDisplay =
      PlanDisplayScreen(key: ValueKey(SessionZeroStep.planDisplay));

  late var whyLearnVocabs =
      WhyLearnVocabScreen(key: ValueKey(SessionZeroStep.whyLearnVocabScreen));

  late var planTiming =
      PlanTimingScreen(key: ValueKey(SessionZeroStep.planTiming));

  // late var planCommitment = PlanCommitmentScreen(
  //     key: ValueKey(SessionZeroStep.assessment_planCommitment));

  late var distributedLearning = MultiStepQuestionnaireFuture(
      vm: vm,
      questionnaireName: AssessmentTypes.distributedPractice,
      key: ValueKey(SessionZeroStep.assessment_distributedLearning));

  late var planInternalisationWaiting = ChangeNotifierProvider.value(
    value: vm.internalisationViewmodelWaiting,
    key: ValueKey(SessionZeroStep.planInternalisationWaiting),
    child: WaitingInternalisationScreen(Duration(seconds: 15),
        onCompleted: vm.onWaitingInternalisationCompleted,
        key: ValueKey(SessionZeroStep.planInternalisationWaiting)),
  );
}
