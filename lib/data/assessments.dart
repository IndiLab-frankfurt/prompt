// ignore_for_file: non_constant_identifier_names

import 'package:prompt/models/question.dart';
import 'package:prompt/models/questionnaire.dart';
import 'package:prompt/shared/enums.dart';

Map<String, String> CHOICES_APPLIES = {
  "does_fully_not_apply": "Trifft gar nicht auf mich zu",
  "does_barely_not_apply": "Trifft kaum auf mich zu",
  "does_rather_not_apply": "Trifft eher nicht auf mich zu",
  "neutral": "Teils / teils",
  "barely_applies": "Trifft eher auf mich zu",
  "rather_applies": "Trifft deutlich auf mich zu",
  "fully_applies": "Trifft voll und ganz auf mich zu",
};

Map<String, String> CHOICES_GOODBAD = {
  "very_good": "Sehr gut",
  "good": "Gut",
  "neutral": "Neutral",
  "bad": "Schlecht",
  "very_bad": "Sehr schlecht",
};

Map<String, String> CHOICES_PLEASANT = {
  "very_pleasant": "Sehr angenehm",
  "pleasant": "Angenehm",
  "neutral": "Neutral",
  "unpleasant": "Unangenehm",
  "very_unpleasant": "Sehr unangenehm",
};

Map<String, String> CHOICES_AGREE = {
  "strongly_agree": "Stimme voll und ganz zu",
  "agree": "Stimme zu",
  "neutral": "Neutral",
  "disagree": "Stimme nicht zu",
  "strongly_disagree": "Stimme überhaupt nicht zu",
};

Map<String, String> CHOICES_LIKELY = {
  "very_likely": "Sehr wahrscheinlich",
  "likely": "Wahrscheinlich",
  "neutral": "Neutral",
  "unlikely": "Unwahrscheinlich",
  "very_unlikely": "Sehr unwahrscheinlich",
};

Map<String, String> CHOICES_RIGHTWRONG = {
  "very_right": "Sehr richtig",
  "right": "Richtig",
  "neutral": "Neutral",
  "wrong": "Falsch",
  "very_wrong": "Sehr falsch",
};

Map<String, String> CHOICES_YESNO = {
  "Yes": "Ja",
  "No": "Nein",
};

Map<String, String> CHOICES_IMPORTANCE = {
  "very_important": "Sehr wichtig",
  "important": "Wichtig",
  "neutral": "Neutral",
  "unimportant": "Unwichtig",
  "very_unimportant": "Sehr unwichtig",
};

Questionnaire AA_DidYouLearn = Questionnaire(
    title: "Hast du heute mit cabuu Vokabeln gelernt?",
    name: AppScreen.AA_DidYouLearn.name,
    questions: [
      ChoiceQuestion(
          choices: CHOICES_YESNO,
          name: "AA_DidYouLearn_1",
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
        choices: CHOICES_LIKELY,
        name: "${AppScreen.AA_NextStudySession.name}_expectation",
      ),
      ChoiceQuestion(
          questionText: "Wie wichtig ist es dir, morgen Vokabeln zu lernen?",
          choices: CHOICES_IMPORTANCE,
          name: "${AppScreen.AA_NextStudySession.name}_importance"),
    ]);

Questionnaire OB_VocabRoutine = Questionnaire(
    title:
        "Wie lernst du Vokabeln? Gib an, wie sehr die Aussagen auf dich zutreffen",
    name: "OB_VocabRoutine",
    questions: [
      ChoiceQuestion(
          name: "OB_VocabRoutine_1",
          questionText: "Wie gefällt dir die Vokabel-App cabuu?",
          choices: {
            "very_good": "Sehr gut",
            "good": "Gut",
            "neutral": "Mittel",
            "bad": "Schlecht",
            "very_bad": "Sehr schlecht",
            "not_tried_yet": "Ich habe cabuu noch nicht ausprobiert"
          }),
      ChoiceQuestion(
          name: "OB_VocabRoutine_2",
          questionText:
              "Ich habe eine feste Routine dafür, wann ich Vokabeln lerne.",
          choices: CHOICES_APPLIES),
      ChoiceQuestion(
          name: "OB_VocabRoutine_3",
          questionText:
              "Ich entscheide meistens spontan, wann ich Vokabeln lerne.",
          choices: CHOICES_APPLIES),
      ChoiceQuestion(
          name: "OB_VocabRoutine_4",
          questionText:
              "Obwohl ich weiß, dass ich Vokabeln lernen sollte, schiebe ich es oft lange vor mir her.",
          choices: CHOICES_APPLIES),
      ChoiceQuestion(
          name: "OB_VocabRoutine_5",
          questionText:
              "Wie oft lernst du normalerweise Englischvokabeln, wenn kein Test ansteht?",
          choices: {
            "less_once_per_week": "Weniger als 1 Tag pro Woche",
            "1_2_days_per_week": "1-2 Tage pro Woche",
            "3_4_days_per_week": "3-4 Tage pro Woche",
            "5_6_days_per_week": "5-6 Tage pro Woche",
            "every_day": "Jeden Tag",
          }),
      ChoiceQuestion(
          name: "OB_VocabRoutine_6",
          questionText:
              "Wie oft lernst du normalerweise Englischvokabeln, wenn ein Test angekündigt ist?",
          choices: {
            "less_once_per_week": "Weniger als 1 Tag pro Woche",
            "1_2_days_per_week": "1-2 Tage pro Woche",
            "3_4_days_per_week": "3-4 Tage pro Woche",
            "5_6_days_per_week": "5-6 Tage pro Woche",
            "every_day": "Jeden Tag",
          }),
    ]);

