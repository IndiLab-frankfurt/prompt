import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/foundation.dart';
import 'package:prompt/data/questions.dart';
import 'package:prompt/models/assessment_result.dart';
import 'package:prompt/models/internalisation.dart';
import 'package:prompt/services/data_service.dart';
import 'package:prompt/services/experiment_service.dart';
import 'package:prompt/services/reward_service.dart';
import 'package:prompt/shared/enums.dart';
import 'package:prompt/shared/route_names.dart';
import 'package:prompt/viewmodels/internalisation_view_model.dart';
import 'package:prompt/viewmodels/multi_step_assessment_view_model.dart';
import 'package:prompt/viewmodels/plan_view_model.dart';

enum SessionZeroStep {
  welcome,
  whoAreYou,
  video_introduction,
  questions_sociodemographics,
  questions_vocablearning,
  questions_usability,
  reward_screen,
  video_distributedLearning,
  introduction_planning,
  video_planning,
  planCreation,
  planDisplay,
  planInternalisationWaiting,
  planInternalisationEmoji,
  permissionRequest
}

typedef RewardCallback = void Function(int);

class SessionZeroViewModel extends MultiStepAssessmentViewModel {
  static List<SessionZeroStep> getScreenOrder(int group) {
    List<SessionZeroStep> screenOrder = [
      SessionZeroStep.welcome,
      SessionZeroStep.whoAreYou,
      SessionZeroStep.video_introduction,
      SessionZeroStep.questions_sociodemographics,
      SessionZeroStep.introduction_planning,
      SessionZeroStep.video_planning,
      SessionZeroStep.planCreation,
      SessionZeroStep.reward_screen,
      SessionZeroStep.planDisplay,
      SessionZeroStep.planInternalisationWaiting,
      SessionZeroStep.planInternalisationEmoji,
    ];

    return screenOrder;
  }

// ignore: non_constant_identifier_names
  List<SessionZeroStep> screenOrder = [];
  InternalisationViewModel internalisationViewmodelEmoji =
      InternalisationViewModel.withCondition(InternalisationCondition.emojiIf);
  InternalisationViewModel internalisationViewmodelWaiting =
      InternalisationViewModel.withCondition(InternalisationCondition.waiting);
  PlanViewModel planCreationViewModel = PlanViewModel();
  List<String> submittedResults = [];
  RewardCallback? onRewardCallback;

  Duration waitingDuration = Duration(seconds: 1);

  String _selectedMascot = "1";
  String get selectedMascot => _selectedMascot;
  set selectedMascot(String selected) {
    this._selectedMascot = selected;
    _dataService.setSelectedMascot(selected);
    _rewardService.changeMascot(selected);
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
  set outcome(String value) {
    _outcome = value;
    notifyListeners();
  }

  String _obstacle = "";
  String get obstacle => _obstacle;
  set obstacle(String value) {
    _obstacle = value;
    notifyListeners();
  }

  String _copingPlan = "";
  String get copingPlan => _copingPlan;
  set copingPlan(String value) {
    _copingPlan = value;
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

  void onPlanCreationCompleted(String result) {
    internalisationViewmodelEmoji.plan = result;
    internalisationViewmodelWaiting.plan = result;
    notifyListeners();
  }

  void onPermissionRequest() {
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
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
      planCreationViewModel.plan = plan.plan;
      internalisationViewmodelEmoji.plan = plan.plan;
      internalisationViewmodelWaiting.plan = plan.plan;
    }

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

  void submitAssessmentResult(assessmentName) {
    if (!allAssessmentResults.containsKey(assessmentName)) {
      return;
    }
    var assessmentResult = AssessmentResult(
        allAssessmentResults[assessmentName]!, assessmentName, DateTime.now());
    assessmentResult.startDate = this.startDate;
    _dataService.saveAssessment(assessmentResult);
    submittedResults.add(assessmentName);
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
        plan: this.planCreationViewModel.plan,
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
        break;
      case SessionZeroStep.video_distributedLearning:
        break;
      case SessionZeroStep.planInternalisationWaiting:
        break;
      case SessionZeroStep.planDisplay:
        break;
      case SessionZeroStep.video_introduction:
        break;
      case SessionZeroStep.planCreation:
        _dataService.savePlan(planCreationViewModel.plan);
        if (_rewardService.scoreValue == 0) {
          _rewardService.addPoints(20);
        }
        break;
      case SessionZeroStep.planInternalisationEmoji:
        saveInternalisation();
        break;
      case SessionZeroStep.whoAreYou:
        _dataService.saveUserDataProperty("role", role);
        break;
      case SessionZeroStep.questions_sociodemographics:
        submitAssessmentResult(sociodemographicQuestions.id);
        break;
      case SessionZeroStep.questions_vocablearning:
        submitAssessmentResult(vocabQuestions.id);
        break;
      case SessionZeroStep.questions_usability:
        break;
      case SessionZeroStep.reward_screen:
        break;
      case SessionZeroStep.introduction_planning:
        break;
      case SessionZeroStep.permissionRequest:
        onPermissionRequest();
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
      case SessionZeroStep.video_planning:
      case SessionZeroStep.video_distributedLearning:
      case SessionZeroStep.planCreation:
      case SessionZeroStep.planInternalisationEmoji:
      case SessionZeroStep.planInternalisationWaiting:
      case SessionZeroStep.questions_sociodemographics:
      case SessionZeroStep.questions_vocablearning:
      case SessionZeroStep.questions_usability:
      case SessionZeroStep.reward_screen:
      case SessionZeroStep.introduction_planning:
      case SessionZeroStep.permissionRequest:
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
        return true;
      case SessionZeroStep.video_planning:
        return _videoPlanningCompleted;
      case SessionZeroStep.video_distributedLearning:
        return _videoDistributedLearningCompleted;
      case SessionZeroStep.planCreation:
        return planCreationViewModel.plan.isNotEmpty;
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

      await _experimentService.onSessionZeroComplete();

      _experimentService.nextScreen(RouteNames.SESSION_ZERO);
    }
  }
}
