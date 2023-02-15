import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:prompt/models/questionnaire_response.dart';
import 'package:prompt/services/data_service.dart';
import 'package:prompt/services/study_service.dart';
import 'package:prompt/services/reward_service.dart';
import 'package:prompt/shared/enums.dart';
import 'package:prompt/viewmodels/internalisation_view_model.dart';
import 'package:prompt/viewmodels/multi_page_view_model.dart';

enum OnboardingStep {
  welcome,
  video_introduction,
  rewardScreen1,
  video_distributedLearning,
  outcome,
  obstacle,
  copingPlan,
  instructions_implementationIntentions,
  video_Planning,
  planInternalisationEmoji,
  assessment_itLiteracy,
  assessment_learningFrequencyDuration,
  assessment_motivation,
  assessment_learningExpectations,
  assessment_distributedLearning,
  assessment_selfEfficacy,
  cabuuCode,
  whyLearnVocabScreen,
  planCreation,
  planDisplay,
  planInternalisationWaiting,
  planTiming,
  instructions1,
  instructions2,
  instructions3,
  instructions4,
  instructions_cabuu_1,
  instructions_cabuu_2,
  instructions_cabuu_3,
  instructions_distributedLearning,
  rewardScreen2,
  endOfSession
}

class OnboardingViewModel extends MultiPageViewModel {
  InternalisationViewModel internalisationViewmodelEmoji =
      InternalisationViewModel();

  String _plan = "";
  String get plan => _plan;
  set plan(String plan) {
    plan = "Wenn ich $plan, dann lerne ich mit cabuu!";
    this._plan = plan;
    internalisationViewmodelEmoji.plan = plan;
    notifyListeners();
  }

  String cabuuCode = "123";

  String _obstacle = "";
  String get obstacle => _obstacle;
  set obstacle(String obstacle) {
    _obstacle = obstacle;
    notifyListeners();
  }

  String _outcome = "";
  String get outcome => _outcome;
  set outcome(String outcome) {
    _outcome = outcome;
    notifyListeners();
  }

  String _copingPlan = "";
  String get copingPlan => _copingPlan;
  set copingPlan(String copingPlan) {
    _copingPlan = copingPlan;
    notifyListeners();
  }

  bool _consented = false;
  bool get consented => _consented;
  set consented(bool consented) {
    _consented = consented;
    notifyListeners();
  }

  String _vocabValue = "";
  String get vocabValue => _vocabValue;
  set vocabValue(String vocabValue) {
    _vocabValue = vocabValue;
    notifyListeners();
  }

  bool _videoPlanningCompleted = false;
  void videoPlanningCompleted() {
    _videoPlanningCompleted = true;
    notifyListeners();
  }

  bool _videoDistributedLearningCompleted = false;
  void videoDistributedLearningCompleted() {
    _videoDistributedLearningCompleted = true;
    notifyListeners();
  }

  bool _videoWelcomeCompleted = false;
  void videoWelcomeCompleted() {
    _videoWelcomeCompleted = true;
    notifyListeners();
  }

  void onInternalisationCompleted(String result) {
    notifyListeners();
  }

  void onWaitingInternalisationCompleted(String result) {
    notifyListeners();
  }

  final StudyService _experimentService;
  final RewardService _rewardService;

  OnboardingViewModel(
      this._experimentService, DataService dataService, this._rewardService)
      : super(dataService) {
    generateScreenOrder();
  }

  void generateScreenOrder() {
    pages = getScreenOrder();
  }

  Future<bool> getInitialValues() async {
    var plan = await dataService.getLastPlan();
    if (plan != null) {
      this.plan = plan;
    }

    var ud = dataService.getUserDataCache();
    initialPage = max(ud.initStep, pages.length - 1);
    cabuuCode = ud.cabuuCode;

    return true;
  }

