import 'package:flutter/material.dart';

abstract class QuestionnairePage {
  final String name;
  QuestionnairePage(this.name);
}

class QuestionnaireText extends QuestionnairePage {
  final List<String> text;

  QuestionnaireText({required this.text, required String name}) : super(name);
}

class WidgetDisplayPage extends QuestionnairePage {
  final Widget widget;

  WidgetDisplayPage({required this.widget, required String name}) : super(name);
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
