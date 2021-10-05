import 'package:flutter/foundation.dart';
import 'package:prompt/locator.dart';
import 'package:prompt/models/assessment_result.dart';
import 'package:prompt/services/data_service.dart';
import 'package:prompt/services/experiment_service.dart';
import 'package:prompt/services/reward_service.dart';
import 'package:prompt/shared/enums.dart';
import 'package:prompt/shared/route_names.dart';
import 'package:prompt/viewmodels/internalisation_view_model.dart';
import 'package:prompt/viewmodels/multi_step_assessment_view_model.dart';

enum SessionZeroStep {
  welcome,
  whereCanYouFindThisInformation,
  cabuuCode,
  cabuuLink,
  mascotSelection,
  moderatorVariables,
  assessment_planCommitment,
  assessment_itLiteracy,
  assessment_learningFrequencyDuration,
  assessment_motivation,
  assessment_learningExpectations,
  assessment_distributedLearning,
  valueIntervention,
  goalIntention,
  videoPlanning,
  videoDistributedLearning,
  planCreation,
  planDisplay,
  planInternalisation,
  planTiming,
  selfEfficacy,
  videoInstructionComplete,
  instructions1,
  instructions2,
  instructions3,
  instructions4,
  instructions_cabuu_1,
  instructions_cabuu_2,
  instructions_cabuu_3,
  instructions_distributedLearning,
  instructions_implementationIntentions
}

class SessionZeroViewModel extends MultiStepAssessmentViewModel {
// ignore: non_constant_identifier_names
  List<SessionZeroStep> screenOrder = [];
  InternalisationViewModel internalisationViewmodel =
      InternalisationViewModel();

  String _selectedMascot = "1";
  String get selectedMascot => _selectedMascot;
  set selectedMascot(String selected) {
    this._selectedMascot = selected;
    _dataService.setSelectedMascot(selected);
    _rewardService.selectedMascot = selected;
    notifyListeners();
  }

  String _plan = "";
  String get plan => _plan;
  set plan(String plan) {
    plan = "Wenn ich $plan, dann lerne ich mit cabuu";
    this._plan = plan;
    internalisationViewmodel.plan = plan;
    notifyListeners();
  }

  bool _consented = false;
  bool get consented => _consented;
  set consented(bool consented) {
    _consented = consented;
    notifyListeners();
  }

  String _cabuuLinkUserName = "";
  String get cabuuLinkUserName => _cabuuLinkUserName;
  set cabuuLinkUserName(String cabuuLinkUserName) {
    _cabuuLinkUserName = cabuuLinkUserName;
    notifyListeners();
  }