Questionnaire OB_Motivation = Questionnaire(
    title: "Gib an, wie sehr die Aussagen auf dich zutreffen",
    name: "OB_Motivation",
    questions: [
      ChoiceQuestion(
          name: "OB_Motivation_1",
          questionText:
              "Ich lerne Vokabeln, weil ich Freude daran habe, neue Wörter zu lernen.",
          choices: CHOICES_APPLIES),
      ChoiceQuestion(
          name: "OB_Motivation_2",
          questionText:
              "Ich lerne Vokabeln, weil ich jemand bin, der gut Englisch sprechen kann.",
          choices: CHOICES_APPLIES),
      ChoiceQuestion(
          name: "OB_Motivation_3",
          questionText:
              "Ich lerne Vokabeln, weil ich sonst ein schlechtes Gewissen hätte.",
          choices: CHOICES_APPLIES),
      ChoiceQuestion(
          name: "OB_Motivation_4",
          questionText:
              "Ich lerne Vokabeln, weil ich gute Noten bekommen möchte",
          choices: CHOICES_APPLIES),
      ChoiceQuestion(
          name: "OB_Motivation_4",
          questionText:
              "Ich lerne Vokabeln, obwohl ich nicht wirklich weiß, wozu überhaupt.",
          choices: CHOICES_APPLIES),
    ]);

Questionnaire OB_ToB = Questionnaire(
    title: "Gib an, wie sehr die Aussagen auf dich zutreffen",
    name: "OB_ToB",
    questions: [
      ChoiceQuestion(
          name: "OB_ToB_1",
          questionText:
              "Wenn ich möglichst oft Vokabeln lernen würde, wäre das...",
          choices: CHOICES_GOODBAD),
      ChoiceQuestion(
          name: "OB_ToB_2",
          questionText:
              "Wenn ich möglichst oft Vokabeln lernen würde, wäre das...",
          choices: CHOICES_PLEASANT),
      ChoiceQuestion(
          name: "OB_ToB_3",
          questionText:
              "Meine Eltern, Freunde, Lehrer denken, dass ich möglichst oft Vokabeln lernen sollte.",
          choices: CHOICES_AGREE),
      ChoiceQuestion(
          name: "OB_ToB_4",
          questionText: "Die meisten Kinder lernen möglichst oft Vokabeln.",
          choices: CHOICES_LIKELY),
      ChoiceQuestion(
          name: "OB_ToB_5",
          questionText:
              "Ich bin sicher, dass ich möglichst oft Vokabeln lernen kann.",
          choices: CHOICES_RIGHTWRONG),
      ChoiceQuestion(
          name: "OB_ToB_6",
          questionText: "Es liegt an mir, wie ich Vokabeln lerne.",
          choices: CHOICES_AGREE),
      ChoiceQuestion(
          name: "OB_ToB_7",
          questionText: "Ich habe vor, möglichst oft Vokabeln zu lernen.",
          choices: CHOICES_LIKELY),
    ]);

Questionnaire RememberToLearn =
    Questionnaire(title: "", name: AppScreen.RememberToLearn.name, questions: [
  QuestionnaireText(
      name: "${AppScreen.RememberToLearn.name}_1",
      text: ["## Denk daran, morgen Vokabeln zu lernen! "])
]);

Questionnaire ReminderTestToday = Questionnaire(
    title: "",
    name: AppScreen.ReminderTestToday.name,
    questions: [
      QuestionnaireText(name: "${AppScreen.ReminderTestToday.name}_1", text: [
        '### Bitte mache heute noch den Test in cabuu!',
        '### Drücke dazu auf die Liste und wähle "Abfrage".',
        '### Fange dann ab morgen mit der nächsten Liste an.'
      ])
    ]);

Questionnaire ReminderNextList =
    Questionnaire(title: "", name: AppScreen.ReminderNextList.name, questions: [
  QuestionnaireText(name: "${AppScreen.ReminderNextList.name}_1", text: [
    '### Prima!',
    '### Fange ab morgen an, die nächste Liste in cabuu zu lernen.',
    '### Du hast wieder 20 Tage Zeit bis zum nächsten Test.'
  ])
]);
