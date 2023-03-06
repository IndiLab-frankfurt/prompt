import 'package:prompt/viewmodels/questionnaire_page_view_model.dart';

class PlanInputViewModel extends QuestionnairePageViewModel {
  String plan = "Wenn ich lernen will, dann konzentriere ich mich";

  String input = "";

  PlanInputViewModel() : super("PlanInput");
}
