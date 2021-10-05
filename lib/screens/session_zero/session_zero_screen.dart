import 'package:flutter/material.dart';
import 'package:prompt/screens/assessments/multi_step_assessment.dart';
import 'package:prompt/screens/assessments/multi_step_questionnaire_future.dart';
import 'package:prompt/screens/internalisation/emoji_internalisation_screen.dart';
import 'package:prompt/screens/placeholder_screen.dart';
import 'package:prompt/screens/session_zero/cabuu_code_screen.dart';
import 'package:prompt/screens/session_zero/goal_intention_screen.dart';
import 'package:prompt/screens/session_zero/instruction_screen_1.dart';
import 'package:prompt/screens/session_zero/instruction_screen_2.dart';
import 'package:prompt/screens/session_zero/instruction_screen_3.dart';
import 'package:prompt/screens/session_zero/instruction_screen_4.dart';
import 'package:prompt/screens/session_zero/instructions_cabuu_1.dart';
import 'package:prompt/screens/session_zero/instructions_distributed_learning.dart';
import 'package:prompt/screens/session_zero/instructions_implementation_intentions.dart';
import 'package:prompt/screens/session_zero/mascot_selection_screen.dart';
import 'package:prompt/screens/session_zero/plan_commitment_screen.dart';
import 'package:prompt/screens/session_zero/plan_creation_screen.dart';
import 'package:prompt/screens/session_zero/plan_display_screen.dart';
import 'package:prompt/screens/session_zero/plan_timing_screen.dart';
import 'package:prompt/screens/session_zero/welcome_screen.dart';
import 'package:prompt/screens/session_zero/why_learn_vocab_screen.dart';
import 'package:prompt/shared/enums.dart';
import 'package:prompt/shared/ui_helper.dart';
import 'package:prompt/viewmodels/session_zero_view_model.dart';
import 'package:prompt/widgets/video_screen.dart';
import 'package:provider/provider.dart';

class SessionZeroScreen extends StatefulWidget {
  SessionZeroScreen({Key? key}) : super(key: key);

  @override
  _SessionZeroScreenState createState() => _SessionZeroScreenState();
}

class _SessionZeroScreenState extends State<SessionZeroScreen> {
  List<Widget> _pages = [];

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
      SessionZeroStep.moderatorVariables: moderatorVariables,
      SessionZeroStep.assessment_motivation: motivationQuestionnaire,
      SessionZeroStep.assessment_itLiteracy: itLiteracyQuestionnaire,
      SessionZeroStep.assessment_learningFrequencyDuration:
          learningFrequencyDuration,
      SessionZeroStep.assessment_distributedLearning: distributedLearning,
      SessionZeroStep.videoDistributedLearning: videoDistributedLearning,
      SessionZeroStep.goalIntention: goalIntentionScreen,
      SessionZeroStep.videoPlanning: videoPlanning,
      SessionZeroStep.planCreation: planCreation,
      SessionZeroStep.planDisplay: planDisplay,
      SessionZeroStep.planInternalisation: planInternalisation,
      SessionZeroStep.planTiming: planTiming,
      SessionZeroStep.selfEfficacy: selfEfficacyQuestionnaire,
      SessionZeroStep.videoInstructionComplete: instructionComplete,
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
          instructionsImplementationIntentions
    };

    _pages = [];

    for (var page in vm.screenOrder) {
      if (_stepScreenMap.containsKey(page)) {
        _pages.add(_stepScreenMap[page]!);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
            body: Container(
                margin: UIHelper.containerMargin,
                child: MultiStepAssessment(
                  vm,
                  _pages,
                ))));
  }

  var welcomeScreen = WelcomeScreen(key: ValueKey(SessionZeroStep.welcome));

  late var cabuuCodeScreen =
      CabuuCodeScreen(key: ValueKey(SessionZeroStep.cabuuCode));

  late var instructionsCabuu1 =
      InstructionsCabuu1(key: ValueKey(SessionZeroStep.instructions_cabuu_1));

  late var instructionsCabuu2 =
      InstructionsCabuu1(key: ValueKey(SessionZeroStep.instructions_cabuu_2));

  late var instructionsCabuu3 =
      InstructionsCabuu1(key: ValueKey(SessionZeroStep.instructions_cabuu_3));

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

  late var mascotSelectionScreen =
      MascotSelectionScreen(key: ValueKey(SessionZeroStep.mascotSelection));

  late var goalIntentionScreen =
      GoalIntentionScreen(key: ValueKey(SessionZeroStep.goalIntention));

  late var videoPlanning = VideoScreen('assets/videos/videoLearning.mp4',
      key: ValueKey(SessionZeroStep.videoPlanning),
      onVideoCompleted: vm.videoPlanningCompleted);

  late var instructionComplete = PlaceholderScreen(
    text: "Hier Instruktionsvideo Abschluss Session 0 ",
    key: ValueKey(SessionZeroStep.videoInstructionComplete),
  );

  late var moderatorVariables = PlaceholderScreen(
    text: "Moderatorvariablen oder so",
    key: ValueKey(SessionZeroStep.videoInstructionComplete),
  );

  late var motivationQuestionnaire = MultiStepQuestionnaireFuture(
      vm: vm,
      assessmentTypes: AssessmentTypes.motivation,
      key: ValueKey(SessionZeroStep.assessment_motivation));

  late var selfEfficacyQuestionnaire = MultiStepQuestionnaireFuture(
      vm: vm,
      assessmentTypes: AssessmentTypes.selfEfficacy,
      key: ValueKey(SessionZeroStep.selfEfficacy));

  late var itLiteracyQuestionnaire = MultiStepQuestionnaireFuture(
      vm: vm,
      assessmentTypes: AssessmentTypes.itLiteracy,
      key: ValueKey(SessionZeroStep.assessment_itLiteracy));

  late var learningFrequencyDuration = MultiStepQuestionnaireFuture(
      vm: vm,
      assessmentTypes: AssessmentTypes.learningFrequencyDuration,
      key: ValueKey(SessionZeroStep.assessment_learningFrequencyDuration));

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

  late var whereCanYouFindThisInformation = PlaceholderScreen(
    text: "Einführungsvideo",
    key: ValueKey(SessionZeroStep.videoInstructionComplete),
  );

  late var planInternalisation = ChangeNotifierProvider.value(
    value: vm.internalisationViewmodel,
    key: ValueKey(SessionZeroStep.planInternalisation),
    child: EmojiInternalisationScreen(
        key: ValueKey(SessionZeroStep.planInternalisation)),
  );

  late var videoDistributedLearning = VideoScreen(
      'assets/videos/videoLearning.mp4',
      key: ValueKey(SessionZeroStep.videoDistributedLearning),
      onVideoCompleted: vm.videoDistributedLearningCompleted);
}
