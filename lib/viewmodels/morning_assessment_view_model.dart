import 'package:flutter/foundation.dart';
import 'package:prompt/models/assessment_result.dart';
import 'package:prompt/services/data_service.dart';
import 'package:prompt/services/experiment_service.dart';
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
  rememberToUsePromptAfterCabuu,
  rememberToUsePromptBeforeCabuu,
  alternativeItems,
  boosterPrompt,
  internalisation,
  completed,
  preVocab,
  preVocab2,
  assessment_evening_1_yesterday,
  assessment_evening_2_yesterday,
  assessment_evening_3_yesterday,
  assessment_evening_1,
  assessment_evening_2,
  assessment_evening_3,
  assessment_afterTest,
  assessment_afterTest_success,
  assessment_afterTest_failure,
  assessment_afterTest_2,
  assessment_morningIntention,
  assessment_morning_with_intention,
  assessment_morning_without_intention,
  assessment_evening_alternative,
  yesterdayVocab
}

class MorningAssessmentViewModel extends MultiStepAssessmentViewModel {
  final ExperimentService experimentService;

  InternalisationCondition _internalisationCondition =
      InternalisationCondition.emojiIf;

  InternalisationViewModel internalisationViewmodel =
      InternalisationViewModel();

  int group = 0;

  final Duration boosterPromptDuration = Duration(seconds: 7);

  String finalMessage = "Vielen Dank, dass du die Fragen beantwortet hast!";

  List<MorningAssessmentStep> screenOrder = [];

  MorningAssessmentViewModel(this.experimentService, DataService dataService)
      : super(dataService) {
    this.group = dataService.getUserDataCache().group;
    if (experimentService.isVocabTestDay() &&
        !experimentService.didCompletePreVocabToday()) {
      finalMessage = "Denk dran, dass du heute in cabuu den Test machen sollst.";
    }

    screenOrder = getScreenOrder(group);
  }

  Future<bool> getInitialValues() async {
    var ud = dataService.getUserDataCache();

    return true;
  }

  DateTime getNextVocabTestDate() {
    var ud = dataService.getUserDataCache();
    return ud.registrationDate.add(Duration(days: 8));
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

    if (experimentService.isLastVocabTestDay()) {}

    if (experimentService.isVocabTestDay()) {
      if (experimentService.didCompletePreVocabToday()) {
        order = [
          MorningAssessmentStep.assessment_afterTest,
          MorningAssessmentStep.assessment_afterTest_success,
          MorningAssessmentStep.assessment_afterTest_failure,
          MorningAssessmentStep.assessment_afterTest_2,
        ];
      } else {
        order = [
          MorningAssessmentStep.preVocab,
          MorningAssessmentStep.preVocab2,
        ];
      }
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
      MorningAssessmentStep.completed
    ]);

    return order;
  }

  bool _preVocabVideoCompleted = false;
  void onPreVocabVideoCompleted() {
    _preVocabVideoCompleted = true;
    var result = AssessmentResult({}, "preVocabCompleted", DateTime.now());
    dataService.saveAssessment(result);
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
      case MorningAssessmentStep.preVocab2:
      case MorningAssessmentStep.completed:
      case MorningAssessmentStep.preVocab:
        return true;
      case MorningAssessmentStep.internalisation:
        return internalisationViewmodel.completed;
      case MorningAssessmentStep.alternativeItems:
      case MorningAssessmentStep.yesterdayVocab:
      case MorningAssessmentStep.didLearn:
      case MorningAssessmentStep.assessment_evening_1_yesterday:
      case MorningAssessmentStep.assessment_evening_2_yesterday:
      case MorningAssessmentStep.assessment_evening_3_yesterday:
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
      case MorningAssessmentStep.assessment_evening_alternative:
        return currentAssessmentIsFilledOut;
      case MorningAssessmentStep.boosterPrompt:
        return _boosterPromptCompleted;
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
      return getStepIndex(MorningAssessmentStep.boosterPrompt);
    } else {
      return getStepIndex(MorningAssessmentStep.completed);
    }
  }

  @override
  int getNextPage(ValueKey currentPageKey) {
    step += 1;

    var pageKey = currentPageKey.value as MorningAssessmentStep;

    switch (pageKey) {
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
        if (experimentService.isInternalisationDay()) {
          step = getStepIndex(MorningAssessmentStep.internalisation);
        } else {
          step = getStepIndex(MorningAssessmentStep.completed);
        }
        break;
      case MorningAssessmentStep.internalisation:
        step = getStepIndex(MorningAssessmentStep.completed);
        break;
      case MorningAssessmentStep.completed:
        // TODO: Handle this case.
        break;
      case MorningAssessmentStep.preVocab:
        step = getStepIndex(MorningAssessmentStep.preVocab2);
        break;
      case MorningAssessmentStep.preVocab2:
        onPreVocabVideoCompleted();
        step = getStepIndex(MorningAssessmentStep.completed);
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
        step = getStepIndex(MorningAssessmentStep.assessment_afterTest_2);
        break;
      case MorningAssessmentStep.assessment_afterTest_failure:
        step = getStepIndex(MorningAssessmentStep.assessment_afterTest_2);
        break;
      case MorningAssessmentStep.assessment_afterTest_2:
        step = getStepIndex(MorningAssessmentStep.completed);
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
        step = getStepIndex(MorningAssessmentStep.assessment_morningIntention);
        break;
      case MorningAssessmentStep.firstDay_1:
        step = getStepIndex(MorningAssessmentStep.firstDay_2);
        break;
      case MorningAssessmentStep.firstDay_2:
        step = getStepIndex(MorningAssessmentStep.assessment_morningIntention);
        break;
      case MorningAssessmentStep.lastVocab_1:
        step = getStepIndex(MorningAssessmentStep.lastVocab_1);
        break;
      case MorningAssessmentStep.lastVocab_2:
        step = getStepIndex(MorningAssessmentStep.assessment_afterTest);
        break;
      case MorningAssessmentStep.rememberToUsePromptBeforeCabuu:
        step = getStepIndex(MorningAssessmentStep.assessment_evening_1);
        break;
    }

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
    print("Internalisation completed with input $input");
    notifyListeners();
  }

  Future<bool> getPlan() async {
    var lastPlan = await dataService.getLastPlan();
    if (lastPlan != null) {
      internalisationViewmodel.plan = lastPlan.plan;
    }
    return true;
  }

  @override
  void submit() async {
    Map<String, String> results = {};
    for (var result in allAssessmentResults.values) {
      results.addAll(result);
    }
    var oneBigAssessment =
        AssessmentResult(results, MORNING_ASSESSMENT, DateTime.now());
    oneBigAssessment.startDate = this.startDate;

    experimentService.submitAssessment(oneBigAssessment, MORNING_ASSESSMENT);

    experimentService.nextScreen(RouteNames.ASSESSMENT_MORNING);
  }
}
