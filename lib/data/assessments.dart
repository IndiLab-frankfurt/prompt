// ignore_for_file: non_constant_identifier_names

import 'package:prompt/models/question.dart';
import 'package:prompt/models/questionnaire.dart';
import 'package:prompt/shared/enums.dart';

Questionnaire AA_DidYouLearn = Questionnaire(
    title: "Hast du heute mit cabuu Vokabeln gelernt?",
    name: AppScreen.AA_DidYouLearn.name,
    questions: [
      ChoiceQuestion(
          choices: {"Yes": "Ja", "No": "Nein"},
          name: "${AppScreen.AA_DidYouLearn.name}_1",
          questionText: "Hast du heute mit cabuu Vokabeln gelernt?"),
    ]);

Questionnaire AA_PreviousStudySession = Questionnaire(
    title: "Hast du heute mit cabuu Vokabeln gelernt?",
    name: AppScreen.AA_PreviousStudySession.name,
    questions: [
      ChoiceQuestion(
          choices: {
            "very_satisfied": "Sehr zufrieden",
            "Very unsatisfied": "Sehr unzufrieden"
          },
          name: "${AppScreen.AA_PreviousStudySession.name}_1",
          questionText:
              "Wie zufrieden bist du damit, wie du heute mit cabuu gelernt hast?"),
    ]);

Questionnaire AA_WhyNotLearn =
    Questionnaire(title: "", name: AppScreen.AA_WhyNotLearn.name, questions: [
  ChoiceQuestion(
      choices: {
        "forgot": "Ich habe vergessen, Vokabeln zu lernen",
        "procrastinated": "Ich habe das Lernen zu lange vor mir hergeschoben",
        "nomotivation": "Ich hatte keine Lust, Vokabeln zu lernen",
        "noTime": "Ich hatte keine Zeit, Vokabeln zu lernen",
        "learnedelsewhere": "Ich habe Vokabeln gelernt, aber nicht mit cabuu",
        "TEXTINPUT": "Sonstiges, nämlich"
      },
      name: AppScreen.AA_WhyNotLearn.name,
      questionText: "Warum hast du keine Vokabeln mit cabuu gelernt?"),
]);

Questionnaire AA_NextStudySession = Questionnaire(
    title: "",
    name: AppScreen.AA_NextStudySession.name,
    questions: [
      ChoiceQuestion(
        questionText:
            "Wie wahrscheinlich ist es, dass du morgen Vokabeln lernen wirst?",
        choices: {
          "very_unlikely": "Sehr unwahrscheinlich",
          "rather_unlikely": "Eher unwahrscheinlich",
          // TODO: Add "neutral" option
          "rather_likely": "Eher wahrscheinlich",
          "very_likely": "Sehr wahrscheinlich"
        },
        name: "${AppScreen.AA_NextStudySession.name}_expectation",
      ),
      ChoiceQuestion(
          questionText: "Wie wichtig ist es dir, morgen Vokabeln zu lernen?",
          choices: {
            "very_unimportant": "Überhaupt nicht wichtig",
            "rather_unimportant": "Eher unwichtig",
            // TODO: Add "neutral" option
            "rather_important": "Eher wichtig",
            "very_important": "Sehr wichtig"
          },
          name: "${AppScreen.AA_NextStudySession.name}_importance"),
    ]);

Questionnaire RememberToLearn =
    Questionnaire(title: "", name: AppScreen.RememberToLearn.name, questions: [
  QuestionnaireText(
      name: "${AppScreen.RememberToLearn.name}_1",
      text: ["## Denk daran, morgen Vokabeln zu lernen! "])
]);
