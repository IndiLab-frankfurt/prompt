import 'package:prompt/models/question.dart';
import 'package:prompt/models/questionnaire.dart';
import 'package:prompt/shared/enums.dart';

late var sociodemographicQuestions =
    Questionnaire(id: "sociodemographic", title: "Angaben zu dir", items: [
  Question(
      id: "age",
      type: QuestionType.text_numeric,
      questionText: "Wie alt bist du?",
      labels: {}),
  Question(
      id: "gender",
      type: QuestionType.single,
      questionText: "Ich bin...",
      labels: {"boy": "Junge", "girl": "Mädchen", "other": "Weder noch"})
]);

late var vocabQuestions = Questionnaire(
    id: "vocab_questions",
    title: "Fragen zum Vokabellernen",
    items: [
      Question(
          id: "how_often_vocab",
          type: QuestionType.single,
          questionText: "Wie oft lernst du Vobakeln?",
          labels: {
            "1": "(fast) jeden Tag",
            "2": "4-6 mal pro Woche",
            "3": "1-3 mal pro Woche",
            "4": "weniger als 1 Tag pro Woche",
          }),
      Question(
          id: "which_languages_vocab",
          type: QuestionType.multiple,
          questionText: "Für welche Sprache(n) lernst du Vokabeln?",
          labels: {
            "english": "Englisch",
            "french": "Französisch",
            "spanish": "Spanisch",
            "dutch": "Niederländisch",
            "turkish": "Türkisch",
            "italian": "Italienisch",
            "other": "Andere"
          }),
      Question(
          id: "vocab_stratagies",
          type: QuestionType.multiple,
          questionText: "Welche der folgenden Aussagen trifft auf dich zu?",
          labels: {
            "how_often":
                "Ich habe ein genaues Ziel, wie oft ich Vokabeln lernen will",
            "when": "Ich habe einen genauen Plan, wann ich Vokabeln lerne",
            "where": "Ich habe einen genauen Plan, wann ich Vokabeln lerne",
          })
    ]);

late var vocabQuestionGoal =
    Questionnaire(id: "vocab_goal", title: "Setze dir ein Ziel!", items: [
  Question(
      id: "vocab_goal",
      type: QuestionType.single,
      questionText: "Wie oft willst du Vokabeln lernen",
      labels: {
        "1": "1-2 mal pro Woche",
        "2": "3-4 mal pro Woche",
        "3": "5-6 mal pro Woche",
      }),
]);

late var learningTipQuestions =
    Questionnaire(id: "learning_tip_feedback", title: "", items: [
  Question(
      id: "tip_new",
      type: QuestionType.single,
      questionText: "War der Tipp neu für dich?",
      labels: {
        "1": "Ja",
        "2": "Nein",
      }),
  Question(
      id: "tip_already_follow",
      type: QuestionType.single,
      questionText: "Befolgst du den Tipp bereits beim Lernen?",
      labels: {
        "1": "Ja",
        "2": "Nein",
      }),
  Question(
      id: "tip_good_bad",
      type: QuestionType.single,
      questionText: "Glaubst du, der Tipp ist...",
      labels: {
        "1": "...gut",
        "2": "...schlecht",
      }),
  Question(
      id: "tip_thoroughly_read",
      type: QuestionType.single,
      questionText: "Hast du dir den Tipp richtig durchgelesen?",
      labels: {
        "1": "Ja",
        "2": "Nein",
      }),
]);

late var usabilityQuestions =
    Questionnaire(id: "usability_questions", title: "", items: [
  Question(
      id: "usability_1",
      type: QuestionType.single,
      questionText: "App gut?",
      labels: {
        "1": "Ja",
        "2": "Nein",
      }),
]);
