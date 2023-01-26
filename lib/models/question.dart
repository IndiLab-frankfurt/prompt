abstract class Question {
  final String name;
  final String questionText;

  Question(this.name, this.questionText);
}

class ChoiceQuestion extends Question {
  final bool singleChoice;
  final Map<String, String> choices;

  ChoiceQuestion(
      {required this.choices,
      required String name,
      required String questionText,
      this.singleChoice = true})
      : super(name, questionText);
}
