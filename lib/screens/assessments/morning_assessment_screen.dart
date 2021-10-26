import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:prompt/screens/assessments/final_plan_display.dart';
import 'package:prompt/screens/assessments/morning_first_day_1.dart';
import 'package:prompt/screens/assessments/morning_first_day_2.dart';
import 'package:prompt/screens/assessments/morning_lastVocab_1.dart';
import 'package:prompt/screens/assessments/morning_lastVocab_2.dart';
import 'package:prompt/screens/assessments/multi_step_assessment.dart';
import 'package:prompt/screens/assessments/multi_step_questionnaire_future.dart';
import 'package:prompt/screens/assessments/pre_vocab_check.dart';
import 'package:prompt/screens/assessments/pre_vocab_screen_2.dart';
import 'package:prompt/screens/assessments/yesterday_vocab_screen.dart';
import 'package:prompt/screens/internalisation/emoji_internalisation_screen.dart';
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
    MorningAssessmentStep.firstDay_1: firstDay1,
    MorningAssessmentStep.firstDay_2: firstDay2,
    MorningAssessmentStep.lastVocab_1: lastVocab1,
    MorningAssessmentStep.lastVocab_2: lastVocab2,
    MorningAssessmentStep.didLearn: didLearnQuestionnaire,
    MorningAssessmentStep.preVocab: preVocab,
    MorningAssessmentStep.preVocabCheck: preVocabCheck,
    MorningAssessmentStep.yesterdayVocab: yesterdayVocab,
    MorningAssessmentStep.rememberToUsePromptAfterCabuu:
        rememberToUsePromptAfterCabuu,
    MorningAssessmentStep.rememberToUsePromptBeforeCabuu:
        rememberToUsePromptBeforeCabuu,
    MorningAssessmentStep.alternativeItems: alternativeItems,
    MorningAssessmentStep.boosterPrompt: boosterPrompt,
    MorningAssessmentStep.internalisation: internalisation(),
    MorningAssessmentStep.completed: completed,
    MorningAssessmentStep.assessment_afterTest: afterTest1,
    MorningAssessmentStep.assessment_afterTest_success: afterTestSuccess,
    MorningAssessmentStep.assessment_afterTest_failure: afterTestFailure,
    MorningAssessmentStep.assessment_afterTest_2: afterTest2,
    MorningAssessmentStep.assessment_evening_1: evening1,
    MorningAssessmentStep.assessment_evening_2: evening2,
    MorningAssessmentStep.assessment_evening_3: evening3,
    MorningAssessmentStep.assessment_evening_alternative: eveningAlternative,
    MorningAssessmentStep.assessment_evening_1_yesterday: evening1yesterday,
    MorningAssessmentStep.assessment_evening_2_yesterday: evening2yesterday,
    MorningAssessmentStep.assessment_evening_3_yesterday: evening3yesterday,
    MorningAssessmentStep.assessment_finalSession_1: finalSession1,
    MorningAssessmentStep.assessment_finalSession_2: finalSession2,
    MorningAssessmentStep.assessment_finalSession_3: finalSession3,
    MorningAssessmentStep.assessment_finalSession_4: finalSession4,
    MorningAssessmentStep.assessment_morningIntention: morningIntention,
    MorningAssessmentStep.planDisplay: planDisplay,
    MorningAssessmentStep.finalPromptDayIntroduction:
        finalPromptDayIntroduction,
    MorningAssessmentStep.finalPromptDayComplete: finalPromptDayComplete,
    MorningAssessmentStep.assessment_morning_with_intention:
        morningWithIntention,
    MorningAssessmentStep.assessment_morning_without_intention:
        morningWithoutIntention,
    MorningAssessmentStep.last_screen: lastScreen
  };

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _pages = [];

    for (var page in vm.screenOrder) {
      if (_stepScreenMap.containsKey(page)) {
        _pages.add(_stepScreenMap[page]!);
      } else {
        throw Exception("The requested screen is not mapped");
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
      case InternalisationCondition.emojiIf:
        internalisation = EmojiInternalisationScreen(
            emojiInputIf: true,
            emojiInputThen: false,
            onCompleted: vm.onInternalisationCompleted);
        break;
      case InternalisationCondition.emojiThen:
        internalisation = EmojiInternalisationScreen(
            emojiInputIf: false,
            emojiInputThen: true,
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

  late var rememberToUsePromptBeforeCabuu = Column(
    key: ValueKey(MorningAssessmentStep.rememberToUsePromptBeforeCabuu),
    children: [
      UIHelper.verticalSpaceLarge(),
      MarkdownBody(
          data:
              '### Bitte denk nächstes Mal daran, PROMPT zu benutzen, _bevor_ du mit cabuu lernst.'),
    ],
  );

  late var rememberToUsePromptAfterCabuu = Column(
    key: ValueKey(MorningAssessmentStep.rememberToUsePromptAfterCabuu),
    children: [
      UIHelper.verticalSpaceLarge(),
      MarkdownBody(
          data:
              '### Bitte denk nächstes Mal daran, PROMPT _direkt nach dem Lernen_ mit cabuu zu benutzen.'),
      UIHelper.verticalSpaceMedium(),
      MarkdownBody(
          data:
              '### Beantworte die folgenden Fragen bezogen auf dein _gestriges_ Lernen mit cabuu.')
    ],
  );

  late var firstDay1 =
      MorningFirstDay1(key: ValueKey(MorningAssessmentStep.firstDay_1));

  late var firstDay2 = MorningFirstDay2(
      nextVocabTestDate: vm.getNextVocabTestDate(),
      key: ValueKey(MorningAssessmentStep.firstDay_2));

  late var lastVocab1 =
      MorningLastVocab1(key: ValueKey(MorningAssessmentStep.lastVocab_1));

  late var lastVocab2 =
      MorningLastVocab2(key: ValueKey(MorningAssessmentStep.lastVocab_2));

  late var alternativeItems = MultiStepQuestionnaireFuture(
    vm: vm,
    assessmentTypes: AssessmentTypes.evening_alternative,
    key: ValueKey(MorningAssessmentStep.alternativeItems),
  );

  late var morningIntention = MultiStepQuestionnaireFuture(
      vm: vm,
      assessmentTypes: AssessmentTypes.morning_intention,
      key: ValueKey(MorningAssessmentStep.assessment_morningIntention));

  late var morningWithIntention = MultiStepQuestionnaireFuture(
      vm: vm,
      assessmentTypes: AssessmentTypes.morning_with_intention,
      key: ValueKey(MorningAssessmentStep.assessment_morning_with_intention));

  late var morningWithoutIntention = MultiStepQuestionnaireFuture(
      vm: vm,
      assessmentTypes: AssessmentTypes.morning_without_intention,
      key:
          ValueKey(MorningAssessmentStep.assessment_morning_without_intention));

  late var eveningAlternative = MultiStepQuestionnaireFuture(
      vm: vm,
      assessmentTypes: AssessmentTypes.evening_alternative,
      key: ValueKey(MorningAssessmentStep.assessment_evening_alternative));

  late var evening1 = MultiStepQuestionnaireFuture(
      vm: vm,
      assessmentTypes: AssessmentTypes.evening_1,
      key: ValueKey(MorningAssessmentStep.assessment_evening_1));

  late var evening1yesterday = MultiStepQuestionnaireFuture(
      vm: vm,
      assessmentTypes: AssessmentTypes.evening_1_yesterday,
      key: ValueKey(MorningAssessmentStep.assessment_evening_1_yesterday));

  late var evening2yesterday = MultiStepQuestionnaireFuture(
      vm: vm,
      assessmentTypes: AssessmentTypes.evening_2_yesterday,
      key: ValueKey(MorningAssessmentStep.assessment_evening_2_yesterday));

  late var evening3yesterday = MultiStepQuestionnaireFuture(
      vm: vm,
      assessmentTypes: AssessmentTypes.evening_3_yesterday,
      key: ValueKey(MorningAssessmentStep.assessment_evening_3_yesterday));

  late var evening2 = MultiStepQuestionnaireFuture(
      vm: vm,
      assessmentTypes: AssessmentTypes.evening_2,
      key: ValueKey(MorningAssessmentStep.assessment_evening_2));

  late var evening3 = MultiStepQuestionnaireFuture(
      vm: vm,
      assessmentTypes: AssessmentTypes.evening_3,
      key: ValueKey(MorningAssessmentStep.assessment_evening_3));

  late var afterTest1 = MultiStepQuestionnaireFuture(
      vm: vm,
      assessmentTypes: AssessmentTypes.afterTest,
      key: ValueKey(MorningAssessmentStep.assessment_afterTest));

  late var afterTest2 = MultiStepQuestionnaireFuture(
      vm: vm,
      assessmentTypes: AssessmentTypes.afterTest_2,
      key: ValueKey(MorningAssessmentStep.assessment_afterTest_2));

  late var afterTestFailure = MultiStepQuestionnaireFuture(
      vm: vm,
      assessmentTypes: AssessmentTypes.afterTest_failure,
      key: ValueKey(MorningAssessmentStep.assessment_afterTest_failure));

  late var afterTestSuccess = MultiStepQuestionnaireFuture(
      vm: vm,
      assessmentTypes: AssessmentTypes.afterTest_success,
      key: ValueKey(MorningAssessmentStep.assessment_afterTest_success));

  late var preVocab = PreVocabScreen2(
      nextVocabDate: vm.getNextVocabTestDate(),
      key: ValueKey(MorningAssessmentStep.preVocab));

  late var preVocabCheck = PreVocabCheck(
      nextVocabDate: vm.getNextVocabTestDate(),
      key: ValueKey(MorningAssessmentStep.preVocabCheck));

  late var yesterdayVocab = YesterdayVocabScreen(
      nextVocabTestDate: vm.getNextVocabTestDate(),
      key: ValueKey(MorningAssessmentStep.yesterdayVocab));

  late var finalSession1 = MultiStepQuestionnaireFuture(
      vm: vm,
      assessmentTypes: AssessmentTypes.finalSession_1,
      key: ValueKey(MorningAssessmentStep.assessment_finalSession_1));

  late var finalSession2 = MultiStepQuestionnaireFuture(
      vm: vm,
      assessmentTypes: AssessmentTypes.finalSession_2,
      key: ValueKey(MorningAssessmentStep.assessment_finalSession_2));

  late var finalSession3 = MultiStepQuestionnaireFuture(
      vm: vm,
      assessmentTypes: AssessmentTypes.finalSession_3,
      key: ValueKey(MorningAssessmentStep.assessment_finalSession_3));

  late var finalSession4 = MultiStepQuestionnaireFuture(
      vm: vm,
      assessmentTypes: AssessmentTypes.finalSession_4,
      key: ValueKey(MorningAssessmentStep.assessment_finalSession_4));

  late var planDisplay = FutureBuilder(
      future: vm.getPlan(),
      builder: (_, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data != null) {
            var plan = snapshot.data as String;
            return FinalPlanDisplay(plan: plan);
          }
        }
        return Container(child: CircularProgressIndicator());
      });

  late var finalPromptScreen = ListView(children: [
    UIHelper.verticalSpaceLarge(),
    MarkdownBody(
        data: "### " +
            "Heute ist der letzte Tag, an dem d PROMPT jeden Tag benutzen solltest."),
    UIHelper.verticalSpaceMedium(),
    MarkdownBody(
        data: "### " +
            "Wir haben jetzt noch ein paar Fragen dazu, wie die Studie bisher für dich gewesen ist."),
  ]);

  late var lastScreen = ListView(children: [
    UIHelper.verticalSpaceLarge(),
    MarkdownBody(
        data: "### " +
            "Du bist jetzt fertig mit der Studie! Vielen Dank, dass du so toll mitgemacht hast!"),
    UIHelper.verticalSpaceMedium(),
    MarkdownBody(
        data: "### " +
            "Wir senden dir in den kommenden Wochen den Amazon-Gutschein zu. Bitte habe etwas Geduld - du solltest im Januar von uns hören."),
    UIHelper.verticalSpaceMedium(),
    MarkdownBody(
        data: "### " +
            "Die App cabuu kannst du nun kostenlos weiter verwenden. Die App PROMPT kannst du deinstallieren."),
  ]);

  late var completed = ListView(children: [
    UIHelper.verticalSpaceLarge(),
    MarkdownBody(
        data: "### " + vm.finalMessage,
        key: ValueKey(MorningAssessmentStep.completed))
  ]);

  late var boosterPrompt = BoosterStrategyPromptScreen(
      waitingDuration: vm.boosterPromptDuration,
      onCompleted: vm.onBoosterPromptCompleted,
      key: ValueKey(MorningAssessmentStep.boosterPrompt));

  late var didLearnQuestionnaire = MultiStepQuestionnaireFuture(
      vm: vm,
      assessmentTypes: AssessmentTypes.didLearnWhen,
      key: ValueKey(MorningAssessmentStep.didLearn));

  late var finalPromptDayIntroduction = ListView(
      key: ValueKey(MorningAssessmentStep.finalPromptDayIntroduction),
      children: [
        UIHelper.verticalSpaceLarge(),
        MarkdownBody(
            data: "### " +
                "Heute ist der letzte Tag, an dem du PROMPT jeden Tag benutzen solltest."),
        UIHelper.verticalSpaceMedium(),
        MarkdownBody(
            data: "### " +
                "Wir haben jetzt noch ein paar Fragen dazu, wie die Studie bisher für dich gewesen ist."),
      ]);

  late var finalPromptDayComplete = ListView(
      key: ValueKey(MorningAssessmentStep.finalPromptDayComplete),
      children: [
        UIHelper.verticalSpaceLarge(),
        MarkdownBody(data: "### " + "Danke!"),
        UIHelper.verticalSpaceMedium(),
        MarkdownBody(
            data: "### " +
                "Die letzten beiden Vokabellisten sollst du nun alleine lernen. Ab morgen musst du also nicht mehr täglich PROMPT benutzen. Nur an den Tagen, an denen du den Vokabeltest machst, sollst du noch einmal Fragen beantworten."),
        UIHelper.verticalSpaceMedium(),
        MarkdownBody(
            data: "### " +
                "**Wichtig:** Behalte die PROMPT auf dem Handy. An den Tagen, an denen du den Vokabeltest machen sollst, schicken wir dir eine Notification."),
      ]);
}
