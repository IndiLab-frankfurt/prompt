// ignore_for_file: non_constant_identifier_names

import 'package:intl/intl.dart';
import 'package:prompt/models/questionnaire.dart';
import 'package:prompt/shared/enums.dart';
import 'package:prompt/viewmodels/choice_question_view_model.dart';
import 'package:prompt/viewmodels/questionnaire_textpage_view_model.dart';

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
  "rather_good": "Eher gut",
  "neutral": "Neutral",
  "rather_bad": "Eher schlecht",
  "bad": "Schlecht",
  "very_bad": "Sehr schlecht",
};

Map<String, String> CHOICES_PLEASANT = {
  "very_pleasant": "Sehr angenehm",
  "pleasant": "Angenehm",
  "rather pleasant": "Eher angenehm",
  "neutral": "Neutral",
  "rather_unpleasant": "Eher unangenehm",
  "unpleasant": "Unangenehm",
  "very_unpleasant": "Sehr unangenehm",
};

Map<String, String> CHOICES_AGREE = {
  "strongly_agree": "Stimme voll und ganz zu",
  "agree": "Stimme zu",
  "rather_agree": "Stimme eher zu",
  "neutral": "Neutral",
  "rather_disagree": "Stimme eher nicht zu",
  "disagree": "Stimme nicht zu",
  "strongly_disagree": "Stimme überhaupt nicht zu",
};

Map<String, String> CHOICES_LIKELY = {
  "very_likely": "Sehr wahrscheinlich",
  "likely": "Wahrscheinlich",
  "rather_likely": "Eher wahrscheinlich",
  "neutral": "Neutral",
  "rather_unlikely": "Eher unwahrscheinlich",
  "unlikely": "Unwahrscheinlich",
  "very_unlikely": "Sehr unwahrscheinlich",
};

Map<String, String> CHOICES_RIGHTWRONG = {
  "very_right": "Sehr richtig",
  "right": "Richtig",
  "rather_right": "Eher richtig",
  "neutral": "Neutral",
  "rather_wrong": "Eher falsch",
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
  "rather_important": "Eher wichtig",
  "neutral": "Neutral",
  "rather_unimportant": "Eher unwichtig",
  "unimportant": "Unwichtig",
  "very_unimportant": "Sehr unwichtig",
};

Map<String, String> CHOICES_ANNOYING_ENJOYABLE = {
  "very_annoying": "Sehr nervig",
  "annoying": "Eher nervig",
  "slightly_annoying": "Teilweise nervig",
  "neutral": "Teils / teils",
  "slightly_enjoyable": "Teilweise angenehm",
  "rather_enjoyable": "Eher angenehm",
  "very_enjoyable": "Sehr angenehm",
};

Map<String, String> CHOICES_USELESS_HELPFUL = {
  "very_useless": "Sehr unnötig",
  "rather_useless": "Eher unnötig",
  "slightly_useless": "Teilweise unnötig",
  "neutral": "Teils / teils",
  "slightly_helpful": "Teilweise hilfreich",
  "rather_helpful": "Eher hilfreich",
  "very_helpful": "Sehr hilfreich",
};

Map<String, String> CHOICES_DIFFICULT_EASY = {
  "very_difficult": "Sehr schwer",
  "rather_difficult": "Eher schwer",
  "slightly_difficult": "Teilweise schwer",
  "neutral": "Teils / teils",
  "slightly_easy": "Teilweise einfach",
  "rather_easy": "Eher einfach",
  "very_easy": "Sehr einfach",
};

Questionnaire AA_DidYouLearn() => Questionnaire(
        title: "Hast du heute mit cabuu Vokabeln gelernt?",
        name: AppScreen.AA_DidYouLearn.name,
        questions: [
          ChoiceQuestionViewModel(
              choices: CHOICES_YESNO,
              name: "AA_DidYouLearn_1",
              questionText: "Hast du heute mit cabuu Vokabeln gelernt?"),
        ]);

Questionnaire AA_PreviousStudySession() => Questionnaire(
        title: "Hast du heute mit cabuu Vokabeln gelernt?",
        name: AppScreen.AA_PreviousStudySession.name,
        questions: [
          ChoiceQuestionViewModel(
              choices: {
                "very_satisfied": "Sehr zufrieden",
                "Very unsatisfied": "Sehr unzufrieden"
              },
              name: "${AppScreen.AA_PreviousStudySession.name}_1",
              questionText:
                  "Wie zufrieden bist du damit, wie du heute mit cabuu gelernt hast?"),
        ]);

