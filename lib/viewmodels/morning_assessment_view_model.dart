import 'package:flutter/foundation.dart';
import 'package:prompt/models/assessment_result.dart';
import 'package:prompt/models/internalisation.dart';
import 'package:prompt/services/data_service.dart';
import 'package:prompt/services/experiment_service.dart';
import 'package:prompt/services/reward_service.dart';
import 'package:prompt/shared/enums.dart';
import 'package:prompt/shared/route_names.dart';
import 'package:prompt/viewmodels/internalisation_view_model.dart';
import 'package:prompt/viewmodels/multi_step_assessment_view_model.dart';
import 'package:prompt/shared/extensions.dart';

enum MorningAssessmentStep {
  firstDay_1,
  firstDay_2,
  lastVocab_1,
  lastVocab_2,
  didLearn,
  finalPromptDayIntroduction,
  finalPromptDayComplete,
  rememberToUsePromptAfterCabuu,
  distributedLearningIntermediate,
  distributedLearningVideo,
  assessment_distributedLearning,
  rememberToUsePromptBeforeCabuu,
  alternativeItems,
  boosterPrompt,
  internalisation,
  completed,
  preVocab,
  preVocabCheck,
  assessment_evening_1_yesterday,
  assessment_evening_2_yesterday,
  assessment_evening_3_yesterday,
  assessment_evening_1,
  assessment_evening_2,
  assessment_evening_3,
  assessment_finalSession_1,
  assessment_finalSession_2,
  assessment_finalSession_3,
  assessment_finalSession_4,
  assessment_afterTest,
  assessment_afterTest_success,
  assessment_afterTest_failure,
  assessment_afterTest_2,
  assessment_morningIntention,
  assessment_morning_with_intention,
  assessment_morning_without_intention,
  assessment_evening_alternative,
  yesterdayVocab,
  planDisplay,
  last_screen
}

class MorningAssessmentViewModel extends MultiStepAssessmentViewModel {
  final ExperimentService experimentService;

  InternalisationCondition _internalisationCondition =
      InternalisationCondition.emojiIf;

  InternalisationViewModel internalisationViewmodel =
      InternalisationViewModel();

  int group = 0;

  final Duration boosterPromptDuration = Duration(seconds: 10);
  final Duration waitingInternalisationDuration = Duration(seconds: 15);

  String finalMessage = "Vielen Dank, dass du die Fragen beantwortet hast!";
  String pointsMessage = "";

  String finalFeedbackGood = "";
  String finalFeedbackBad = "";
  String finalFeedbackOpen = "";

  DateTime boosterPromptStart = DateTime.now();
  DateTime boosterPromptComplete = DateTime.now();

  bool _preVocabCompleted = false;
  set preVocabCompleted(value) {
    _preVocabCompleted = true;
    notifyListeners();
  }

  List<MorningAssessmentStep> screenOrder = [];

  MorningAssessmentViewModel(this.experimentService, DataService dataService)
      : super(dataService) {
    this.group = dataService.getUserDataCache().group;

    screenOrder = getScreenOrder(group);

    var points = experimentService.getPointsForMorningAssessment();

    pointsMessage =
        "Für deine Teilnahme bekommst du $points 💎. Denk daran, dass du mehr 💎 bekommst, wenn du an an jedem Tag mitmachst.";
  }

  bool _distributedLearningVideoCompleted = false;
  onDistributedLearningVideoCompleted() {
    _distributedLearningVideoCompleted = true;
    notifyListeners();
  }

  DateTime getNextVocabTestDate() {
    var nextDate = experimentService.getNextVocabTestDate();
    return nextDate;
  }

  int getVocabListNumber() {
    return experimentService.getNextVocabListNumber();
  }

