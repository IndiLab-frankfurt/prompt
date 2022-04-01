import 'package:prompt/models/question.dart';
import 'package:prompt/models/questionnaire.dart';
import 'package:prompt/shared/enums.dart';

late var sociodemographicQuestions = Questionnaire(
    id: "sociodemographic",
    title: "Sociodemographische Fragen",
    items: [
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
