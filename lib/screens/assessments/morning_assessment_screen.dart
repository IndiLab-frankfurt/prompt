import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:prompt/screens/assessments/multi_step_assessment.dart';
import 'package:prompt/screens/assessments/multi_step_questionnaire_future.dart';
import 'package:prompt/screens/internalisation/emoji_internalisation_screen.dart';
import 'package:prompt/screens/internalisation/scramble_internalisation.dart';
import 'package:prompt/screens/internalisation/waiting_internalisation_screen.dart';
import 'package:prompt/screens/prompts/booster_strategy_prompt_screen.dart';
import 'package:prompt/shared/enums.dart';
import 'package:prompt/shared/ui_helper.dart';
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
    MorningAssessmentStep.didLearn: didLearnQuestionnaire,
    MorningAssessmentStep.rememberToUsePromptAfterCabuu:
        rememberToUsePromptAfterCabuu,
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
                margin: UIHelper.containerMargin,
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
        internalisation = WaitingInternalisationScreen(
          Duration(seconds: 15),
          onCompleted: vm.onInternalisationCompleted,
        );
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
        child: FutureBuilder(
          future: vm.getPlan(),
          builder: (_, snapshot) {
            if (snapshot.hasData) {
              return internalisation;
            }
            return Container(child: CircularProgressIndicator());
          },
        ));
  }

  late var rememberToUsePromptAfterCabuu = Column(
    key: ValueKey(MorningAssessmentStep.rememberToUsePromptAfterCabuu),
    children: [
      MarkdownBody(
          data:
              '### Bitte denk nächstes Mal daran, PROMPT _direkt nach dem Lernen_ mit cabuu zu benutzen.'),
      MarkdownBody(
          data:
              '### Beantworte die folgenden Fragen bezogen auf dein _gestriges_ Lernen mit cabuu')
    ],
  );

  late var alternativeItems = MultiStepQuestionnaireFuture(
    vm: vm,
    assessmentTypes: AssessmentTypes.evening_alternative,
    key: ValueKey(MorningAssessmentStep.alternativeItems),
  );

  late var completed = MarkdownBody(
      data: "# " + vm.finalMessage,
      key: ValueKey(MorningAssessmentStep.eveningItems));

  late var eveningItems = MarkdownBody(
      data: "# Abend-Items", key: ValueKey(MorningAssessmentStep.eveningItems));

  late var morningItems = MarkdownBody(
      data: "# Morgen-Items",
      key: ValueKey(MorningAssessmentStep.morningItems));

  late var boosterPrompt = BoosterStrategyPromptScreen(
      key: ValueKey(MorningAssessmentStep.boosterPrompt));

  late var didLearnQuestionnaire = MultiStepQuestionnaireFuture(
      vm: vm,
      assessmentTypes: AssessmentTypes.didLearnWhen,
      key: ValueKey(MorningAssessmentStep.didLearn));
}
