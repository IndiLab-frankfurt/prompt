import 'package:prompt/models/questionnaire_response.dart';
import 'package:prompt/viewmodels/base_view_model.dart';
import 'package:prompt/viewmodels/completable_page.dart';

typedef void OnAnsweredCallback(QuestionnaireResponse value);

class QuestionnairePageViewModel extends BaseViewModel
    with CompletablePageMixin {
  OnAnsweredCallback? onAnswered;
  QuestionnaireResponse? response;

  QuestionnairePageViewModel(
      {required String name, bool completed = false, this.onAnswered}) {
    this.completed = completed;
    this.name = name;
  }
}
