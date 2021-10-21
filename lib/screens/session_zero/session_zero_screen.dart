import 'package:flutter/material.dart';
import 'package:prompt/screens/assessments/multi_step_assessment.dart';
import 'package:prompt/screens/assessments/multi_step_questionnaire_future.dart';
import 'package:prompt/screens/internalisation/emoji_internalisation_screen.dart';
import 'package:prompt/screens/internalisation/waiting_internalisation_screen.dart';
import 'package:prompt/screens/placeholder_screen.dart';
import 'package:prompt/screens/session_zero/cabuu_code_screen.dart';
import 'package:prompt/screens/session_zero/end_of_session_screen.dart';
import 'package:prompt/screens/session_zero/instruction_screen_1.dart';
import 'package:prompt/screens/session_zero/instruction_screen_2.dart';
import 'package:prompt/screens/session_zero/instruction_screen_3.dart';
import 'package:prompt/screens/session_zero/instruction_screen_4.dart';
import 'package:prompt/screens/session_zero/instructions_appPermissions.dart';
import 'package:prompt/screens/session_zero/instructions_cabuu_1.dart';
import 'package:prompt/screens/session_zero/instructions_cabuu_2.dart';
import 'package:prompt/screens/session_zero/instructions_cabuu_3.dart';
import 'package:prompt/screens/session_zero/instructions_distributed_learning.dart';
import 'package:prompt/screens/session_zero/instructions_implementation_intentions.dart';
import 'package:prompt/screens/session_zero/mascot_selection_screen.dart';
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
  List<Widget> _pages = [];

  final AsyncMemoizer _memoizer = AsyncMemoizer();

  late SessionZeroViewModel vm = Provider.of<SessionZeroViewModel>(context);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Map<SessionZeroStep, Widget> _stepScreenMap = {
      SessionZeroStep.welcome: welcomeScreen,
      SessionZeroStep.whereCanYouFindThisInformation:
          whereCanYouFindThisInformation,
      SessionZeroStep.cabuuCode: cabuuCodeScreen,
      SessionZeroStep.mascotSelection: mascotSelectionScreen,
      SessionZeroStep.assessment_motivation: motivationQuestionnaire,
      SessionZeroStep.assessment_itLiteracy: itLiteracyQuestionnaire,
      SessionZeroStep.assessment_learningFrequencyDuration:
          learningFrequencyDuration,
      SessionZeroStep.assessment_learningExpectations: learningExpectations,
      SessionZeroStep.assessment_distributedLearning: distributedLearning,
      SessionZeroStep.videoDistributedLearning: videoDistributedLearning,
      SessionZeroStep.videoPlanning: videoPlanning,
      SessionZeroStep.planCreation: planCreation,
      SessionZeroStep.planDisplay: planDisplay,
      SessionZeroStep.planInternalisationEmoji: planInternalisationEmoji,
      SessionZeroStep.planInternalisationWaiting: planInternalisationWaiting,
      SessionZeroStep.planTiming: planTiming,
      SessionZeroStep.assessment_selfEfficacy: selfEfficacyQuestionnaire,
      SessionZeroStep.assessment_planCommitment: planCommitment,
      SessionZeroStep.valueIntervention: whyLearnVocabs,
      SessionZeroStep.instructions1: instructionScreen1,
      SessionZeroStep.instructions2: instructionScreen2,
      SessionZeroStep.instructions3: instructionScreen3,
      SessionZeroStep.instructions4: instructionScreen4,
      SessionZeroStep.instructions_cabuu_1: instructionsCabuu1,
      SessionZeroStep.instructions_cabuu_2: instructionsCabuu2,
      SessionZeroStep.instructions_cabuu_3: instructionsCabuu3,
      SessionZeroStep.instructions_distributedLearning:
          instructionsDistributedLearning,
      SessionZeroStep.instructions_implementationIntentions:
          instructionsImplementationIntentions,
      SessionZeroStep.instructions_appPermissions: instructionsAppPermissions,
      SessionZeroStep.endOfSession: endOfSessionScreen,
      SessionZeroStep.rewardScreen1: rewardScreen1,
      SessionZeroStep.rewardScreen2: rewardScreen2
    };

    _pages = [];

    for (var page in vm.screenOrder) {
      if (_stepScreenMap.containsKey(page)) {
        _pages.add(_stepScreenMap[page]!);
      }
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
            body: FutureBuilder(
              future: init(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
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
            )));
  }

  late var welcomeScreen =
      WelcomeScreen(key: ValueKey(SessionZeroStep.welcome));

  late var rewardScreen1 =
      RewardScreen1(key: ValueKey(SessionZeroStep.rewardScreen1));

  late var rewardScreen2 =
      RewardScreen2(key: ValueKey(SessionZeroStep.rewardScreen2));

  late var endOfSessionScreen =
      EndOfSessionScreen(key: ValueKey(SessionZeroStep.endOfSession));

  late var cabuuCodeScreen =
      CabuuCodeScreen(key: ValueKey(SessionZeroStep.cabuuCode));

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

  late var instructionsAppPermissions = InstructionsAppPermissions(
      key: ValueKey(SessionZeroStep.instructions_appPermissions));

  late var instructionsImplementationIntentions =
      InstructionsImplementationIntentions(
          key: ValueKey(SessionZeroStep.instructions_implementationIntentions));

  late var mascotSelectionScreen =
      MascotSelectionScreen(key: ValueKey(SessionZeroStep.mascotSelection));

  late var videoPlanning = VideoScreen('assets/videos/videoPlanning.mp4',
      key: ValueKey(SessionZeroStep.videoPlanning),
      onVideoCompleted: vm.videoPlanningCompleted);

  late var motivationQuestionnaire = MultiStepQuestionnaireFuture(
      vm: vm,
      assessmentTypes: AssessmentTypes.motivation,
      key: ValueKey(SessionZeroStep.assessment_motivation));

  late var selfEfficacyQuestionnaire = MultiStepQuestionnaireFuture(
      vm: vm,
      assessmentTypes: AssessmentTypes.selfEfficacy,
      key: ValueKey(SessionZeroStep.assessment_selfEfficacy));

  late var itLiteracyQuestionnaire = MultiStepQuestionnaireFuture(
      vm: vm,
      assessmentTypes: AssessmentTypes.itLiteracy,
      key: ValueKey(SessionZeroStep.assessment_itLiteracy));

  late var learningFrequencyDuration = MultiStepQuestionnaireFuture(
      vm: vm,
      assessmentTypes: AssessmentTypes.learningFrequencyDuration,
      key: ValueKey(SessionZeroStep.assessment_learningFrequencyDuration));

  late var learningExpectations = MultiStepQuestionnaireFuture(
      vm: vm,
      assessmentTypes: AssessmentTypes.learningExpectations,
      key: ValueKey(SessionZeroStep.assessment_learningExpectations));

  late var planCreation =
      PlanCreationScreen(key: ValueKey(SessionZeroStep.planCreation));

  late var planDisplay =
      PlanDisplayScreen(key: ValueKey(SessionZeroStep.planDisplay));

  late var whyLearnVocabs =
      WhyLearnVocabScreen(key: ValueKey(SessionZeroStep.valueIntervention));

  late var planTiming =
      PlanTimingScreen(key: ValueKey(SessionZeroStep.planTiming));

  late var planCommitment = PlanCommitmentScreen(
      key: ValueKey(SessionZeroStep.assessment_planCommitment));

  late var distributedLearning = MultiStepQuestionnaireFuture(
      vm: vm,
      assessmentTypes: AssessmentTypes.distributedPractice,
      key: ValueKey(SessionZeroStep.assessment_distributedLearning));

  late var whereCanYouFindThisInformation = VideoScreen(
    'assets/videos/intro_prompt_compressed.mp4',
    onVideoCompleted: vm.videoWelcomeCompleted,
    key: ValueKey(SessionZeroStep.whereCanYouFindThisInformation),
  );

  late var planInternalisationEmoji = ChangeNotifierProvider.value(
    value: vm.internalisationViewmodelEmoji,
    key: ValueKey(SessionZeroStep.planInternalisationEmoji),
    child: EmojiInternalisationScreen(
        onCompleted: vm.onInternalisationCompleted,
        emojiInputIf: true,
        emojiInputThen: true,
        key: ValueKey(SessionZeroStep.planInternalisationEmoji)),
  );

  late var planInternalisationWaiting = ChangeNotifierProvider.value(
    value: vm.internalisationViewmodelWaiting,
    key: ValueKey(SessionZeroStep.planInternalisationWaiting),
    child: WaitingInternalisationScreen(Duration(seconds: 15),
        onCompleted: vm.onInternalisationCompleted,
        key: ValueKey(SessionZeroStep.planInternalisationWaiting)),
  );

  late var videoDistributedLearning = VideoScreen(
      'assets/videos/videoDistributedLearning.mp4',
      key: ValueKey(SessionZeroStep.videoDistributedLearning),
      onVideoCompleted: vm.videoDistributedLearningCompleted);
}
