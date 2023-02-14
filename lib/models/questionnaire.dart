import 'package:prompt/models/question.dart';

class Questionnaire {
  final String title;
  final String name;
  final List<QuestionnairePage> questions;

  Questionnaire(
      {required this.title, required this.name, required this.questions});
}