Questionnaire AA_WhyNotLearn() =>
    Questionnaire(title: "", name: AppScreen.AA_WhyNotLearn.name, questions: [
      ChoiceQuestionViewModel(
          choices: {
            "forgot": "Ich habe vergessen, Vokabeln zu lernen",
            "procrastinated":
                "Ich habe das Lernen zu lange vor mir hergeschoben",
            "nomotivation": "Ich hatte keine Lust, Vokabeln zu lernen",
            "noTime": "Ich hatte keine Zeit, Vokabeln zu lernen",
            "learnedelsewhere":
                "Ich habe Vokabeln gelernt, aber nicht mit cabuu",
            "TEXTINPUT": "Sonstiges, nämlich"
          },
          name: AppScreen.AA_WhyNotLearn.name,
          questionText: "Warum hast du keine Vokabeln mit cabuu gelernt?"),
    ]);

Questionnaire AA_NextStudySession() => Questionnaire(
        title: "",
        name: AppScreen.AA_NextStudySession.name,
        questions: [
          ChoiceQuestionViewModel(
            questionText:
                "Wie wahrscheinlich ist es, dass du morgen Vokabeln lernen wirst?",
            choices: CHOICES_LIKELY,
            name: "${AppScreen.AA_NextStudySession.name}_expectation",
          ),
          ChoiceQuestionViewModel(
              questionText:
                  "Wie wichtig ist es dir, morgen Vokabeln zu lernen?",
              choices: CHOICES_IMPORTANCE,
              name: "${AppScreen.AA_NextStudySession.name}_importance"),
        ]);

