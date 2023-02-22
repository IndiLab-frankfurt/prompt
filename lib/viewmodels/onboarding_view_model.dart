import 'package:flutter/foundation.dart';
import 'package:prompt/data/assessments.dart';
import 'package:prompt/models/questionnaire_response.dart';
import 'package:prompt/services/data_service.dart';
import 'package:prompt/services/study_service.dart';
import 'package:prompt/services/reward_service.dart';
import 'package:prompt/shared/enums.dart';
import 'package:prompt/viewmodels/internalisation_view_model.dart';
import 'package:prompt/viewmodels/multi_page_view_model.dart';
import 'package:prompt/viewmodels/onboarding_questionnaire_view_model.dart';
import 'package:collection/collection.dart';

enum OnboardingStep {
  welcome,
  video_introduction,
  rewardScreen1,
  assessment_vocabRoutine,
  instructions_distributedLearning,
  video_distributedLearning,
  assessment_motivation,
  outcome,
  obstacle,
  copingPlan,
  assessment_ToB,
  instructions_implementationIntentions,
  video_Planning,
  planCreation,
  planInternalisationEmoji,
  planTiming,
  instructions_cabuu_1,
  instructions_cabuu_2,
}

class OnboardingViewModel extends MultiPageViewModel {
  InternalisationViewModel internalisationViewmodelEmoji =
      InternalisationViewModel();

  late OnboardingQuestionnaireViewModel questionnaireVocabRoutine =
      OnboardingQuestionnaireViewModel(
    questionnaire: OB_VocabRoutine,
  );

  late OnboardingQuestionnaireViewModel questionnaireMotivation =
      OnboardingQuestionnaireViewModel(
    questionnaire: OB_Motivation,
  );

  late OnboardingQuestionnaireViewModel questionnaireToB =
      OnboardingQuestionnaireViewModel(
    questionnaire: OB_ToB,
  );

  List<QuestionnaireResponse> _questionnaireResponses = [];

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
  final DataService _dataService;

  OnboardingViewModel(
      this._experimentService, this._dataService, this._rewardService) {
    generateScreenOrder();
  }

  void generateScreenOrder() {
    pages = getScreenOrder();
  }

  Future<bool> getInitialValues() async {
    var plan = await _dataService.getLastPlan();
    if (plan != null) {
      this.plan = plan;
    }

    var ud = _dataService.getUserDataCache();
    // TODO: Restore after testing
    // initialPage = max(ud.initStep, pages.length - 1);
    initialPage = 0;
    cabuuCode = ud.cabuuCode;

    return true;
  }

  List<OnboardingStep> getScreenOrder() {
    return OnboardingStep.values.toList();
  }

  int getNextSubQuestionnairePage(OnboardingQuestionnaireViewModel vm) {
    if (vm.page < vm.pages.length - 1) {
      vm.nextPage();
      return page;
    }
    return page + 1;
  }

  int getPreviousSubQuestionnairePage(OnboardingQuestionnaireViewModel vm) {
    if (vm.page > 0) {
      vm.previousPage();
      return page;
    }
    return page - 1;
  }

  @override
  int getNextPage() {
    var currentPage = pages[page];

    // Multi page questionnaires need special handling because they themselves consist of multiple pages
    if (currentPage == OnboardingStep.assessment_vocabRoutine) {
      return getNextSubQuestionnairePage(questionnaireVocabRoutine);
    }
    if (currentPage == OnboardingStep.assessment_motivation) {
      return getNextSubQuestionnairePage(questionnaireMotivation);
    }
    if (currentPage == OnboardingStep.assessment_ToB) {
      return getNextSubQuestionnairePage(questionnaireToB);
    }

    return super.getNextPage();
  }

  @override
  int getPreviousPage() {
    var currentPage = pages[page];

    // Multi page questionnaires need special handling because they themselves consist of multiple pages
    if (currentPage == OnboardingStep.assessment_vocabRoutine) {
      return getPreviousSubQuestionnairePage(questionnaireVocabRoutine);
    }
    if (currentPage == OnboardingStep.assessment_motivation) {
      return getPreviousSubQuestionnairePage(questionnaireMotivation);
    }
    if (currentPage == OnboardingStep.assessment_ToB) {
      return getPreviousSubQuestionnairePage(questionnaireToB);
    }
    return super.getPreviousPage();
  }

  saveInternalisation() {
    var response = QuestionnaireResponse(
        name: InternalisationCondition.emojiIf.name,
        questionnaireName: "internalisation",
        questionText: internalisationViewmodelEmoji.plan,
        response: internalisationViewmodelEmoji.input,
        dateSubmitted: DateTime.now());
    _dataService.saveQuestionnaireResponse(response);
  }

