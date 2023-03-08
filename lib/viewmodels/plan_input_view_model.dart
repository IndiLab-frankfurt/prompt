import 'package:prompt/models/questionnaire_response.dart';
import 'package:prompt/viewmodels/questionnaire_page_view_model.dart';

class PlanInputViewModel extends QuestionnairePageViewModel {
  String plan = "Wenn ich lernen will, dann konzentriere ich mich";

  String _input = "";
  String get input => _input;
  set input(String userinput) {
    _input = userinput;
    this.plan = "Wenn ich $userinput, dann lerne ich mit cabuu!";
    if (input.length > 3) {
      completed = true;
      response = QuestionnaireResponse(
          name: name,
          questionnaireName: "PlanInput",
          questionText: name,
          response: input,
          dateSubmitted: DateTime.now().toLocal());
      this.onAnswered?.call(response!);
    } else {
      completed = false;
    }
  }

  PlanInputViewModel() : super("PlanInput");
}