  String _cabuuLinkEmail = "";
  String get cabuuLinkEmail => _cabuuLinkEmail;
  set cabuuLinkEmail(String cabuuLinkEmail) {
    _cabuuLinkEmail = cabuuLinkEmail;
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

  final ExperimentService _experimentService;
  final DataService _dataService;
  final RewardService _rewardService;

  SessionZeroViewModel(
      this._experimentService, this._dataService, this._rewardService)
      : super(_dataService) {
    getScreenOrder();
  }

  Future<void> getScreenOrder() async {
    var ud = await _dataService.getUserData();
    var group = ud!.group;

    screenOrder = generateScreenOrder(group, ud.initSessionStep);
    notifyListeners();
  }

  List<SessionZeroStep> generateScreenOrder(int group, int firstStep) {
    List<SessionZeroStep> screenOrder = [];

    List<SessionZeroStep> firstScreens = [
      SessionZeroStep.welcome,
      SessionZeroStep.whereCanYouFindThisInformation,
      SessionZeroStep.mascotSelection,
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

    List<SessionZeroStep> goalIntention = [SessionZeroStep.goalIntention];

    List<SessionZeroStep> finalSteps = [
      SessionZeroStep.selfEfficacy,
      SessionZeroStep.videoInstructionComplete
    ];

    List<SessionZeroStep> internalisationSteps = [
      SessionZeroStep.instructions_implementationIntentions,
      SessionZeroStep.videoPlanning,
      SessionZeroStep.planCreation,
      SessionZeroStep.planDisplay,
      SessionZeroStep.assessment_planCommitment,
      SessionZeroStep.planInternalisation,
      SessionZeroStep.planTiming,
    ];

    if (group == 1) {
      screenOrder = [...firstScreens, ...goalIntention, ...finalSteps];
    } else if (group == 2 || group == 3 || group == 4) {
      screenOrder = [
        ...firstScreens,
        ...distributedLearning,
        ...goalIntention,
        ...finalSteps
      ];
    } else if (group == 5 || group == 6) {
      screenOrder = [
        ...firstScreens,
        ...distributedLearning,
        ...goalIntention,
        ...internalisationSteps,
        ...finalSteps
      ];
    } else {
      throw Exception(
          "Attempting to request data for a group that does not exist");
    }

    screenOrder.removeRange(0, firstStep);

    return screenOrder;
  }

  @override
  onPageChange() {
    this._dataService.saveSessionZeroStep(step);
    // TODO: Submit results so far
    super.onPageChange();
  }

  @override
  int getNextPage(ValueKey currentPageKey) {
    step += 1;
    return step;
  }

  int getStepIndex(SessionZeroStep step) {
    return screenOrder.indexOf(step);
  }

  @override
  bool canMoveBack(ValueKey currentPageKey) {
    return true;
  }

  @override
  bool canMoveNext(ValueKey currentPageKey) {
    var stepKey = currentPageKey.value as SessionZeroStep;

    switch (stepKey) {
      case SessionZeroStep.welcome:
        return true;
      case SessionZeroStep.whereCanYouFindThisInformation:
        // TODO: Handle this case.
        break;
      case SessionZeroStep.cabuuCode:
        // TODO: Handle this case.
        break;
      case SessionZeroStep.cabuuLink:
        return true;
      case SessionZeroStep.mascotSelection:
        // TODO: Handle this case.
        break;
      case SessionZeroStep.moderatorVariables:
        return true;
      case SessionZeroStep.assessment_planCommitment:
      case SessionZeroStep.assessment_itLiteracy:
      case SessionZeroStep.assessment_learningFrequencyDuration:
      case SessionZeroStep.assessment_motivation:
      case SessionZeroStep.assessment_learningExpectations:
      case SessionZeroStep.selfEfficacy:
      case SessionZeroStep.assessment_distributedLearning:
        return currentAssessmentIsFilledOut;
      case SessionZeroStep.valueIntervention:
        // TODO: Handle this case.
        break;
      case SessionZeroStep.goalIntention:
        // TODO: Handle this case.
        break;
      case SessionZeroStep.videoPlanning:
        // TODO: Handle this case.
        break;
      case SessionZeroStep.videoDistributedLearning:
        // TODO: Handle this case.
        break;
      case SessionZeroStep.planCreation:
        return plan.isNotEmpty;
      case SessionZeroStep.planDisplay:
        // TODO: Handle this case.
        break;
      case SessionZeroStep.planInternalisation:
        // TODO: Handle this case.
        break;
      case SessionZeroStep.planTiming:
        // TODO: Handle this case.
        break;
      case SessionZeroStep.videoInstructionComplete:
        // TODO: Handle this case.
        break;
      default:
        return true;
    }

    return true;
  }

  @override
  void submit() async {
    dataService.setSelectedMascot(selectedMascot);
    dataService.savePlan(plan);

    Map<String, String> results = {};
    for (var result in allAssessmentResults.values) {
      results.addAll(result);
    }

    // TODO: Save all assessment items
    var oneBigAssessment =
        AssessmentResult(results, SESSION_ZERO, DateTime.now());
    oneBigAssessment.startDate = this.startDate;

    _experimentService.submitAssessment(oneBigAssessment, SESSION_ZERO);

    _experimentService.nextScreen(RouteNames.SESSION_ZERO);
  }
}
