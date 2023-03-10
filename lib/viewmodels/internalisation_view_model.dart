import 'package:prompt/models/questionnaire_response.dart';
import 'package:prompt/shared/enums.dart';
import 'package:prompt/viewmodels/questionnaire_page_view_model.dart';

class InternalisationViewModel extends QuestionnairePageViewModel {
  String _plan = "Wenn ich lernen will, dann konzentriere ich mich";

  String get plan => _plan;

  set plan(String newPlan) {
    _plan = "Wenn ich $newPlan, dann lerne ich mit cabuu!";
    notifyListeners();
  }

  final InternalisationCondition condition;

  String input = "";

  DateTime startDate = DateTime.now();

  InternalisationViewModel({name, required this.condition}) : super(name: name);

  String getIfPart() {
    return "${plan.split("dann")[0]}...";
  }

  String getThenPart() {
    return " ... dann ${plan.split("dann")[1]}";
  }

  void onScrambleCorrection(String text) {}

  void onComplete(String input) {
    completed = true;
    this.input = input;
    response = QuestionnaireResponse(
        name: condition.name,
        questionnaireName: name,
        questionText: name,
        response: input,
        dateSubmitted: DateTime.now().toLocal());
    this.onAnswered?.call(response!);
    notifyListeners();
  }
}
