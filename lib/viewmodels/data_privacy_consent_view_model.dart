import 'package:prompt/viewmodels/questionnaire_page_view_model.dart';

class DataPrivacyConsentViewModel extends QuestionnairePageViewModel {
  DataPrivacyConsentViewModel({required name}) : super(name: name) {
    completed = false;
  }

  bool _consented = false;
  bool get consented => _consented;
  set consented(bool consented) {
    _consented = consented;
    completed = consented;
    notifyListeners();
  }
}