  List<OnboardingStep> getScreenOrder() {
    List<OnboardingStep> screenOrder = [
      OnboardingStep.welcome,
      OnboardingStep.video_introduction,
      OnboardingStep.rewardScreen1,
      OnboardingStep.outcome,
      OnboardingStep.obstacle,
      OnboardingStep.copingPlan,
      OnboardingStep.instructions_implementationIntentions,
      OnboardingStep.video_Planning,
      OnboardingStep.planCreation,
      OnboardingStep.planDisplay,
      OnboardingStep.planInternalisationEmoji,
      OnboardingStep.rewardScreen2,
      OnboardingStep.planTiming,
    ];

    return screenOrder;
  }

  @override
  int getNextPage(ValueKey? currentPageKey) {
    page += 1;

    var end = (page < pages.length - 1) ? pages[page].toString() : "complete";
    if (currentPageKey != null) {
      addTiming(currentPageKey.value.toString(), end);
    }

    return page;
  }

  saveInternalisation() {
    var response = QuestionnaireResponse(
        name: InternalisationCondition.emojiIf.name,
        questionnaireName: "internalisation",
        questionText: internalisationViewmodelEmoji.plan,
        response: internalisationViewmodelEmoji.input,
        dateSubmitted: DateTime.now());
    dataService.saveQuestionnaireResponse(response);
  }

  @override
  Future<bool> doStepDependentSubmission(ValueKey currentPageKey) async {
    var stepKey = currentPageKey.value as OnboardingStep;

    switch (stepKey) {
      case OnboardingStep.welcome:
      case OnboardingStep.cabuuCode:
      case OnboardingStep.video_Planning:
      case OnboardingStep.video_distributedLearning:
      case OnboardingStep.instructions1:
      case OnboardingStep.instructions2:
      case OnboardingStep.instructions3:
      case OnboardingStep.instructions4:
      case OnboardingStep.instructions_cabuu_1:
      case OnboardingStep.instructions_cabuu_2:
      case OnboardingStep.instructions_cabuu_3:
      case OnboardingStep.instructions_distributedLearning:
      case OnboardingStep.instructions_implementationIntentions:
      case OnboardingStep.rewardScreen1:
      case OnboardingStep.planInternalisationWaiting:
      case OnboardingStep.rewardScreen2:
      case OnboardingStep.planDisplay:
        break;
      case OnboardingStep.video_introduction:
        if (_rewardService.scoreValue < 5) {
          _rewardService.addPoints(5);
        }
        break;
      case OnboardingStep.assessment_itLiteracy:
      case OnboardingStep.assessment_learningFrequencyDuration:
      case OnboardingStep.assessment_motivation:
      case OnboardingStep.assessment_learningExpectations:
      case OnboardingStep.assessment_distributedLearning:
      case OnboardingStep.assessment_selfEfficacy:
      case OnboardingStep.planTiming:
        break;
      case OnboardingStep.whyLearnVocabScreen:
        var vocabValueResponse = QuestionnaireResponse(
            name: "vocabValue",
            questionnaireName: "vocabvalue",
            questionText: "",
            response: vocabValue,
            dateSubmitted: DateTime.now());
        dataService.saveQuestionnaireResponse(vocabValueResponse);
        break;
      case OnboardingStep.planCreation:
        var planResponse = QuestionnaireResponse(
            name: AssessmentTypes.plan,
            questionnaireName: AssessmentTypes.plan,
            questionText: "",
            response: vocabValue,
            dateSubmitted: DateTime.now());
        dataService.saveQuestionnaireResponse(planResponse);
        break;
      case OnboardingStep.planInternalisationEmoji:
        saveInternalisation();
        if (_rewardService.scoreValue < 10) {
          _rewardService.addPoints(20);
        }

        break;
      case OnboardingStep.endOfSession:
        break;
      case OnboardingStep.outcome:
        var outcomeResponse = QuestionnaireResponse(
            name: "outcome",
            questionnaireName: "outcome",
            questionText: "",
            response: outcome,
            dateSubmitted: DateTime.now());
        dataService.saveQuestionnaireResponse(outcomeResponse);
        break;
      case OnboardingStep.obstacle:
        var obstacleResponse = QuestionnaireResponse(
            name: "obstacle",
            questionnaireName: "obstacle",
            questionText: "",
            response: obstacle,
            dateSubmitted: DateTime.now());
        dataService.saveQuestionnaireResponse(obstacleResponse);
        break;
      case OnboardingStep.copingPlan:
        var copingPlanResponse = QuestionnaireResponse(
            name: "copingPlan",
            questionnaireName: "copingPlan",
            questionText: "",
            response: copingPlan,
            dateSubmitted: DateTime.now());
        dataService.saveQuestionnaireResponse(copingPlanResponse);
        break;
    }

    return true;
  }

