import 'package:prompt/models/questionnaire.dart';
import 'package:prompt/models/questionnaire_response.dart';
import 'package:prompt/services/study_service.dart';
import 'package:prompt/shared/enums.dart';
import 'package:prompt/viewmodels/completable_page.dart';
import 'package:prompt/viewmodels/multi_page_view_model.dart';

class MultiPageQuestionnaireViewModel extends MultiPageViewModel
    with CompletablePageMixin {
  final Questionnaire questionnaire;

  final StudyService studyService;

  MultiPageQuestionnaireViewModel({
    required String name,
    required this.questionnaire,
    required this.studyService,
  }) {
    this.name = name;
    pages = questionnaire.questions.toList();
    questionnaire.questions.forEach((element) {
      element.completed = false;
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
    return pages[page].completed;
  }

  @override
  void submit() async {
    this.setState(ViewState.busy);
    await this.studyService.submitResponses(
        QuestionnaireResponse.fromQuestionnaire(this.questionnaire));
    this.studyService.nextScreen();
    this.setState(ViewState.idle);
  }
}
