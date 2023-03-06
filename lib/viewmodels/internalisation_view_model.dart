import 'package:prompt/shared/enums.dart';
import 'package:prompt/viewmodels/questionnaire_page_view_model.dart';

class InternalisationViewModel extends QuestionnairePageViewModel {
  String plan = "Wenn ich lernen will, dann konzentriere ich mich";

  final InternalisationCondition condition;

  bool completed = false;

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
  }
}
