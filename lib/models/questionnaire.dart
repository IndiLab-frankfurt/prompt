import 'package:prompt/viewmodels/questionnaire_page_view_model.dart';

class Questionnaire {
  final String title;
  final String name;
  final List<QuestionnairePageViewModel> questions;
  final List<dynamic>? rules;

  Questionnaire(
      {required this.title,
      required this.name,
      required this.questions,
      this.rules});
}
