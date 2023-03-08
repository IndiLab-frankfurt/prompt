import 'package:prompt/models/questionnaire_response.dart';
import 'package:prompt/shared/enums.dart';
import 'package:prompt/viewmodels/questionnaire_page_view_model.dart';

class InternalisationViewModel extends QuestionnairePageViewModel {
  String plan = "Wenn ich lernen will, dann konzentriere ich mich";

  final InternalisationCondition condition;

  String input = "";

  DateTime startDate = DateTime.now();

  InternalisationViewModel({required this.condition}) : super(condition.name);

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
  }
}
