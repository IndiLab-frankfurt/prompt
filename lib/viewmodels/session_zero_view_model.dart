import 'package:flutter/foundation.dart';
import 'package:prompt/data/obstacles.dart';
import 'package:prompt/data/outcomes.dart';
import 'package:prompt/models/assessment_result.dart';
import 'package:prompt/models/internalisation.dart';
import 'package:prompt/services/data_service.dart';
import 'package:prompt/services/experiment_service.dart';
import 'package:prompt/services/reward_service.dart';
import 'package:prompt/shared/enums.dart';
import 'package:prompt/shared/route_names.dart';
import 'package:prompt/viewmodels/internalisation_view_model.dart';
import 'package:prompt/viewmodels/multi_step_assessment_view_model.dart';
import 'package:prompt/viewmodels/sortable_list_view_model.dart';

enum SessionZeroStep {
  welcome,
  whoAreYou,
  video_introduction,
  questions_sociodemographics,
  introduction_distributedLearning,
  video_distributedLearning,
  introduction_planning,
  video_planning,
  planCreation,
  planDisplay,
  planInternalisationWaiting,
  planInternalisationEmoji,
  obstacleList,
  outcomeEnter,
  obstacleEnter,
  copingPlanCreation,
  mascotSelection,
}

class SessionZeroViewModel extends MultiStepAssessmentViewModel {
  static List<SessionZeroStep> getScreenOrder(int group) {
    List<SessionZeroStep> screenOrder = [
      SessionZeroStep.outcomeEnter,
      SessionZeroStep.obstacleEnter,
      SessionZeroStep.welcome,
      SessionZeroStep.whoAreYou,
      SessionZeroStep.video_introduction,
      SessionZeroStep.questions_sociodemographics,
      SessionZeroStep.introduction_distributedLearning,
      SessionZeroStep.video_distributedLearning,
      SessionZeroStep.introduction_planning,
      SessionZeroStep.video_planning,
      SessionZeroStep.planCreation,
      SessionZeroStep.planDisplay,
      SessionZeroStep.planInternalisationWaiting,
      SessionZeroStep.planInternalisationEmoji,
    ];

    return screenOrder;
  }

// ignore: non_constant_identifier_names
  List<SessionZeroStep> screenOrder = [];
  InternalisationViewModel internalisationViewmodelEmoji =
      InternalisationViewModel();
  InternalisationViewModel internalisationViewmodelWaiting =
      InternalisationViewModel();
  SortableListViewModel outcomeSelectionViewModel =
      SortableListViewModel.withInitialItems(outcomes);
  SortableListViewModel obstacleSelectionViewModel =
      SortableListViewModel.withInitialItems(obstacles);
  List<String> submittedResults = [];

