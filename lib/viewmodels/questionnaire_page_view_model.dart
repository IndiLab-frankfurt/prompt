import 'package:prompt/models/questionnaire_response.dart';
import 'package:prompt/viewmodels/base_view_model.dart';

typedef void OnAnsweredCallback(QuestionnaireResponse value);

abstract class QuestionnairePageViewModel extends BaseViewModel {
  final String name;
  bool completed = false;
  OnAnsweredCallback? onAnswered;
  QuestionnaireResponse? response;
  QuestionnairePageViewModel(this.name);
}
