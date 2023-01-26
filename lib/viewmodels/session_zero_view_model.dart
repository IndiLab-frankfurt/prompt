import 'package:flutter/foundation.dart';
import 'package:prompt/models/internalisation.dart';
import 'package:prompt/models/questionnaire_response.dart';
import 'package:prompt/services/data_service.dart';
import 'package:prompt/services/study_service.dart';
import 'package:prompt/services/reward_service.dart';
import 'package:prompt/shared/enums.dart';
import 'package:prompt/shared/route_names.dart';
import 'package:prompt/viewmodels/internalisation_view_model.dart';
import 'package:prompt/viewmodels/multi_page_view_model.dart';

enum SessionZeroStep {
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

class SessionZeroViewModel extends MultiPageViewModel {
  InternalisationViewModel internalisationViewmodelEmoji =
      InternalisationViewModel();
  InternalisationViewModel internalisationViewmodelWaiting =
      InternalisationViewModel();
  List<String> submittedResults = [];

  String _selectedMascot = "1";
  String get selectedMascot => _selectedMascot;
  set selectedMascot(String selected) {
    this._selectedMascot = selected;
    dataService.setSelectedMascot(selected);
    _rewardService.changeMascot(selected);
    notifyListeners();
  }

  String _plan = "";
  String get plan => _plan;
  set plan(String plan) {
    plan = "Wenn ich $plan, dann lerne ich mit cabuu!";
    this._plan = plan;
    internalisationViewmodelEmoji.plan = plan;
    internalisationViewmodelWaiting.plan = plan;
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

  SessionZeroViewModel(
      this._experimentService, DataService dataService, this._rewardService)
      : super(dataService) {
    generateScreenOrder();
  }

  void generateScreenOrder() {
    var ud = dataService.getUserDataCache();
    var group = ud.group;

    pages = getScreenOrder(group);
  }

  Future<bool> getInitialValues() async {
    var plan = await dataService.getLastPlan();
    if (plan != null) {
      this.plan = plan;
    }

    var ud = dataService.getUserDataCache();
    initialPage = ud.initStep;
    cabuuCode = ud.cabuuCode;

    return true;
  }

  List<SessionZeroStep> getScreenOrder(String group) {
    List<SessionZeroStep> screenOrder = [
      SessionZeroStep.welcome,
      SessionZeroStep.video_introduction,
      SessionZeroStep.rewardScreen1,
      SessionZeroStep.outcome,
      SessionZeroStep.obstacle,
      SessionZeroStep.copingPlan,
      SessionZeroStep.instructions_implementationIntentions,
      SessionZeroStep.video_Planning,
      SessionZeroStep.planCreation,
      SessionZeroStep.planDisplay,
      SessionZeroStep.planInternalisationEmoji,
      SessionZeroStep.rewardScreen2,
      SessionZeroStep.planTiming,
      // SessionZeroStep.instructions_cabuu_1,
      // SessionZeroStep.instructions_cabuu_2,
      // SessionZeroStep.instructions_cabuu_3,
      // SessionZeroStep.assessment_learningExpectations,
      // SessionZeroStep.endOfSession,
    ];

    return screenOrder;
  }

  @override
  onPageChange() {
    this.dataService.saveSessionZeroStep(page);

    super.onPageChange();
  }

  @override
  int getNextPage(ValueKey currentPageKey) {
    page += 1;

    var end = (page < pages.length - 1) ? pages[page].toString() : "complete";
    addTiming(currentPageKey.value.toString(), end);
    return page;
  }

  saveInternalisation() {
    var internalisation = Internalisation(
        startDate: DateTime.now(),
        completionDate: DateTime.now(),
        plan: this.plan,
        condition: InternalisationCondition.emojiIf.toString(),
        input: this.internalisationViewmodelEmoji.input);
    dataService.saveInternalisation(internalisation);
  }

  @override
  Future<bool> doStepDependentSubmission(ValueKey currentPageKey) async {
    var stepKey = currentPageKey.value as SessionZeroStep;

    switch (stepKey) {
      case SessionZeroStep.welcome:
      case SessionZeroStep.cabuuCode:
      case SessionZeroStep.video_Planning:
      case SessionZeroStep.video_distributedLearning:
      case SessionZeroStep.instructions1:
      case SessionZeroStep.instructions2:
      case SessionZeroStep.instructions3:
      case SessionZeroStep.instructions4:
      case SessionZeroStep.instructions_cabuu_1:
      case SessionZeroStep.instructions_cabuu_2:
      case SessionZeroStep.instructions_cabuu_3:
      case SessionZeroStep.instructions_distributedLearning:
      case SessionZeroStep.instructions_implementationIntentions:
      case SessionZeroStep.rewardScreen1:
      case SessionZeroStep.planInternalisationWaiting:
      case SessionZeroStep.rewardScreen2:
      case SessionZeroStep.planDisplay:
        break;
      case SessionZeroStep.video_introduction:
        if (_rewardService.scoreValue < 5) {
          _rewardService.addPoints(5);
        }
        break;
      case SessionZeroStep.assessment_itLiteracy:
      case SessionZeroStep.assessment_learningFrequencyDuration:
      case SessionZeroStep.assessment_motivation:
      case SessionZeroStep.assessment_learningExpectations:
      case SessionZeroStep.assessment_distributedLearning:
      case SessionZeroStep.assessment_selfEfficacy:
      case SessionZeroStep.planTiming:
        break;
      case SessionZeroStep.whyLearnVocabScreen:
        var vocabValueResponse = QuestionnaireResponse(
            name: "vocabValue",
            questionnaireName: "vocabvalue",
            questionText: "",
            response: vocabValue,
            dateSubmitted: DateTime.now());
        dataService.saveQuestionnaireResponse(vocabValueResponse);
        break;
      case SessionZeroStep.planCreation:
        var planResponse = QuestionnaireResponse(
            name: AssessmentTypes.plan,
            questionnaireName: AssessmentTypes.plan,
            questionText: "",
            response: vocabValue,
            dateSubmitted: DateTime.now());
        dataService.saveQuestionnaireResponse(planResponse);
        break;
      case SessionZeroStep.planInternalisationEmoji:
        saveInternalisation();
        if (_rewardService.scoreValue < 10) {
          _rewardService.addPoints(20);
        }

        break;
      case SessionZeroStep.endOfSession:
        break;
      case SessionZeroStep.outcome:
        var outcomeResponse = QuestionnaireResponse(
            name: "outcome",
            questionnaireName: "outcome",
            questionText: "",
            response: outcome,
            dateSubmitted: DateTime.now());
        dataService.saveQuestionnaireResponse(outcomeResponse);
        break;
      case SessionZeroStep.obstacle:
        var obstacleResponse = QuestionnaireResponse(
            name: "obstacle",
            questionnaireName: "obstacle",
            questionText: "",
            response: obstacle,
            dateSubmitted: DateTime.now());
        dataService.saveQuestionnaireResponse(obstacleResponse);
        break;
      case SessionZeroStep.copingPlan:
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

  int getStepIndex(SessionZeroStep step) {
    return pages.indexOf(step);
  }

  @override
  bool canMoveBack(ValueKey currentPageKey) {
    var stepKey = currentPageKey.value as SessionZeroStep;
    return true;
    switch (stepKey) {
      case SessionZeroStep.rewardScreen1:
      case SessionZeroStep.instructions_cabuu_2:
      case SessionZeroStep.instructions_cabuu_3:
      case SessionZeroStep.instructions2:
      case SessionZeroStep.instructions3:
      case SessionZeroStep.video_introduction:
      case SessionZeroStep.planDisplay:
      case SessionZeroStep.cabuuCode:
      case SessionZeroStep.welcome:
      case SessionZeroStep.instructions_cabuu_1:
      case SessionZeroStep.assessment_itLiteracy:
      case SessionZeroStep.assessment_learningFrequencyDuration:
      case SessionZeroStep.assessment_motivation:
      case SessionZeroStep.assessment_learningExpectations:
      case SessionZeroStep.assessment_selfEfficacy:
      case SessionZeroStep.assessment_distributedLearning:
      case SessionZeroStep.video_Planning:
      case SessionZeroStep.video_distributedLearning:
      case SessionZeroStep.planCreation:
      case SessionZeroStep.planInternalisationEmoji:
      case SessionZeroStep.planTiming:
      case SessionZeroStep.instructions1:
      case SessionZeroStep.instructions4:
      case SessionZeroStep.instructions_distributedLearning:
      case SessionZeroStep.instructions_implementationIntentions:
      case SessionZeroStep.endOfSession:
      case SessionZeroStep.whyLearnVocabScreen:
      case SessionZeroStep.planInternalisationWaiting:
      case SessionZeroStep.rewardScreen2:
        return false;
      case SessionZeroStep.outcome:
        return outcome.isNotEmpty;
      case SessionZeroStep.obstacle:
        return obstacle.isNotEmpty;
      case SessionZeroStep.copingPlan:
        return copingPlan.isNotEmpty;
    }
  }

  @override
  bool canMoveNext(ValueKey currentPageKey) {
    var stepKey = currentPageKey.value as SessionZeroStep;
    return true;
    switch (stepKey) {
      case SessionZeroStep.video_introduction:
        return _videoWelcomeCompleted;
      case SessionZeroStep.welcome:
      case SessionZeroStep.cabuuCode:
      case SessionZeroStep.planDisplay:
        return true;
      case SessionZeroStep.assessment_itLiteracy:
      case SessionZeroStep.assessment_learningFrequencyDuration:
      case SessionZeroStep.assessment_motivation:
      case SessionZeroStep.assessment_learningExpectations:
      case SessionZeroStep.assessment_selfEfficacy:
      case SessionZeroStep.assessment_distributedLearning:
        return currentAssessmentIsFilledOut;
      case SessionZeroStep.whyLearnVocabScreen:
        return vocabValue.isNotEmpty;
      case SessionZeroStep.video_Planning:
        return _videoPlanningCompleted;
      case SessionZeroStep.video_distributedLearning:
        return _videoDistributedLearningCompleted;
      case SessionZeroStep.planCreation:
        return plan.isNotEmpty;
      case SessionZeroStep.planInternalisationEmoji:
        return this.internalisationViewmodelEmoji.input.isNotEmpty;
      case SessionZeroStep.planInternalisationWaiting:
        return this.internalisationViewmodelWaiting.completed;
      case SessionZeroStep.planTiming:
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

      _experimentService.nextScreen(RouteNames.SESSION_ZERO);
    }
  }
}