  int getStepIndex(OnboardingStep step) {
    return pages.indexOf(step);
  }

  @override
  bool canMoveBack(ValueKey? currentPageKey) {
    var stepKey = pages[page];

    return true;
    switch (stepKey) {
      case OnboardingStep.rewardScreen1:
      case OnboardingStep.instructions_cabuu_2:
      case OnboardingStep.instructions_cabuu_3:
      case OnboardingStep.instructions2:
      case OnboardingStep.instructions3:
      case OnboardingStep.video_introduction:
      case OnboardingStep.planDisplay:
      case OnboardingStep.cabuuCode:
      case OnboardingStep.welcome:
      case OnboardingStep.instructions_cabuu_1:
      case OnboardingStep.assessment_itLiteracy:
      case OnboardingStep.assessment_learningFrequencyDuration:
      case OnboardingStep.assessment_motivation:
      case OnboardingStep.assessment_learningExpectations:
      case OnboardingStep.assessment_selfEfficacy:
      case OnboardingStep.assessment_distributedLearning:
      case OnboardingStep.video_Planning:
      case OnboardingStep.video_distributedLearning:
      case OnboardingStep.planCreation:
      case OnboardingStep.planInternalisationEmoji:
      case OnboardingStep.planTiming:
      case OnboardingStep.instructions1:
      case OnboardingStep.instructions4:
      case OnboardingStep.instructions_distributedLearning:
      case OnboardingStep.instructions_implementationIntentions:
      case OnboardingStep.endOfSession:
      case OnboardingStep.whyLearnVocabScreen:
      case OnboardingStep.planInternalisationWaiting:
      case OnboardingStep.rewardScreen2:
        return false;
      case OnboardingStep.outcome:
        return outcome.isNotEmpty;
      case OnboardingStep.obstacle:
        return obstacle.isNotEmpty;
      case OnboardingStep.copingPlan:
        return copingPlan.isNotEmpty;
    }
  }

  @override
  bool canMoveNext(ValueKey? currentPageKey) {
    var stepKey = pages[page]; //currentPageKey!.value as SessionZeroStep;
    return true;
    switch (stepKey) {
      case OnboardingStep.video_introduction:
        return _videoWelcomeCompleted;
      case OnboardingStep.welcome:
      case OnboardingStep.cabuuCode:
      case OnboardingStep.planDisplay:
        return true;
      case OnboardingStep.assessment_itLiteracy:
      case OnboardingStep.assessment_learningFrequencyDuration:
      case OnboardingStep.assessment_motivation:
      case OnboardingStep.assessment_learningExpectations:
      case OnboardingStep.assessment_selfEfficacy:
      case OnboardingStep.assessment_distributedLearning:
        return currentAssessmentIsFilledOut;
      case OnboardingStep.whyLearnVocabScreen:
        return vocabValue.isNotEmpty;
      case OnboardingStep.video_Planning:
        return _videoPlanningCompleted;
      case OnboardingStep.video_distributedLearning:
        return _videoDistributedLearningCompleted;
      case OnboardingStep.planCreation:
        return plan.isNotEmpty;
      case OnboardingStep.planInternalisationEmoji:
        return this.internalisationViewmodelEmoji.input.isNotEmpty;
      case OnboardingStep.planTiming:
        break;
      default:
        return true;
    }

    return true;
  }

  @override
  void submit() async {
    if (state == ViewState.idle) {
      setState(ViewState.busy);
      await _experimentService.submitResponses(
          questionnaireResponses, SESSION_ZERO);

      _experimentService.nextScreen();
    }
  }
}
