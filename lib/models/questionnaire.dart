import 'package:prompt/models/question.dart';

class Questionnaire {
  final String title;
  final String name;
  final List<Question> questions;

  Questionnaire(
      {required this.title, required this.name, required this.questions});
}
