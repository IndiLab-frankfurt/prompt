import 'package:flutter/material.dart';
import 'package:prompt/models/assessment.dart';
import 'package:prompt/screens/assessments/multi_step_assessment.dart';
import 'package:prompt/screens/assessments/multi_step_questionnaire_future.dart';
import 'package:prompt/screens/assessments/questionnaire.dart';
import 'package:prompt/screens/internalisation/emoji_internalisation_screen.dart';
import 'package:prompt/screens/placeholder_screen.dart';
import 'package:prompt/screens/session_zero/cabuu_code_screen.dart';
import 'package:prompt/screens/session_zero/cabuu_link_screen.dart';
import 'package:prompt/screens/session_zero/goal_intention_screen.dart';
import 'package:prompt/screens/session_zero/mascot_selection_screen.dart';
import 'package:prompt/screens/session_zero/plan_commitment_screen.dart';
import 'package:prompt/screens/session_zero/plan_creation_screen.dart';
import 'package:prompt/screens/session_zero/plan_display_screen.dart';
import 'package:prompt/screens/session_zero/plan_timing_screen.dart';
import 'package:prompt/screens/session_zero/welcome_screen.dart';
import 'package:prompt/screens/session_zero/why_learn_vocab_screen.dart';
import 'package:prompt/shared/enums.dart';
import 'package:prompt/viewmodels/evening_assessment_view_model.dart';
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
      SessionZeroStep.cabuuLink: cabuuLinkScreen,
      SessionZeroStep.mascotSelection: mascotSelectionScreen,
      SessionZeroStep.moderatorVariables: moderatorVariables,
      SessionZeroStep.assessment_motivation: motivationQuestionnaire,
      SessionZeroStep.assessment_itLiteracy: itLiteracyQuestionnaire,
      SessionZeroStep.assessment_learningFrequencyDuration:
          learningFrequencyDuration,
      SessionZeroStep.assessment_distributedLearning: distributedLearning,
      SessionZeroStep.goalIntention: goalIntentionScreen,
      SessionZeroStep.videoPlanning: videoPlanning,
      SessionZeroStep.planCreation: planCreation,
      SessionZeroStep.planDisplay: planDisplay,
      SessionZeroStep.planInternalisation: planInternalisation,
      SessionZeroStep.planTiming: planTiming,
      SessionZeroStep.selfEfficacy: selfEfficacyQuestionnaire,
      SessionZeroStep.videoInstructionComplete: instructionComplete,
      SessionZeroStep.assessment_planCommitment: planCommitment,
      SessionZeroStep.whyLearnVocabs: whyLearnVocabs
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
            // appBar: SereneAppBar(),
            // drawer: SereneDrawer(),
            body: Container(
                child: MultiStepAssessment(
          vm,
          _pages,
          // initialStep: vm.getPreviouslyCompletedStep(),
        ))));
  }

  var welcomeScreen = WelcomeScreen(key: ValueKey(SessionZeroStep.welcome));

  late var cabuuCodeScreen =
      CabuuCodeScreen(key: ValueKey(SessionZeroStep.cabuuCode));

  late var cabuuLinkScreen =
      CabuuLinkScreen(key: ValueKey(SessionZeroStep.cabuuLink));

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
      WhyLearnVocabScreen(key: ValueKey(SessionZeroStep.whyLearnVocabs));

  late var planTiming =
      PlanTimingScreen(key: ValueKey(SessionZeroStep.planTiming));

  late var planCommitment = PlanCommitmentScreen(
      key: ValueKey(SessionZeroStep.assessment_planCommitment));

  late var distributedLearning = MultiStepQuestionnaireFuture(
      vm: vm,
      assessmentTypes: AssessmentTypes.distributedPractice,
      key: ValueKey(SessionZeroStep.assessment_distributedLearning));

  late var whereCanYouFindThisInformation = PlaceholderScreen(
    text:
        "[zeigen, dass man unter 'Über PROMPT' noch mal eine Zusammenfassung der Stduieninformationen (+ Link zum Video?!) sehen kann]",
    key: ValueKey(SessionZeroStep.videoInstructionComplete),
  );

  late var planInternalisation = ChangeNotifierProvider.value(
    value: vm.internalisationViewmodel,
    key: ValueKey(SessionZeroStep.planInternalisation),
    child: EmojiInternalisationScreen(
        key: ValueKey(SessionZeroStep.planInternalisation)),
  );
}
