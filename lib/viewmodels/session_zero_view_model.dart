import 'package:flutter/foundation.dart';
import 'package:prompt/locator.dart';
import 'package:prompt/services/data_service.dart';
import 'package:prompt/services/experiment_service.dart';
import 'package:prompt/services/reward_service.dart';
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
  whyLearnVocabs,
  motivationQuestionnaire,
  goalIntention,
  videoPlanning,
  videoDistributedLearning,
  planCreation,
  planDisplay,
  planInternalisation,
  selfEfficacy,
  videoInstructionComplete
}

class SessionZeroViewModel extends MultiStepAssessmentViewModel {
// ignore: non_constant_identifier_names
  List<SessionZeroStep> screenOrder = [
    SessionZeroStep.welcome,
    SessionZeroStep.whereCanYouFindThisInformation,
    SessionZeroStep.cabuuCode,
    SessionZeroStep.cabuuLink,
    SessionZeroStep.mascotSelection,
    SessionZeroStep.moderatorVariables,
    SessionZeroStep.whyLearnVocabs,
    SessionZeroStep.motivationQuestionnaire,
    SessionZeroStep.goalIntention,
    SessionZeroStep.videoPlanning,
    // SessionZeroStep.videoDistributedLearning,
    SessionZeroStep.planCreation,
    SessionZeroStep.planDisplay,
    SessionZeroStep.planInternalisation,
    SessionZeroStep.selfEfficacy,
    SessionZeroStep.videoInstructionComplete
  ];
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

  String _plan = "Wenn ich nach Hause komme, esse ich eine Wurst";
  String get plan => _plan;
  set plan(String plan) {
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

    screenOrder = generateScreenOrder(group);
    notifyListeners();
  }

  List<SessionZeroStep> generateScreenOrder(int group) {
    List<SessionZeroStep> screenOrder = [];

    List<SessionZeroStep> firstScreens = [
      SessionZeroStep.welcome,
      SessionZeroStep.whereCanYouFindThisInformation,
      SessionZeroStep.cabuuCode,
      SessionZeroStep.cabuuLink,
      SessionZeroStep.mascotSelection,
      SessionZeroStep.moderatorVariables,
      SessionZeroStep.whyLearnVocabs,
      SessionZeroStep.motivationQuestionnaire,
    ];

    List<SessionZeroStep> distributedLearning = [
      SessionZeroStep.videoDistributedLearning,
      SessionZeroStep.goalIntention
    ];

    List<SessionZeroStep> finalSteps = [
      SessionZeroStep.videoInstructionComplete
    ];

    List<SessionZeroStep> internalisationSteps = [
      SessionZeroStep.videoPlanning,
      // SessionZeroStep.videoDistributedLearning,
      SessionZeroStep.planCreation,
      SessionZeroStep.planDisplay,
      SessionZeroStep.planInternalisation,
      SessionZeroStep.selfEfficacy,
    ];

    if (group == 1) {
      screenOrder = [...firstScreens, ...finalSteps];
    } else if (group == 2 || group == 3) {
      screenOrder = [...firstScreens, ...distributedLearning, ...finalSteps];
    } else if (group == 4 || group == 5 || group == 6) {
      screenOrder = [
        ...firstScreens,
        ...distributedLearning,
        ...internalisationSteps,
        ...finalSteps
      ];
    } else {
      throw Exception(
          "Attempting to request data for a group that does not exist");
    }

    return screenOrder;
  }

  @override
  bool canMoveBack(ValueKey currentPageKey) {
    return true;
  }

  @override
  bool canMoveNext(ValueKey currentPageKey) {
    return true;
  }

  @override
  void submit() {
    dataService.setSelectedMascot(selectedMascot);

    _experimentService.nextScreen(RouteNames.SESSION_ZERO);
  }
}