  String _selectedMascot = "1";
  String get selectedMascot => _selectedMascot;
  set selectedMascot(String selected) {
    this._selectedMascot = selected;
    _dataService.setSelectedMascot(selected);
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

  bool _consented = false;
  bool get consented => _consented;
  set consented(bool consented) {
    _consented = consented;
    notifyListeners();
  }

  String _role = "";
  String get role => _role;
  set role(String roleInput) {
    this._role = roleInput;
    notifyListeners();
  }

  String _outcome = "";
  String get outcome => _outcome;
  set outcome(String vocabValue) {
    _outcome = vocabValue;
    notifyListeners();
  }

  String _obstacle = "";
  String get obstacle => _outcome;
  set obstacle(String vocabValue) {
    _outcome = vocabValue;
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

  final ExperimentService _experimentService;
  final DataService _dataService;
  final RewardService _rewardService;

  SessionZeroViewModel(
      this._experimentService, this._dataService, this._rewardService)
      : super(_dataService) {
    generateScreenOrder();
  }

  void generateScreenOrder() {
    var ud = _dataService.getUserDataCache();
    var group = ud.group;

    screenOrder = getScreenOrder(group);

    notifyListeners();
  }

  Future<bool> getInitialValues() async {
    var plan = await _dataService.getLastPlan();
    if (plan != null) {
      this.plan = plan.plan;
    }

    // var ud = _dataService.getUserDataCache();
    // initialStep = ud.initSessionStep;

    return true;
  }

  @override
  onPageChange() {
    this._dataService.saveSessionZeroStep(step);

    super.onPageChange();
  }

  void checkIfAssessmentNeedsSubmission() {
    if (allAssessmentResults.length > 0) {
      var lastKey = allAssessmentResults.keys.last;
      if (!submittedResults.contains(lastKey)) {
        submitAssessmentResult(lastKey);
      }
    }
  }

  void submitAssessmentResult(key) {
    var assessmentResult =
        AssessmentResult(allAssessmentResults[key]!, key, DateTime.now());
    assessmentResult.startDate = this.startDate;
    _dataService.saveAssessment(assessmentResult);
    submittedResults.add(key);
  }

  @override
  int getNextPage(ValueKey currentPageKey) {
    doStepDependentSubmission(currentPageKey);
    step += 1;

    var end = (step < screenOrder.length - 1)
        ? screenOrder[step].toString()
        : "complete";
    addTiming(currentPageKey.value.toString(), end);
    return step;
  }

  saveInternalisation() {
    var internalisation = Internalisation(
        startDate: DateTime.now(),
        completionDate: DateTime.now(),
        plan: this.plan,
        condition: InternalisationCondition.emojiIf.toString(),
        input: this.internalisationViewmodelEmoji.input);
    _dataService.saveInternalisation(internalisation);
  }

  void doStepDependentSubmission(ValueKey currentPageKey) {
    var stepKey = currentPageKey.value as SessionZeroStep;

    switch (stepKey) {
      case SessionZeroStep.welcome:
        videoWelcomeCompleted();
        break;
      case SessionZeroStep.video_planning:
      case SessionZeroStep.video_distributedLearning:
      case SessionZeroStep.planInternalisationWaiting:
      case SessionZeroStep.planDisplay:
        break;
      case SessionZeroStep.mascotSelection:
        _dataService.setSelectedMascot(selectedMascot);
        break;
      case SessionZeroStep.planCreation:
        _dataService.savePlan(plan);
        break;
      case SessionZeroStep.planInternalisationEmoji:
        saveInternalisation();
        break;
      case SessionZeroStep.whoAreYou:
        _dataService.saveUserDataProperty("role", role);
        break;
      case SessionZeroStep.video_introduction:
        // TODO: Handle this case.
        break;
      case SessionZeroStep.questions_sociodemographics:
        // TODO: Handle this case.
        break;
      case SessionZeroStep.introduction_distributedLearning:
        // TODO: Handle this case.
        break;
      case SessionZeroStep.introduction_planning:
        // TODO: Handle this case.
        break;
      case SessionZeroStep.obstacleList:
        // TODO: Handle this case.
        break;
      case SessionZeroStep.copingPlanCreation:
        // TODO: Handle this case.
        break;
      case SessionZeroStep.outcomeEnter:
        // TODO: Handle this case.
        break;
      case SessionZeroStep.obstacleEnter:
        // TODO: Handle this case.
        break;
    }
  }

  int getStepIndex(SessionZeroStep step) {
    return screenOrder.indexOf(step);
  }

  @override
  bool canMoveBack(ValueKey currentPageKey) {
    var stepKey = currentPageKey.value as SessionZeroStep;

    switch (stepKey) {
      case SessionZeroStep.whoAreYou:
      case SessionZeroStep.planDisplay:
      case SessionZeroStep.video_introduction:
      case SessionZeroStep.welcome:
      case SessionZeroStep.mascotSelection:
      case SessionZeroStep.video_planning:
      case SessionZeroStep.video_distributedLearning:
      case SessionZeroStep.planCreation:
      case SessionZeroStep.planInternalisationEmoji:
      case SessionZeroStep.planInternalisationWaiting:
      case SessionZeroStep.questions_sociodemographics:
      case SessionZeroStep.introduction_distributedLearning:
      case SessionZeroStep.introduction_planning:
      case SessionZeroStep.obstacleList:
      case SessionZeroStep.copingPlanCreation:
      case SessionZeroStep.outcomeEnter:
      case SessionZeroStep.obstacleEnter:
        return true;
    }
  }

  @override
  bool canMoveNext(ValueKey currentPageKey) {
    return true;

    var stepKey = currentPageKey.value as SessionZeroStep;

    switch (stepKey) {
      case SessionZeroStep.welcome:
      case SessionZeroStep.planDisplay:
      case SessionZeroStep.mascotSelection:
        return true;
      case SessionZeroStep.video_planning:
        return _videoPlanningCompleted;
      case SessionZeroStep.video_distributedLearning:
        return _videoDistributedLearningCompleted;
      case SessionZeroStep.planCreation:
        return plan.isNotEmpty;
      case SessionZeroStep.planInternalisationEmoji:
        return this.internalisationViewmodelEmoji.input.isNotEmpty;
      case SessionZeroStep.planInternalisationWaiting:
        return this.internalisationViewmodelWaiting.completed;
      default:
        return true;
    }

    return true;
  }

  @override
  void submit() async {
    if (state == ViewState.idle) {
      setState(ViewState.busy);
      var oneBigAssessment = this.getOneBisAssessment(SESSION_ZERO);

      _experimentService.submitAssessment(oneBigAssessment, SESSION_ZERO);

      _experimentService.nextScreen(RouteNames.SESSION_ZERO);
    }
  }
}