  Future<bool> doStepDependentSubmission(ValueKey currentPageKey) async {
    var stepKey = currentPageKey.value as OnboardingStep;

    switch (stepKey) {
      case OnboardingStep.welcome:
      case OnboardingStep.video_Planning:
      case OnboardingStep.video_distributedLearning:
      case OnboardingStep.instructions_cabuu_1:
      case OnboardingStep.instructions_cabuu_2:
      case OnboardingStep.instructions_distributedLearning:
      case OnboardingStep.instructions_implementationIntentions:
      case OnboardingStep.rewardScreen1:
        break;
      case OnboardingStep.video_introduction:
        if (_rewardService.scoreValue < 5) {
          _rewardService.addPoints(5);
        }
        break;
      case OnboardingStep.assessment_vocabRoutine:
      case OnboardingStep.assessment_ToB:
      case OnboardingStep.assessment_motivation:
      case OnboardingStep.planTiming:
        break;
      case OnboardingStep.planCreation:
        var planResponse = QuestionnaireResponse(
            name: AssessmentTypes.plan,
            questionnaireName: AssessmentTypes.plan,
            questionText: "",
            response: vocabValue,
            dateSubmitted: DateTime.now());
        _dataService.saveQuestionnaireResponse(planResponse);
        break;
      case OnboardingStep.planInternalisationEmoji:
        saveInternalisation();
        if (_rewardService.scoreValue < 10) {
          _rewardService.addPoints(20);
        }
        break;
      case OnboardingStep.outcome:
        var outcomeResponse = QuestionnaireResponse(
            name: "outcome",
            questionnaireName: "outcome",
            questionText: "",
            response: outcome,
            dateSubmitted: DateTime.now());
        _dataService.saveQuestionnaireResponse(outcomeResponse);
        break;
      case OnboardingStep.obstacle:
        var obstacleResponse = QuestionnaireResponse(
            name: "obstacle",
            questionnaireName: "obstacle",
            questionText: "",
            response: obstacle,
            dateSubmitted: DateTime.now());
        _dataService.saveQuestionnaireResponse(obstacleResponse);
        break;
      case OnboardingStep.copingPlan:
        var copingPlanResponse = QuestionnaireResponse(
            name: "copingPlan",
            questionnaireName: "copingPlan",
            questionText: "",
            response: copingPlan,
            dateSubmitted: DateTime.now());
        _dataService.saveQuestionnaireResponse(copingPlanResponse);
        break;
    }

    return true;
  }

  int getStepIndex(OnboardingStep step) {
    return pages.indexOf(step);
  }

  @override
  bool canMoveBack() {
    var stepKey = pages[page];

    return true;
    switch (stepKey) {
      case OnboardingStep.rewardScreen1:
      case OnboardingStep.instructions_cabuu_2:
      case OnboardingStep.video_introduction:
      case OnboardingStep.welcome:
      case OnboardingStep.instructions_cabuu_1:
      case OnboardingStep.assessment_vocabRoutine:
      case OnboardingStep.assessment_ToB:
      case OnboardingStep.assessment_motivation:
      case OnboardingStep.video_Planning:
      case OnboardingStep.video_distributedLearning:
      case OnboardingStep.planCreation:
      case OnboardingStep.planInternalisationEmoji:
      case OnboardingStep.planTiming:
      case OnboardingStep.instructions_distributedLearning:
      case OnboardingStep.instructions_implementationIntentions:
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
  bool canMoveNext() {
    var stepKey = pages[page]; //currentPageKey!.value as SessionZeroStep;
    return true;
    switch (stepKey) {
      case OnboardingStep.video_introduction:
        return _videoWelcomeCompleted;
      case OnboardingStep.welcome:
        return true;
      case OnboardingStep.assessment_vocabRoutine:
      case OnboardingStep.assessment_ToB:
      case OnboardingStep.assessment_motivation:
        return true;
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

  saveQuestionnaireResponse(
      String questionnaireName, String itemName, String response) {
    // check if there is already a response for this questionnaire and item id
    var existingResponse = _questionnaireResponses.firstWhereOrNull((element) =>
        element.questionnaireName == questionnaireName &&
        element.name == itemName);

    if (existingResponse != null) {
      _questionnaireResponses.remove(existingResponse);
    }
    var newResponse = QuestionnaireResponse(
        questionnaireName: questionnaireName,
        name: itemName,
        questionText: "",
        response: response,
        dateSubmitted: DateTime.now());

    _questionnaireResponses.add(newResponse);

    notifyListeners();
  }

  @override
  void submit() async {
    if (state == ViewState.idle) {
      setState(ViewState.busy);
      // TODO: Submit responses
      // await _experimentService.submitResponses(
      //     questionnaireResponses, SESSION_ZERO);

      _experimentService.nextScreen();
    }
  }
}
