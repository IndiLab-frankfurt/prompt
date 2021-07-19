import 'package:prompt/models/assessment.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:prompt/services/experiment_service.dart';
import 'package:prompt/shared/route_names.dart';
import 'package:prompt/viewmodels/base_view_model.dart';
import 'package:prompt/viewmodels/multi_step_assessment_view_model.dart';

enum SessionZeroStep { welcome, cabuuLink }

const List<SessionZeroStep> ScreenOrder = [
  SessionZeroStep.welcome,
  SessionZeroStep.cabuuLink
];

class SessionZeroViewModel extends MultiStepAssessmentViewModel {
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

  final ExperimentService _experimentService;

  SessionZeroViewModel(this._experimentService);

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
  Future<Assessment> getAssessment(assessmentType) {
    // TODO: implement getAssessment
    throw UnimplementedError();
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