  List<MorningAssessmentStep> getScreenOrder(int group) {
    List<MorningAssessmentStep> order = [];
    // order.addAll(MorningAssessmentStep.values);
    // return order;

    if (experimentService.isFirstDay()) {
      order = [
        MorningAssessmentStep.firstDay_1,
        MorningAssessmentStep.firstDay_2,
      ];
    }

    if (experimentService.isLastVocabTestDay()) {
      order.addAll([
        MorningAssessmentStep.lastVocab_1,
        MorningAssessmentStep.preVocabCheck,
        MorningAssessmentStep.assessment_afterTest,
        MorningAssessmentStep.assessment_afterTest_success,
        MorningAssessmentStep.assessment_afterTest_failure,
        MorningAssessmentStep.assessment_afterTest_2,
      ]);
    } else if (experimentService.isVocabTestDay()) {
      order.addAll([
        MorningAssessmentStep.preVocab,
        MorningAssessmentStep.preVocabCheck,
        MorningAssessmentStep.assessment_afterTest,
        MorningAssessmentStep.assessment_afterTest_success,
        MorningAssessmentStep.assessment_afterTest_failure,
        MorningAssessmentStep.assessment_afterTest_2,
      ]);
    }

    if (experimentService.wasVocabDayYesterday()) {
      order.add(MorningAssessmentStep.yesterdayVocab);
    }

    order.addAll([
      MorningAssessmentStep.didLearn,
      MorningAssessmentStep.rememberToUsePromptAfterCabuu,
      MorningAssessmentStep.rememberToUsePromptBeforeCabuu,
      MorningAssessmentStep.assessment_evening_1_yesterday,
      MorningAssessmentStep.assessment_evening_2_yesterday,
      MorningAssessmentStep.assessment_evening_3_yesterday,
      MorningAssessmentStep.assessment_evening_1,
      MorningAssessmentStep.assessment_evening_2,
      MorningAssessmentStep.assessment_evening_3,
      MorningAssessmentStep.alternativeItems,
      MorningAssessmentStep.assessment_morningIntention,
      MorningAssessmentStep.assessment_morning_with_intention,
      MorningAssessmentStep.assessment_morning_without_intention,
      MorningAssessmentStep.assessment_evening_alternative,
      MorningAssessmentStep.boosterPrompt,
      MorningAssessmentStep.internalisation,
    ]);

    if (experimentService.isDistributedLearningDay()) {
      order.addAll([
        MorningAssessmentStep.distributedLearningIntermediate,
        MorningAssessmentStep.distributedLearningVideo,
        MorningAssessmentStep.assessment_distributedLearning,
      ]);
    }

    if (experimentService.isTimeForFinalQuestions()) {
      if ([2, 3, 4, 5, 6].contains(group)) {
        order.addAll([
          MorningAssessmentStep.finalPromptDayIntroduction,
          MorningAssessmentStep.assessment_finalSession_1,
          MorningAssessmentStep.assessment_finalSession_2,
          MorningAssessmentStep.assessment_finalSession_3,
          MorningAssessmentStep.planDisplay,
          MorningAssessmentStep.assessment_finalSession_4,
          MorningAssessmentStep.finalPromptDayComplete,
        ]);
      } else if (group == 7) {
        order.addAll([
          MorningAssessmentStep.finalPromptDayIntroduction,
          MorningAssessmentStep.assessment_finalSession_1,
          MorningAssessmentStep.assessment_finalSession_2,
          MorningAssessmentStep.assessment_finalSession_3,
          MorningAssessmentStep.finalPromptDayComplete,
        ]);
      } else if (group == 1) {
        order.addAll([
          MorningAssessmentStep.assessment_finalSession_1,
          MorningAssessmentStep.assessment_finalSession_2,
          MorningAssessmentStep.assessment_finalSession_3,
        ]);
      }
    }

    if (experimentService.isLastVocabTestDay()) {
      order.add(MorningAssessmentStep.last_screen);
    } else {
      order.add(MorningAssessmentStep.completed);
    }

    return order;
  }

  @override
  bool canMoveBack(ValueKey currentPageKey) {
    return false;
  }

