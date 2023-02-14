abstract class QuestionnairePage {
  final String name;
  QuestionnairePage(this.name);
}

class QuestionInfoPage extends QuestionnairePage {
  final List<String> infoText;

  QuestionInfoPage({required this.infoText, required String name})
      : super(name);
}

class ChoiceQuestion extends QuestionnairePage {
  final bool singleChoice;
  final Map<String, String> choices;
  final String questionText;
  List<String> selectedChoices = [];

  ChoiceQuestion(
      {required this.choices,
      required String name,
      required this.questionText,
      this.singleChoice = true})
      : super(name);
}
