import 'package:flutter/foundation.dart';
import 'package:prompt/models/assessment.dart';
import 'package:prompt/services/data_service.dart';
import 'package:prompt/services/experiment_service.dart';
import 'package:prompt/shared/route_names.dart';
import 'package:prompt/viewmodels/internalisation_view_model.dart';
import 'package:prompt/viewmodels/multi_step_assessment_view_model.dart';

enum SessionZeroStep {
  welcome,
  cabuuLink,
  mascotSelection,
  motivationQuestionnaire,
  goalIntention,
  videoPlanning,
  planCreation,
  planDisplay,
  planInternalisation,
  selfEfficacy,
  videoInstructionComplete
}

const List<SessionZeroStep> ScreenOrder = [
  SessionZeroStep.welcome,
  SessionZeroStep.cabuuLink,
  SessionZeroStep.mascotSelection,
  SessionZeroStep.motivationQuestionnaire,
  SessionZeroStep.goalIntention,
  SessionZeroStep.videoPlanning,
  SessionZeroStep.planCreation,
  SessionZeroStep.planDisplay,
  SessionZeroStep.planInternalisation,
  SessionZeroStep.selfEfficacy,
  SessionZeroStep.videoInstructionComplete
];

class SessionZeroViewModel extends MultiStepAssessmentViewModel {
  InternalisationViewModel internalisationViewmodel =
      InternalisationViewModel();

  String _selectedMascot = "1";
  String get selectedMascot => _selectedMascot;
  set selectedMascot(String selected) {
    this._selectedMascot = selected;
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

  SessionZeroViewModel(this._experimentService, this._dataService);

  @override
  bool canMoveBack(ValueKey currentPageKey) {
    // TODO: implement canMoveBack
    return true;
  }

  @override
  bool canMoveNext(ValueKey currentPageKey) {
    // TODO: implement canMoveNext
    return true;
  }

  @override
  Future<Assessment> getAssessment(assessmentType) async {
    String name = describeEnum(assessmentType);
    Assessment assessment = await _dataService.getAssessment(name);

    return assessment;
  }

  @override
  int getNextPage(ValueKey currentPageKey) {
    // TODO: implement getNextPage
    return step + 1;
  }

  @override
  void submit() {
    _experimentService.nextScreen(RouteNames.SESSION_ZERO);
  }
}