  @override
  bool canMoveNext(ValueKey currentPageKey) {
    var pageKey = currentPageKey.value as MorningAssessmentStep;

    switch (pageKey) {
      case MorningAssessmentStep.firstDay_1:
      case MorningAssessmentStep.firstDay_2:
      case MorningAssessmentStep.lastVocab_1:
      case MorningAssessmentStep.lastVocab_2:
      case MorningAssessmentStep.rememberToUsePromptBeforeCabuu:
      case MorningAssessmentStep.rememberToUsePromptAfterCabuu:
      case MorningAssessmentStep.completed:
      case MorningAssessmentStep.last_screen:
      case MorningAssessmentStep.preVocab:
      case MorningAssessmentStep.distributedLearningIntermediate:
      case MorningAssessmentStep.finalPromptDayIntroduction:
      case MorningAssessmentStep.finalPromptDayComplete:
      case MorningAssessmentStep.planDisplay:
      case MorningAssessmentStep.assessment_finalSession_3:
      case MorningAssessmentStep.yesterdayVocab:
        return true;
      case MorningAssessmentStep.preVocabCheck:
        return _preVocabCompleted;
      case MorningAssessmentStep.internalisation:
        return internalisationViewmodel.completed;
      case MorningAssessmentStep.alternativeItems:
      case MorningAssessmentStep.didLearn:
      case MorningAssessmentStep.assessment_evening_1_yesterday:
      case MorningAssessmentStep.assessment_evening_2_yesterday:
      case MorningAssessmentStep.assessment_evening_3_yesterday:
      case MorningAssessmentStep.assessment_finalSession_1:
      case MorningAssessmentStep.assessment_finalSession_2:
      case MorningAssessmentStep.assessment_finalSession_4:
      case MorningAssessmentStep.assessment_evening_1:
      case MorningAssessmentStep.assessment_evening_2:
      case MorningAssessmentStep.assessment_evening_3:
      case MorningAssessmentStep.assessment_afterTest:
      case MorningAssessmentStep.assessment_afterTest_success:
      case MorningAssessmentStep.assessment_afterTest_failure:
      case MorningAssessmentStep.assessment_afterTest_2:
      case MorningAssessmentStep.assessment_morningIntention:
      case MorningAssessmentStep.assessment_morning_with_intention:
      case MorningAssessmentStep.assessment_morning_without_intention:
      case MorningAssessmentStep.assessment_distributedLearning:
      case MorningAssessmentStep.assessment_evening_alternative:
        return currentAssessmentIsFilledOut;
      case MorningAssessmentStep.boosterPrompt:
        return _boosterPromptCompleted;
      case MorningAssessmentStep.distributedLearningVideo:
        return _distributedLearningVideoCompleted;
    }
  }

  int getStepIndex(MorningAssessmentStep morningAssessmentStep) {
    return screenOrder.indexOf(morningAssessmentStep);
  }

  bool didCompleteEveningItemsYesterday() {
    var last = dataService.getLastAssessmentResultForCached(EVENING_ASSESSMENT);

    if (last == null) return false;

    return (last.submissionDate.daysAgo() <= 1);
  }

  int getNextStepForAfterTest() {
    var step = 0;

    var answer = allAssessmentResults["after_test"]!["success_perception"];

    if (answer == "1") {
      step = getStepIndex(MorningAssessmentStep.assessment_afterTest_success);
    }
    if (answer == "2") {
      step = getStepIndex(MorningAssessmentStep.assessment_afterTest_failure);
    }

    return step;
  }

  int getStepForMorningIntention() {
    var answer = allAssessmentResults["morning_intention"]!["intention"];
    if (answer == "1") {
      return getStepIndex(
          MorningAssessmentStep.assessment_morning_with_intention);
    } else {
      return getStepIndex(
          MorningAssessmentStep.assessment_morning_without_intention);
    }
  }

  int getNextStepForDidLearn() {
    var step = 0;

    var answer = allAssessmentResults["didLearnWhen"]!["didLearnWhen_1"];

    // did learn cabuu today
    if (answer == "1") {
      step = getStepIndex(MorningAssessmentStep.rememberToUsePromptBeforeCabuu);
    }

    // did learn yesterday
    else if (answer == "2") {
      if (didCompleteEveningItemsYesterday()) {
        step = getStepIndex(MorningAssessmentStep.assessment_morningIntention);
      } else {
        step =
            getStepIndex(MorningAssessmentStep.rememberToUsePromptAfterCabuu);
      }
    }

    // did learn some other time
    else if (answer == "3") {
      if (didCompleteEveningItemsYesterday()) {
        step = getStepIndex(MorningAssessmentStep.assessment_morningIntention);
      } else {
        step = getStepIndex(MorningAssessmentStep.alternativeItems);
      }
    }

    return step;
  }

  int getStepAfterMorningIntention() {
    if (experimentService.isBoosterPromptDay()) {
      boosterPromptStart = DateTime.now();
      return getStepIndex(MorningAssessmentStep.boosterPrompt);
    } else if (experimentService.isDistributedLearningDay()) {
      return getStepIndex(
          MorningAssessmentStep.distributedLearningIntermediate);
    } else {
      return getStepIndex(MorningAssessmentStep.completed);
    }
  }

  int getNextStepAfterTestFailureOrSuccess() {
    var daysAgo = experimentService.getDaysSinceStart();

    if (daysAgo < 54) {
      return getStepIndex(MorningAssessmentStep.assessment_afterTest_2);
    } else {
      if (group == 1) {
        return getStepIndex(MorningAssessmentStep.assessment_finalSession_1);
      } else {
        return getStepIndex(MorningAssessmentStep.last_screen);
      }
    }
  }

