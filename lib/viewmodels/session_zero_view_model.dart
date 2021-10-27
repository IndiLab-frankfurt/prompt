import 'dart:io';
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

enum SessionZeroStep {
  welcome,
  rewardScreen1,
  whereCanYouFindThisInformation,
  cabuuCode,
  mascotSelection,
  assessment_planCommitment,
  assessment_itLiteracy,
  assessment_learningFrequencyDuration,
  assessment_motivation,
  assessment_learningExpectations,
  assessment_distributedLearning,
  assessment_selfEfficacy,
  valueIntervention,
  videoPlanning,
  videoDistributedLearning,
  planCreation,
  planDisplay,
  planInternalisationWaiting,
  planInternalisationEmoji,
  planTiming,
  instructions1,
  instructions2,
  instructions3,
  instructions4,
  instructions_cabuu_1,
  instructions_cabuu_2,
  instructions_cabuu_3,
  instructions_distributedLearning,
  instructions_implementationIntentions,
  instructions_appPermissions,
  rewardScreen2,
  endOfSession
}

class SessionZeroViewModel extends MultiStepAssessmentViewModel {
// ignore: non_constant_identifier_names
  List<SessionZeroStep> screenOrder = [];
  InternalisationViewModel internalisationViewmodelEmoji =
      InternalisationViewModel();
  InternalisationViewModel internalisationViewmodelWaiting =
      InternalisationViewModel();
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
    plan = "Wenn ich $plan, dann lerne ich mit cabuu";
    this._plan = plan;
    internalisationViewmodelEmoji.plan = plan;
    internalisationViewmodelWaiting.plan = plan;
    notifyListeners();
  }

  String cabuuCode = "123";

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

    var ud = _dataService.getUserDataCache();
    initialStep = ud.initSessionStep;
    cabuuCode = ud.cabuuCode;

    return true;
  }

  static List<SessionZeroStep> getScreenOrder(int group) {
    List<SessionZeroStep> screenOrder = [];

    List<SessionZeroStep> firstScreens = [
      SessionZeroStep.welcome,
      SessionZeroStep.whereCanYouFindThisInformation,
      SessionZeroStep.rewardScreen1,
      SessionZeroStep.instructions1,
      SessionZeroStep.instructions2,
      SessionZeroStep.instructions3,
      SessionZeroStep.instructions4,
      SessionZeroStep.assessment_itLiteracy,
      SessionZeroStep.assessment_learningFrequencyDuration,
      SessionZeroStep.assessment_motivation,
      SessionZeroStep.assessment_distributedLearning,
      SessionZeroStep.valueIntervention,
      SessionZeroStep.instructions_cabuu_1,
      SessionZeroStep.instructions_cabuu_2,
      SessionZeroStep.instructions_cabuu_3,
      SessionZeroStep.assessment_learningExpectations,
    ];

    List<SessionZeroStep> distributedLearning = [
      SessionZeroStep.instructions_distributedLearning,
      SessionZeroStep.videoDistributedLearning,
      SessionZeroStep.assessment_distributedLearning,
    ];

    List<SessionZeroStep> finalSteps = [
      // SessionZeroStep.selfEfficacy,
      SessionZeroStep.endOfSession,
      SessionZeroStep.rewardScreen2,
    ];

    List<SessionZeroStep> internalisationSteps = [
      SessionZeroStep.instructions_implementationIntentions,
      SessionZeroStep.videoPlanning,
      SessionZeroStep.planCreation,
      SessionZeroStep.planDisplay,
      SessionZeroStep.assessment_planCommitment,
      SessionZeroStep.planInternalisationWaiting,
      SessionZeroStep.planInternalisationEmoji,
      SessionZeroStep.planTiming,
    ];

    if (group == 1) {
      screenOrder = [...firstScreens, ...finalSteps];
    } else if (group == 2 || group == 3) {
      screenOrder = [...firstScreens, ...distributedLearning, ...finalSteps];
    } else if (group == 5 || group == 6 || group == 4) {
      screenOrder = [
        ...firstScreens,
        ...distributedLearning,
        ...internalisationSteps,
        ...finalSteps
      ];
    } else if (group == 7) {
      screenOrder = [...firstScreens, ...distributedLearning, ...finalSteps];
    } else {
      throw Exception(
          "Attempting to request data for a group that does not exist ");
    }

    if (Platform.isAndroid) {
      screenOrder.add(SessionZeroStep.instructions_appPermissions);
    }

    // screenOrder.removeRange(0, firstStep);

    return screenOrder;
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
    return step;
  }

  saveInternalisation() async {
    var internalisation = Internalisation(
        startDate: DateTime.now(),
        completionDate: DateTime.now(),
        plan: this.plan,
        condition: InternalisationCondition.emojiIf.toString(),
        input: this.internalisationViewmodelEmoji.input);
    await _dataService.saveInternalisation(internalisation);
  }

  void doStepDependentSubmission(ValueKey currentPageKey) {
    var stepKey = currentPageKey.value as SessionZeroStep;

    switch (stepKey) {
      case SessionZeroStep.welcome:
      case SessionZeroStep.cabuuCode:
      case SessionZeroStep.videoPlanning:
      case SessionZeroStep.videoDistributedLearning:
      case SessionZeroStep.instructions1:
      case SessionZeroStep.instructions2:
      case SessionZeroStep.instructions3:
      case SessionZeroStep.instructions4:
      case SessionZeroStep.instructions_cabuu_1:
      case SessionZeroStep.instructions_cabuu_2:
      case SessionZeroStep.instructions_cabuu_3:
      case SessionZeroStep.instructions_distributedLearning:
      case SessionZeroStep.instructions_appPermissions:
      case SessionZeroStep.instructions_implementationIntentions:
      case SessionZeroStep.rewardScreen1:
      case SessionZeroStep.planInternalisationWaiting:
      case SessionZeroStep.planDisplay:
        break;
      case SessionZeroStep.whereCanYouFindThisInformation:
        _rewardService.addPoints(5);
        break;
      case SessionZeroStep.mascotSelection:
        _dataService.setSelectedMascot(selectedMascot);
        break;
      case SessionZeroStep.assessment_planCommitment:
      case SessionZeroStep.assessment_itLiteracy:
      case SessionZeroStep.assessment_learningFrequencyDuration:
      case SessionZeroStep.assessment_motivation:
      case SessionZeroStep.assessment_learningExpectations:
      case SessionZeroStep.assessment_distributedLearning:
      case SessionZeroStep.assessment_selfEfficacy:
      case SessionZeroStep.planTiming:
        checkIfAssessmentNeedsSubmission();
        break;
      case SessionZeroStep.valueIntervention:
        _dataService.saveVocabValue(vocabValue);
        break;
      case SessionZeroStep.planCreation:
        _dataService.savePlan(plan);
        break;
      case SessionZeroStep.planInternalisationEmoji:
        saveInternalisation();
        break;
      case SessionZeroStep.endOfSession:
        _rewardService.addPoints(5);
        break;
      case SessionZeroStep.rewardScreen2:
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
      case SessionZeroStep.rewardScreen1:
      case SessionZeroStep.instructions_cabuu_2:
      case SessionZeroStep.instructions_cabuu_3:
      case SessionZeroStep.instructions2:
      case SessionZeroStep.instructions3:
      case SessionZeroStep.whereCanYouFindThisInformation:
        return true;
      case SessionZeroStep.cabuuCode:
      case SessionZeroStep.welcome:
      case SessionZeroStep.instructions_cabuu_1:
      case SessionZeroStep.mascotSelection:
      case SessionZeroStep.assessment_planCommitment:
      case SessionZeroStep.assessment_itLiteracy:
      case SessionZeroStep.assessment_learningFrequencyDuration:
      case SessionZeroStep.assessment_motivation:
      case SessionZeroStep.assessment_learningExpectations:
      case SessionZeroStep.assessment_selfEfficacy:
      case SessionZeroStep.assessment_distributedLearning:
      case SessionZeroStep.videoPlanning:
      case SessionZeroStep.videoDistributedLearning:
      case SessionZeroStep.planCreation:
      case SessionZeroStep.planDisplay:
      case SessionZeroStep.planInternalisationEmoji:
      case SessionZeroStep.planTiming:
      case SessionZeroStep.instructions1:
      case SessionZeroStep.instructions4:
      case SessionZeroStep.instructions_distributedLearning:
      case SessionZeroStep.instructions_implementationIntentions:
      case SessionZeroStep.instructions_appPermissions:
      case SessionZeroStep.endOfSession:
      case SessionZeroStep.valueIntervention:
      case SessionZeroStep.planInternalisationWaiting:
      case SessionZeroStep.rewardScreen2:
        return false;
    }
  }

  @override
  bool canMoveNext(ValueKey currentPageKey) {
    var stepKey = currentPageKey.value as SessionZeroStep;

    switch (stepKey) {
      case SessionZeroStep.whereCanYouFindThisInformation:
        return _videoWelcomeCompleted;
      case SessionZeroStep.welcome:
      case SessionZeroStep.cabuuCode:
      case SessionZeroStep.planDisplay:
      case SessionZeroStep.mascotSelection:
        return true;
      case SessionZeroStep.assessment_planCommitment:
      case SessionZeroStep.assessment_itLiteracy:
      case SessionZeroStep.assessment_learningFrequencyDuration:
      case SessionZeroStep.assessment_motivation:
      case SessionZeroStep.assessment_learningExpectations:
      case SessionZeroStep.assessment_selfEfficacy:
      case SessionZeroStep.assessment_distributedLearning:
        return currentAssessmentIsFilledOut;
      case SessionZeroStep.valueIntervention:
        return vocabValue.isNotEmpty;
      case SessionZeroStep.videoPlanning:
        return _videoPlanningCompleted;
      case SessionZeroStep.videoDistributedLearning:
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
    Map<String, String> results = {};
    for (var result in allAssessmentResults.values) {
      results.addAll(result);
    }

    var oneBigAssessment =
        AssessmentResult(results, SESSION_ZERO, DateTime.now());
    oneBigAssessment.startDate = this.startDate;

    _experimentService.submitAssessment(oneBigAssessment, SESSION_ZERO);

    _experimentService.nextScreen(RouteNames.SESSION_ZERO);
  }
}