Questionnaire OB_VocabRoutine() => Questionnaire(
        title:
            "Wie lernst du Vokabeln? Gib an, wie sehr die Aussagen auf dich zutreffen",
        name: "OB_VocabRoutine",
        questions: [
          ChoiceQuestionViewModel(
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
          ChoiceQuestionViewModel(
              name: "OB_VocabRoutine_2",
              questionText:
                  "Ich habe eine feste Routine dafür, wann ich Vokabeln lerne.",
              choices: CHOICES_APPLIES),
          ChoiceQuestionViewModel(
              name: "OB_VocabRoutine_3",
              questionText:
                  "Ich entscheide meistens spontan, wann ich Vokabeln lerne.",
              choices: CHOICES_APPLIES),
          ChoiceQuestionViewModel(
              name: "OB_VocabRoutine_4",
              questionText:
                  "Obwohl ich weiß, dass ich Vokabeln lernen sollte, schiebe ich es oft lange vor mir her.",
              choices: CHOICES_APPLIES),
          ChoiceQuestionViewModel(
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
          ChoiceQuestionViewModel(
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

Questionnaire OB_Motivation() => Questionnaire(
        title: "Gib an, wie sehr die Aussagen auf dich zutreffen",
        name: "OB_Motivation",
        questions: [
          ChoiceQuestionViewModel(
              name: "OB_Motivation_1",
              questionText:
                  "Ich lerne Vokabeln, weil ich Freude daran habe, neue Wörter zu lernen.",
              choices: CHOICES_APPLIES),
          ChoiceQuestionViewModel(
              name: "OB_Motivation_2",
              questionText:
                  "Ich lerne Vokabeln, weil ich jemand bin, der gut Englisch sprechen kann.",
              choices: CHOICES_APPLIES),
          ChoiceQuestionViewModel(
              name: "OB_Motivation_3",
              questionText:
                  "Ich lerne Vokabeln, weil ich sonst ein schlechtes Gewissen hätte.",
              choices: CHOICES_APPLIES),
          ChoiceQuestionViewModel(
              name: "OB_Motivation_4",
              questionText:
                  "Ich lerne Vokabeln, weil ich gute Noten bekommen möchte",
              choices: CHOICES_APPLIES),
          ChoiceQuestionViewModel(
              name: "OB_Motivation_4",
              questionText:
                  "Ich lerne Vokabeln, obwohl ich nicht wirklich weiß, wozu überhaupt.",
              choices: CHOICES_APPLIES),
        ]);

Questionnaire OB_ToB() => Questionnaire(
        title: "Gib an, wie sehr die Aussagen auf dich zutreffen",
        name: "OB_ToB",
        questions: [
          ChoiceQuestionViewModel(
              name: "OB_ToB_1",
              questionText:
                  "Wenn ich möglichst oft Vokabeln lernen würde, wäre das...",
              choices: CHOICES_GOODBAD),
          ChoiceQuestionViewModel(
              name: "OB_ToB_2",
              questionText:
                  "Wenn ich möglichst oft Vokabeln lernen würde, wäre das...",
              choices: CHOICES_PLEASANT),
          ChoiceQuestionViewModel(
              name: "OB_ToB_3",
              questionText:
                  "Meine Eltern, Freunde, Lehrer denken, dass ich möglichst oft Vokabeln lernen sollte.",
              choices: CHOICES_AGREE),
          ChoiceQuestionViewModel(
              name: "OB_ToB_4",
              questionText: "Die meisten Kinder lernen möglichst oft Vokabeln.",
              choices: CHOICES_LIKELY),
          ChoiceQuestionViewModel(
              name: "OB_ToB_5",
              questionText:
                  "Ich bin sicher, dass ich möglichst oft Vokabeln lernen kann.",
              choices: CHOICES_RIGHTWRONG),
          ChoiceQuestionViewModel(
              name: "OB_ToB_6",
              questionText: "Es liegt an mir, wie ich Vokabeln lerne.",
              choices: CHOICES_AGREE),
          ChoiceQuestionViewModel(
              name: "OB_ToB_7",
              questionText: "Ich habe vor, möglichst oft Vokabeln zu lernen.",
              choices: CHOICES_LIKELY),
        ]);

Questionnaire RememberToLearn() =>
    Questionnaire(title: "", name: AppScreen.RememberToLearn.name, questions: [
      QuestionnaireTextPageViewModel(
          name: "${AppScreen.RememberToLearn.name}_1",
          text: ["## Denk daran, morgen Vokabeln zu lernen! "])
    ]);

Questionnaire ReminderTestToday() => Questionnaire(
        title: "",
        name: AppScreen.ReminderTestToday.name,
        questions: [
          QuestionnaireTextPageViewModel(
              name: "${AppScreen.ReminderTestToday.name}_1",
              text: [
                '### Bitte mache heute noch den Test in cabuu!',
                '### Drücke dazu auf die Liste und wähle "Abfrage".',
                '### Fange dann ab morgen mit der nächsten Liste an.'
              ])
        ]);

Questionnaire ReminderTestTomorrow() => Questionnaire(
        title: "",
        name: AppScreen.ReminderTestTomorrow.name,
        questions: [
          QuestionnaireTextPageViewModel(
              completed: true,
              name: "${AppScreen.ReminderTestTomorrow.name}_1",
              text: [
                '### Morgen sollst du in cabuu den Vokabeltest machen!',
                '### Wir erinnern dich morgen noch einmal daran.',
              ])
        ]);

Questionnaire ReminderNextList() =>
    Questionnaire(title: "", name: AppScreen.ReminderNextList.name, questions: [
      QuestionnaireTextPageViewModel(
          name: "${AppScreen.ReminderNextList.name}_1",
          text: [
            '### Prima!',
            '### Fange ab morgen an, die nächste Liste in cabuu zu lernen.',
            '### Du hast wieder 20 Tage Zeit bis zum nächsten Test.'
          ])
    ]);

Questionnaire VocabToday() =>
    Questionnaire(title: "", name: AppScreen.VocabTestToday.name, questions: [
      QuestionnaireTextPageViewModel(
          name: "${AppScreen.VocabTestToday.name}_1",
          text: [
            'Mache heute den Vokabeltest in cabuu!',
            'Drücke dazu auf die Liste, die du gerade lernst, und wähle "Abfrage".',
            "Mache hier in der App dann ab 18 Uhr weiter."
          ])
    ]);

Questionnaire AA_DidYouTest() => Questionnaire(
        title: "AA_DidYouTest",
        name: AppScreen.DidYouTest.name,
        questions: [
          ChoiceQuestionViewModel(
              name: "AA_DidYouTest_1",
              questionText: "Hast du heute den Vokabeltest in cabuu gemacht?",
              choices: CHOICES_YESNO),
        ]);

Questionnaire WeeklyQuestions() =>
    Questionnaire(title: "", name: AppScreen.WeeklyQuestions.name, questions: [
      ChoiceQuestionViewModel(
          name: "Weekly_DifficultiesWhileLearning",
          questionText:
              "Welche Schwierigkeiten hattest du in der vergangenen Woche beim Vokabellernen (z.B. wenig Konzentration, keine Lust, Ablenkung, ...).",
          choices: {"TEXTINPUT": ""}),
      ChoiceQuestionViewModel(
          name: "Weekly_PerceptionOfIntervention_AnnoyingEnjoyable",
          questionText:
              "Abends in der App einen Plan aufzuschreiben, fand ich...",
          choices: CHOICES_ANNOYING_ENJOYABLE),
      ChoiceQuestionViewModel(
          name: "Weekly_PerceptionOfIntervention_UselessHelpful",
          questionText:
              "Abends in der App einen Plan aufzuschreiben, fand ich...",
          choices: CHOICES_USELESS_HELPFUL),
      ChoiceQuestionViewModel(
          name: "Weekly_PerceptionOfIntervention_DifficultEasy",
          questionText:
              "Abends in der App einen Plan aufzuschreiben, fand ich...",
          choices: CHOICES_DIFFICULT_EASY),
      ChoiceQuestionViewModel(
          name: "Weekly_vocabLearning_1",
          questionText:
              "Abends in der App einen Plan aufzuschreiben, fand ich...",
          choices: CHOICES_DIFFICULT_EASY),
      ChoiceQuestionViewModel(
          name: "Weekly_vocabLearning_daysago",
          questionText: "Wann war dein letzter Vokabeltest in der Schule?",
          choices: {
            "today": "Heute",
            "1_day_ago": DateFormat('EEEE')
                .format(DateTime.now().subtract(Duration(days: 1))),
            "2_days_ago": DateFormat('EEEE')
                .format(DateTime.now().subtract(Duration(days: 2)))
                .toString(),
            "3_days_ago": DateFormat('EEEE')
                .format(DateTime.now().subtract(Duration(days: 3)))
                .toString(),
            "4_day_ago": DateFormat('EEEE')
                .format(DateTime.now().subtract(Duration(days: 4)))
                .toString(),
            "5_days_ago": DateFormat('EEEE')
                .format(DateTime.now().subtract(Duration(days: 5)))
                .toString(),
            "6_days_ago": DateFormat('EEEE')
                .format(DateTime.now().subtract(Duration(days: 6)))
                .toString(),
            "more_than_one_wek_ago": "Mehr als eine Woche her",
          }),
      ChoiceQuestionViewModel(
          name: "Weekly_vocabLearning_medium",
          questionText:
              "Hast du in den letzten 7 Tagen deine Englischvokabeln auch anders als mit cabuu gelernt (zum Beispiel mit dem Vokabelheft)?",
          choices: {
            "no": "Nein",
            "1_2_days": "Ja, an 1-2 Tagen",
            "3_4_days": "Ja, an 3-4 Tagen",
            "5_6_days": "Ja, an 5-6 Tagen",
            "7_days": "Ja, jeden Tag",
          }),
      QuestionnaireTextPageViewModel(
          name: "${AppScreen.ReminderNextList.name}_1",
          text: [
            '### Denk dran, dass du dir die Vokabeln besser merken kannst, wenn du jeden Tag ein bisschen lernst.',
          ])
    ]);

Questionnaire FinalQuestionnaire() => Questionnaire(
        title: "FinalQuestionnaire",
        name: AppScreen.FinalQuestionnaire.name,
        questions: [
          QuestionnaireTextPageViewModel(
              name: "FinalQuestionnaire_Intro",
              text: [
                "### Du nimmst jetzt schon seit einiger Zeit an der Studie teil.",
                "###  Auf den nächsten Seiten haben wir dazu ein paar Fragen an dich.",
                "###  Nimm dir dafür ein paar Minuten Zeit.",
              ]),
          ChoiceQuestionViewModel(
              name: "FinalQuestionnaire_tech_affin1",
              questionText:
                  "Ich beschäftige mich gerne länger mit Smartphone Apps.",
              choices: CHOICES_APPLIES),
          ChoiceQuestionViewModel(
              name: "FinalQuestionnaire_tech_affin2",
              questionText:
                  "Ich teste gerne, was man mit neuen Smartphone Apps machen kann.",
              choices: CHOICES_APPLIES),
          ChoiceQuestionViewModel(
              name: "FinalQuestionnaire_tech_affin3",
              questionText:
                  "Ich beschäftige mich hauptsächlich mit Smartphone Apps, weil ich muss.",
              choices: CHOICES_APPLIES),
          ChoiceQuestionViewModel(
              name: "FinalQuestionnaire_tech_affin4",
              questionText:
                  "Wenn ich ein neues Gerät wie ein Handy oder Tablet vor mir habe, dann probiere ich es lange aus.",
              choices: CHOICES_APPLIES),
          ChoiceQuestionViewModel(
              name: "FinalQuestionnaire_tech_affin5",
              questionText:
                  "Wenn ich eine neue App auf dem Smartphone habe, dann verbringe ich gerne Zeit damit, alle Funktionen der App auszuprobieren.",
              choices: CHOICES_APPLIES),
          ChoiceQuestionViewModel(
              name: "FinalQuestionnaire_tech_affin6",
              questionText:
                  "Es reicht mir, dass eine mobile App funktioniert; das Wie und Warum ist mir egal.",
              choices: CHOICES_APPLIES),
          ChoiceQuestionViewModel(
              name: "FinalQuestionnaire_tech_affin7",
              questionText:
                  "Ich interesiere mich dafür, wie eine Smartphone App genau funktioniert.",
              choices: CHOICES_APPLIES),
          QuestionnaireTextPageViewModel(
              name: "FinalQuestionnaire_Last",
              text: [
                "### Die letzte Vokabelliste sollst du nun alleine lernen.",
                "### Ab morgen brauchst du also nicht mehr täglich PROMPT benutzen.",
                "### Versuche trotzdem daran zu denken, regelmäßig Vokabeln zu lernen. Du hast wieder 20 Tage Zeit zum Lernen, bevor du dich testen sollst.",
              ]),
        ]);
