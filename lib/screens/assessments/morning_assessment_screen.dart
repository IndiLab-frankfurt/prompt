import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:prompt/screens/assessments/multi_step_assessment.dart';
import 'package:prompt/screens/assessments/multi_step_questionnaire_future.dart';
import 'package:prompt/screens/internalisation/emoji_internalisation_screen.dart';
import 'package:prompt/screens/internalisation/scramble_internalisation.dart';
import 'package:prompt/screens/internalisation/waiting_internalisation_screen.dart';
import 'package:prompt/screens/prompts/booster_strategy_prompt_screen.dart';
import 'package:prompt/shared/enums.dart';
import 'package:prompt/viewmodels/morning_assessment_view_model.dart';
import 'package:provider/provider.dart';

class MorningAssessmentScreen extends StatefulWidget {
  MorningAssessmentScreen({Key? key}) : super(key: key);

  @override
  MorningAssessmentScreenState createState() => MorningAssessmentScreenState();
}

class MorningAssessmentScreenState extends State<MorningAssessmentScreen> {
  List<Widget> _pages = [];

  late MorningAssessmentViewModel vm =
      Provider.of<MorningAssessmentViewModel>(context);

  late Map<MorningAssessmentStep, Widget> _stepScreenMap = {
    MorningAssessmentStep.didLearnCabuuYesterday: didLearnQuestionnaire,
    MorningAssessmentStep.alternativeItems: alternativeItems,
    MorningAssessmentStep.eveningItems: eveningItems,
    MorningAssessmentStep.morningItems: morningItems,
    MorningAssessmentStep.boosterPrompt: boosterPrompt,
    MorningAssessmentStep.internalisation: internalisation(),
    MorningAssessmentStep.completed: completed,
  };

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

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

  dynamic internalisation() {
    var condition = vm.getInternalisationCondition();

    Widget internalisation = Text("");
    switch (condition) {
      case InternalisationCondition.waiting:
        internalisation = WaitingInternalisationScreen(Duration(seconds: 30));
        break;
      case InternalisationCondition.scrambleWithHint:
        internalisation = ScrambleInternalisation(
          onCompleted: vm.onInternalisationCompleted,
        );
        break;
      case InternalisationCondition.emoji:
        internalisation = EmojiInternalisationScreen(
            onCompleted: vm.onInternalisationCompleted);
        break;
    }

    return ChangeNotifierProvider.value(
        value: vm.internalisationViewmodel,
        key: ValueKey(MorningAssessmentStep.internalisation),
        child: internalisation);
  }

  late var alternativeItems = MarkdownBody(
    data: "# Alternativ-Items",
    key: ValueKey(MorningAssessmentStep.alternativeItems),
  );

  late var completed = MarkdownBody(
      data: "# Vielen Dank", key: ValueKey(MorningAssessmentStep.eveningItems));

  late var eveningItems = MarkdownBody(
      data: "# Abend-Items", key: ValueKey(MorningAssessmentStep.eveningItems));

  late var morningItems = MarkdownBody(
      data: "# Morgen-Items",
      key: ValueKey(MorningAssessmentStep.morningItems));

  late var boosterPrompt = BoosterStrategyPromptScreen(
      key: ValueKey(MorningAssessmentStep.boosterPrompt));

  late var didLearnQuestionnaire = MultiStepQuestionnaireFuture(
      vm: vm,
      assessmentTypes: AssessmentTypes.didLearnYesterday,
      key: ValueKey(MorningAssessmentStep.didLearnCabuuYesterday));
}
