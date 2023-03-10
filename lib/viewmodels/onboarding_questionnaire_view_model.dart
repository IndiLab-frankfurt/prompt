import 'package:prompt/models/questionnaire.dart';
import 'package:prompt/models/questionnaire_response.dart';
import 'package:prompt/viewmodels/multi_page_view_model.dart';

class OnboardingQuestionnaireViewModel extends MultiPageViewModel {
  final Questionnaire questionnaire;

  OnboardingQuestionnaireViewModel({
    required this.questionnaire,
  }) {
    pages = questionnaire.questions.toList();
    pages.forEach((element) {
      element.onAnswered = onAnswered;
    });
  }

  void onAnswered(QuestionnaireResponse response) {
    this.notifyListeners();
  }

  @override
  bool canMoveBack() {
    return true;
  }

  @override
  bool canMoveNext() {
    return true;
  }

  @override
  void submit() {}
}