  int getNextStepAfterTest2() {
    var daysAgo = experimentService.getDaysSinceStart();

    if (group > 1) {
      if (experimentService.isTimeForFinalQuestions()) {
        return getStepIndex(MorningAssessmentStep.finalPromptDayIntroduction);
      } else {
        return getStepIndex(MorningAssessmentStep.completed);
      }
    } else {
      if (experimentService.isDistributedLearningDay()) {
        return getStepIndex(
            MorningAssessmentStep.distributedLearningIntermediate);
      }
    }

    return getStepIndex(MorningAssessmentStep.completed);
  }

  void addFreeFeedbackToResults() {
    var results = {
      "good": finalFeedbackGood,
      "bad": finalFeedbackBad,
      "open": finalFeedbackOpen
    };
    // var res = AssessmentResult(results, "finalfeedback", DateTime.now());
    allAssessmentResults["finalfeedback"] = results;
  }

  int getNextStepAfterFinal3() {
    var daysAgo = experimentService.getDaysSinceStart();

    if ([2, 3, 7].contains(group)) {
      return getStepIndex(MorningAssessmentStep.finalPromptDayComplete);
    } else if ([
      4,
      5,
      6,
    ].contains(group)) {
      return getStepIndex(MorningAssessmentStep.planDisplay);
    } else {
      return getStepIndex(MorningAssessmentStep.last_screen);
    }
  }

