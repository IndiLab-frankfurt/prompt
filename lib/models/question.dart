import 'package:prompt/shared/enums.dart';

class Question {
  String questionText;
  Map<String, String> labels;
  String id;
  QuestionType type = QuestionType.single;

  Question(
      {required this.questionText,
      required this.labels,
      required this.id,
      this.type = QuestionType.single});
}
