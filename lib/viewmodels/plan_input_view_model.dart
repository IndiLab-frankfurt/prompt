import 'package:prompt/models/questionnaire_response.dart';
import 'package:prompt/viewmodels/questionnaire_page_view_model.dart';

class PlanInputViewModel extends QuestionnairePageViewModel {
  String _input = "";
  String get input => _input;
  set input(String userinput) {
    _input = userinput;
    if (input.length > 3) {
      completed = true;
      response = QuestionnaireResponse(
          name: name,
          questionnaireName: name,
          questionText: name,
          response: input,
          dateSubmitted: DateTime.now().toLocal());
      this.onAnswered?.call(response!);
      notifyListeners();
    } else {
      completed = false;
    }
  }

  PlanInputViewModel({required name, OnAnsweredCallback? onAnswered})
      : super(name: name, onAnswered: onAnswered);
}
