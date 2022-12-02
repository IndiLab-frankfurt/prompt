import 'package:prompt/shared/enums.dart';

class Question {
  String questionText;
  Map<String, String> labels;
  String id;
  bool includeOther = false;
  QuestionType type = QuestionType.single;

  Question(
      {required this.questionText,
      required this.labels,
      required this.id,
      this.includeOther = false,
      this.type = QuestionType.single});
}
