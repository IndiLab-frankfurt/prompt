import 'package:prompt/models/questionnaire.dart';
import 'package:prompt/viewmodels/multi_page_view_model.dart';

class OnboardingQuestionnaireViewModel extends MultiPageViewModel {
  final Questionnaire questionnaire;

  OnboardingQuestionnaireViewModel({
    required this.questionnaire,
  }) {
    pages = questionnaire.questions.toList();
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