  @override
  int getNextPage(ValueKey currentPageKey) {
    step += 1;

    var pageKey = currentPageKey.value as MorningAssessmentStep;

    switch (pageKey) {
      case MorningAssessmentStep.completed:
      case MorningAssessmentStep.last_screen:
      case MorningAssessmentStep.finalPromptDayComplete:
        break;
      case MorningAssessmentStep.didLearn:
        step = getNextStepForDidLearn();
        break;
      case MorningAssessmentStep.rememberToUsePromptAfterCabuu:
        step =
            getStepIndex(MorningAssessmentStep.assessment_evening_1_yesterday);
        break;
      case MorningAssessmentStep.alternativeItems:
        step = getStepIndex(MorningAssessmentStep.assessment_morningIntention);
        break;
      case MorningAssessmentStep.boosterPrompt:
        boosterPromptComplete = DateTime.now();
        dataService.saveBoosterPromptReadTimes(
            boosterPromptStart, boosterPromptComplete);
        if (experimentService.isInternalisationDay()) {
          this.internalisationViewmodel.startDate = DateTime.now();
          step = getStepIndex(MorningAssessmentStep.internalisation);
        } else {
          step = getStepIndex(MorningAssessmentStep.completed);
        }
        break;
      case MorningAssessmentStep.internalisation:
        step = getStepIndex(MorningAssessmentStep.completed);
        break;
      case MorningAssessmentStep.preVocab:
        step = getStepIndex(MorningAssessmentStep.preVocabCheck);
        break;
      case MorningAssessmentStep.preVocabCheck:
        // onPreVocabVideoCompleted();
        step = getStepIndex(MorningAssessmentStep.assessment_afterTest);
        break;
      case MorningAssessmentStep.assessment_evening_1_yesterday:
        step =
            getStepIndex(MorningAssessmentStep.assessment_evening_2_yesterday);
        break;
      case MorningAssessmentStep.assessment_evening_2_yesterday:
        step =
            getStepIndex(MorningAssessmentStep.assessment_evening_3_yesterday);
        break;
      case MorningAssessmentStep.assessment_evening_3_yesterday:
        step = getStepIndex(MorningAssessmentStep.assessment_morningIntention);
        break;
      case MorningAssessmentStep.assessment_evening_1:
        step = getStepIndex(MorningAssessmentStep.assessment_evening_2);
        break;
      case MorningAssessmentStep.assessment_evening_2:
        step = getStepIndex(MorningAssessmentStep.assessment_evening_3);
        break;
      case MorningAssessmentStep.assessment_evening_3:
        step = getStepAfterMorningIntention();
        break;
      case MorningAssessmentStep.assessment_afterTest:
        step = getNextStepForAfterTest();
        break;
      case MorningAssessmentStep.assessment_afterTest_success:
        step = getNextStepAfterTestFailureOrSuccess();
        break;
      case MorningAssessmentStep.assessment_afterTest_failure:
        step = getNextStepAfterTestFailureOrSuccess();
        break;
      case MorningAssessmentStep.assessment_afterTest_2:
        step = getNextStepAfterTest2();
        break;
      case MorningAssessmentStep.assessment_morningIntention:
        step = getStepForMorningIntention();
        break;
      case MorningAssessmentStep.assessment_morning_with_intention:
        step = getStepAfterMorningIntention();
        break;
      case MorningAssessmentStep.assessment_morning_without_intention:
        step = getStepAfterMorningIntention();
        break;
      case MorningAssessmentStep.assessment_evening_alternative:
        step = getStepIndex(MorningAssessmentStep.assessment_morningIntention);
        break;
      case MorningAssessmentStep.yesterdayVocab:
        step = getStepIndex(MorningAssessmentStep.didLearn);
        break;
      case MorningAssessmentStep.firstDay_1:
        step = getStepIndex(MorningAssessmentStep.firstDay_2);
        break;
      case MorningAssessmentStep.firstDay_2:
        step = getStepIndex(MorningAssessmentStep.assessment_morningIntention);
        break;
      case MorningAssessmentStep.lastVocab_1:
        step = getStepIndex(MorningAssessmentStep.preVocabCheck);
        break;
      case MorningAssessmentStep.lastVocab_2:
        step = getStepIndex(MorningAssessmentStep.assessment_afterTest);
        break;
      case MorningAssessmentStep.rememberToUsePromptBeforeCabuu:
        step = getStepIndex(MorningAssessmentStep.assessment_evening_1);
        break;
      case MorningAssessmentStep.assessment_finalSession_1:
        step = getStepIndex(MorningAssessmentStep.assessment_finalSession_2);
        break;
      case MorningAssessmentStep.assessment_finalSession_2:
        step = getStepIndex(MorningAssessmentStep.assessment_finalSession_3);
        break;
      case MorningAssessmentStep.assessment_finalSession_3:
        addFreeFeedbackToResults();
        step = getNextStepAfterFinal3();
        break;
      case MorningAssessmentStep.finalPromptDayIntroduction:
        step = getStepIndex(MorningAssessmentStep.assessment_finalSession_1);
        break;
      case MorningAssessmentStep.assessment_finalSession_4:
        step = getStepIndex(MorningAssessmentStep.finalPromptDayComplete);
        break;
      case MorningAssessmentStep.planDisplay:
        step = getStepIndex(MorningAssessmentStep.assessment_finalSession_4);
        break;
      case MorningAssessmentStep.distributedLearningIntermediate:
        step = getStepIndex(MorningAssessmentStep.distributedLearningVideo);
        break;
      case MorningAssessmentStep.distributedLearningVideo:
        step =
            getStepIndex(MorningAssessmentStep.assessment_distributedLearning);
        break;
      case MorningAssessmentStep.assessment_distributedLearning:
        step = getStepIndex(MorningAssessmentStep.completed);
        break;
    }

    addTiming(pageKey.toString(), screenOrder[step].toString());

    return step;
  }

  InternalisationCondition getInternalisationCondition() {
    _internalisationCondition = experimentService.getInternalisationCondition();
    return _internalisationCondition;
  }

  bool _boosterPromptCompleted = false;
  void onBoosterPromptCompleted(String param) {
    _boosterPromptCompleted = true;
    notifyListeners();
  }

  void onInternalisationCompleted(String input) {
    this.internalisationViewmodel.completed = true;
    var submitInternalisation = Internalisation(
        startDate: this.internalisationViewmodel.startDate,
        completionDate: DateTime.now(),
        condition: this.internalisationViewmodel.condition.toString(),
        plan: input);
    dataService.saveInternalisation(submitInternalisation);
    print("Internalisation completed with input $input");
    notifyListeners();
  }

  Future<String> getPlan() async {
    var lastPlan = await dataService.getLastPlan();

    internalisationViewmodel.plan = lastPlan!.plan;

    return lastPlan.plan;
  }

  @override
  void submit() async {
    if (state == ViewState.idle) {
      setState(ViewState.busy);

      var oneBigAssessment = this.getOneBisAssessment(MORNING_ASSESSMENT);

      await experimentService.submitAssessment(
          oneBigAssessment, MORNING_ASSESSMENT);

      experimentService.nextScreen(RouteNames.ASSESSMENT_MORNING);
      setState(ViewState.idle);
    }
  }
}
