// ignore_for_file: non_constant_identifier_names

import 'package:intl/intl.dart';
import 'package:prompt/models/questionnaire.dart';
import 'package:prompt/shared/enums.dart';
import 'package:prompt/viewmodels/choice_question_view_model.dart';
import 'package:prompt/viewmodels/questionnaire_textpage_view_model.dart';

Map<String, String> CHOICES_APPLIES = {
  "1": "Stimmt gar nicht",
  "2": "Stimmt eher nicht",
  "3": "Teils/teils",
  "4": "Stimmt eher",
  "5": "Stimmt genau",
};

Map<String, String> CHOICES_GOODBAD = {
  "1": "Sehr schlecht",
  "2": "Eher schlecht",
  "3": "Teils/teils",
  "4": "Eher gut",
  "5": "Sehr gut",
};

Map<String, String> CHOICES_PLEASANT = {
  "1": "Sehr unangenehm",
  "2": "Eher unangenehm",
  "3": "Teils/teils",
  "4": "Eher angenehm",
  "5": "Sehr angenehm",
};

Map<String, String> CHOICES_AGREE = {
  "1": "Stimme überhaupt nicht zu",
  "2": "Stimme eher nicht zu",
  "3": "Teils/teils",
  "4": "Stimme eher zu",
  "5": "Stimme voll und ganz zu",
};

Map<String, String> CHOICES_LIKELY = {
  "1": "Sehr unwahrscheinlich",
  "2": "Eher unwahrscheinlich",
  "3": "Teils/teils",
  "4": "Eher wahrscheinlich",
  "5": "Sehr wahrscheinlich",
};

Map<String, String> CHOICES_RIGHTWRONG = {
  "1": "Sehr falsch",
  "2": "Eher falsch",
  "3": "Teils/teils",
  "4": "Eher richtig",
  "5": "Sehr richtig",
};

Map<String, String> CHOICES_YESNO = {
  "1": "Ja",
  "0": "Nein",
};

Map<String, String> CHOICES_IMPORTANCE = {
  "1": "Sehr unwichtig",
  "2": "Eher unwichtig",
  "3": "Teils/teils",
  "4": "Eher wichtig",
  "5": "Sehr wichtig",
};

Map<String, String> CHOICES_ANNOYING_ENJOYABLE = {
  "1": "Sehr nervig",
  "2": "Eher nervig",
  "3": "Teils/teils",
  "4": "Eher angenehm",
  "5": "Sehr angenehm",
};

Map<String, String> CHOICES_USELESS_HELPFUL = {
  "1": "Sehr unnötig",
  "2": "Eher unnötig",
  "3": "Teils/teils",
  "4": "Eher hilfreich",
  "5": "Sehr hilfreich",
};

Map<String, String> CHOICES_DIFFICULT_EASY = {
  "1": "Sehr schwer",
  "2": "Eher schwer",
  "3": "Teils/teils",
  "4": "Eher einfach",
  "5": "Sehr einfach",
};

Map<String, String> CHOICES_FREQUENCY = {
  "1": "Nie",
  "2": "Selten",
  "3": "Manchmal",
  "4": "Oft",
  "5": "Immer",
};

Map<String, String> CHOICES_TEXTFIELD = {
  "TEXTINPUT": "",
};

Questionnaire AA_PROCRAST() =>
    Questionnaire(title: "", name: AppScreen.AA_PROCRAST.name, questions: [
      ChoiceQuestionViewModel(
        questionText: "Heute habe ich das Vokabellernen aufgeschoben.",
        choices: CHOICES_APPLIES,
        name: "AA_procrastination_1",
      ),
      ChoiceQuestionViewModel(
        questionText:
            "Heute fiel es mir sehr schwer, mich zum Vokabellernen zu bringen.",
        choices: CHOICES_APPLIES,
        name: "AA_procrastination_1",
      ),
      ChoiceQuestionViewModel(
        questionText:
            "Heute habe ich lange darüber nachgedacht, ob ich mit dem Vokabellernen anfangen soll.",
        choices: CHOICES_APPLIES,
        name: "AA_procrastination_1",
      ),
    ]);

Questionnaire AA_NextStudySession() => Questionnaire(
        title: "",
        name: AppScreen.AA_NEXTSTUDYSESSION.name,
        questions: [
          ChoiceQuestionViewModel(
            questionText:
                "Wie wahrscheinlich ist es, dass du morgen Vokabeln lernen wirst?",
            choices: CHOICES_LIKELY,
            name: "${AppScreen.AA_NEXTSTUDYSESSION.name}_expectation",
          ),
          ChoiceQuestionViewModel(
            questionText: "Wie wichtig ist es dir, morgen Vokabeln zu lernen?",
            choices: CHOICES_IMPORTANCE,
            name: "${AppScreen.AA_NEXTSTUDYSESSION.name}_importance",
          ),
          ChoiceQuestionViewModel(
            questionText:
                "Wie enttäuscht wärst du, wenn du es morgen nicht schaffen würdest, Vokabeln zu lernen?",
            choices: {
              "1": "Gar nicht enttäuscht",
              "2": "Eher nicht enttäuscht",
              "3": "Teils/teils",
              "4": "Eher enttäuscht",
              "5": "Sehr enttäuscht",
            },
            name: "${AppScreen.AA_NEXTSTUDYSESSION.name}_commitment",
          ),
          ChoiceQuestionViewModel(
              questionText:
                  "Ich glaube, dass ich mich morgen gut zum Vokabellernen motivieren kann.",
              choices: CHOICES_APPLIES,
              name: "${AppScreen.AA_NEXTSTUDYSESSION.name}_efficacy"),
        ]);

Questionnaire OB_VocabRoutine() => Questionnaire(
        title:
            "Wie lernst du Vokabeln? Gib an, wie sehr die Aussagen auf dich zutreffen.",
        name: "OB_VOCABROUTINE",
        questions: [
          ChoiceQuestionViewModel(
              name: "attitude_cabuu",
              questionText: "Wie gefällt dir die Vokabel-App cabuu?",
              choices: {
                "1": "Sehr schlecht",
                "2": "Eher schlecht",
                "3": "Teils/teils",
                "4": "Eher gut",
                "5": "Sehr gut",
                "6": "Ich habe die App cabuu noch nicht ausprobiert."
              }),
          ChoiceQuestionViewModel(
              name: "OB_routine_1",
              questionText:
                  "Ich habe eine feste Routine dafür, wann ich Vokabeln lerne.",
              choices: CHOICES_APPLIES),
          ChoiceQuestionViewModel(
              name: "OB_routine_2",
              questionText:
                  "Ich entscheide meistens spontan, wann ich Vokabeln lerne.",
              choices: CHOICES_APPLIES),
          ChoiceQuestionViewModel(
              name: "OB_routine_3",
              questionText:
                  "Wie oft lernst du normalerweise Englischvokabeln, **wenn kein Test ansteht**?",
              choices: {
                "1": "Weniger als 1 Tag pro Woche",
                "2": "1-2 Tage pro Woche",
                "3": "3-4 Tage pro Woche",
                "4": "5-6 Tage pro Woche",
                "5": "Jeden Tag",
              }),
          ChoiceQuestionViewModel(
              name: "OB_routine_4",
              questionText:
                  "Wie oft lernst du normalerweise Englischvokabeln, **wenn ein Test angekündigt ist**?",
              choices: {
                "1": "Weniger als 1 Tag pro Woche",
                "2": "1-2 Tage pro Woche",
                "3": "3-4 Tage pro Woche",
                "4": "5-6 Tage pro Woche",
                "5": "Jeden Tag",
              }),
          ChoiceQuestionViewModel(
              name: "belief_distributed_practice_1",
              questionText:
                  "Auch wenn ich die Vokabeln erst kurz vor dem Test lerne, werde ich sie im Test gut können.",
              choices: CHOICES_APPLIES),
          ChoiceQuestionViewModel(
              name: "expectation_distributed_practice",
              questionText:
                  "Ich glaube, ich werde es schaffen, (fast) jeden Tag in cabuu Vokabeln zu lernen.",
              choices: CHOICES_APPLIES),
          ChoiceQuestionViewModel(
              name: "value_distributed_practice",
              questionText:
                  "Es ist mir wichtig, in cabuu möglichst jeden Tag Vokabeln zu lernen.",
              choices: CHOICES_APPLIES),
          ChoiceQuestionViewModel(
              name: "belief_distributed_practice_2",
              questionText:
                  "Je öfter ich in cabuu Vokabeln lerne, desto besser werde ich sie mir merken können.",
              choices: CHOICES_APPLIES),
        ]);

Questionnaire StudyFinishedQuestionnaire() =>
    Questionnaire(title: "", name: AppScreen.STUDYFINISHED.name, questions: [
      QuestionnaireTextPageViewModel(
          name: "${AppScreen.REMINDERTESTTODAY.name}_1",
          text: [
            '### In den letzten 20 Tagen hast du Prompt nicht mehr benutzt, aber noch mit cabuu deine Vokabeln gelernt. Wir stellen dir noch ein paar Fragen dazu, wie es dir dabei ergangen ist.',
          ]),
      ChoiceQuestionViewModel(
          name: "followup_1",
          choices: CHOICES_FREQUENCY,
          questionText:
              "Ich habe mir abends einen Plan gemacht, wann und wo ich am nächsten Tag meine Vokabeln lernen werde."),
      ChoiceQuestionViewModel(
          name: "followup_2",
          choices: CHOICES_FREQUENCY,
          questionText:
              "Ich habe im Voraus geplant, wann und wo ich meine Vokabeln lerne."),
      ChoiceQuestionViewModel(
          name: "followup_3",
          choices: CHOICES_FREQUENCY,
          questionText:
              "Ich habe spontan entschieden, wann und wo ich Vokabeln lerne."),
      QuestionnaireTextPageViewModel(
          name: "${AppScreen.REMINDERTESTTODAY.name}_1",
          text: [
            '### Vielen Dank, dass du so toll mitgemacht hast!',
            '### Die Studie ist jetzt vorbei. Wir senden dir in Kürze deinen Amazon-Gutschein zu - bitte habe ein wenig Geduld.',
            '### Die App cabuu kannst du nun kostenlos weiter benutzen. Die App PROMPT kannst du deinstallieren.'
          ]),
    ]);

Questionnaire OB_Procrastination() => Questionnaire(
        title: "Gib an, wie sehr die Aussagen auf dich zutreffen.",
        name: "OB_PROCRASTINATION",
        questions: [
          ChoiceQuestionViewModel(
              name: "OB_procrastination_1",
              questionText:
                  "Ich lasse unnötig viel Zeit verstreichen, bis ich mit dem Vokabellernen beginne.",
              choices: CHOICES_FREQUENCY),
          ChoiceQuestionViewModel(
              name: "OB_procrastination_2",
              questionText:
                  "Ich könnte mit dem Vokabellernen beginnen, stattdessen beschäftige ich mich mit anderen Dingen.",
              choices: CHOICES_FREQUENCY),
          ChoiceQuestionViewModel(
              name: "OB_procrastination_3",
              questionText:
                  "Auch wenn ein guter Zeitpunkt da ist, mit dem Vokabellernen anzufangen, tue ich es nicht sofort.",
              choices: CHOICES_APPLIES),
          ChoiceQuestionViewModel(
              name: "OB_procrastination_4",
              questionText:
                  "Wenn ich das Vokabellernen aufschiebe, fühle ich mich schlecht.",
              choices: CHOICES_FREQUENCY),
          ChoiceQuestionViewModel(
              name: "OB_procrastination_5",
              questionText:
                  "Wenn ich das Vokabellernen aufschiebe, habe ich ein schlechtes Gewissen.",
              choices: CHOICES_FREQUENCY),
          ChoiceQuestionViewModel(
              name: "OB_procrastination_6",
              questionText:
                  "Wenn ich das Vokabellernen aufschiebe, mache ich mir Sorgen.",
              choices: CHOICES_FREQUENCY),
        ]);

Questionnaire OB_ToB() => Questionnaire(
        title: "Gib an, wie sehr die Aussagen auf dich zutreffen.",
        name: "OB_ToB",
        questions: [
          ChoiceQuestionViewModel(
              name: "OB_ToB_att1",
              questionText:
                  "Wenn ich (fast) jeden Tag Vokabeln lernen würde, wäre das...",
              choices: CHOICES_GOODBAD),
          ChoiceQuestionViewModel(
              name: "OB_ToB_att2",
              questionText:
                  "Wenn ich (fast) jeden Tag Vokabeln lernen würde, wäre das...",
              choices: CHOICES_PLEASANT),
          ChoiceQuestionViewModel(
              name: "OB_ToB_subnorm1",
              questionText:
                  "Meine Eltern, Freunde, Lehrer denken, dass ich (fast) jeden Tag Vokabeln lernen sollte.",
              choices: CHOICES_APPLIES),
          ChoiceQuestionViewModel(
              name: "OB_ToB_subnorm2",
              questionText:
                  "Die meisten Kinder lernen (fast) jeden Tag Vokabeln.",
              choices: CHOICES_LIKELY),
          ChoiceQuestionViewModel(
              name: "OB_ToB_control1",
              questionText:
                  "Ich bin sicher, dass ich (fast) jeden Tag Vokabeln lernen kann.",
              choices: CHOICES_RIGHTWRONG),
          ChoiceQuestionViewModel(
              name: "OB_ToB_control2",
              questionText: "Es liegt an mir, wie oft ich Vokabeln lerne.",
              choices: CHOICES_APPLIES),
          ChoiceQuestionViewModel(
              name: "OB_ToB_intent",
              questionText:
                  "Ich habe vor, (fast) jeden Tag Vokabeln zu lernen.",
              choices: CHOICES_LIKELY),
        ]);

Questionnaire RememberToLearn() =>
    Questionnaire(title: "", name: AppScreen.REMEMBERTOLEARN.name, questions: [
      QuestionnaireTextPageViewModel(
          name: "${AppScreen.REMEMBERTOLEARN.name}_1",
          text: ["## Denk daran, morgen Vokabeln zu lernen! "])
    ]);

Questionnaire ReminderTestToday() => Questionnaire(
        title: "",
        name: AppScreen.REMINDERTESTTODAY.name,
        questions: [
          QuestionnaireTextPageViewModel(
              name: "${AppScreen.REMINDERTESTTODAY.name}_1",
              text: [
                '### Bitte mache heute noch den Test in cabuu!',
                '### Drücke dazu auf die Liste und wähle "Abfrage".',
                '### Fange dann ab morgen mit der nächsten Liste an.'
              ])
        ]);

Questionnaire ReminderTestTomorrow() => Questionnaire(
        title: "",
        name: AppScreen.REMINDERTESTTOMORROW.name,
        questions: [
          QuestionnaireTextPageViewModel(
              completed: true,
              name: "${AppScreen.REMINDERTESTTOMORROW.name}_1",
              text: [
                '### Morgen sollst du in cabuu den Vokabeltest machen!',
                '### Wir erinnern dich morgen noch einmal daran.',
              ])
        ]);

Questionnaire ReminderNextList() =>
    Questionnaire(title: "", name: AppScreen.REMINDERNEXTLIST.name, questions: [
      QuestionnaireTextPageViewModel(
          name: "${AppScreen.REMINDERNEXTLIST.name}_1",
          text: [
            '### Prima!',
            '### Fange ab morgen an, die nächste Liste in cabuu zu lernen.',
            '### Du hast wieder 20 Tage Zeit bis zum nächsten Test.'
          ])
    ]);

Questionnaire VocabToday() =>
    Questionnaire(title: "", name: AppScreen.VOCABTESTTODAY.name, questions: [
      QuestionnaireTextPageViewModel(
          name: "${AppScreen.VOCABTESTTODAY.name}_1",
          text: [
            'Mache heute den Vokabeltest in cabuu!',
            'Drücke dazu auf die Liste, die du gerade lernst, und wähle "Abfrage".',
            "Mache hier in der App dann ab 18 Uhr weiter."
          ])
    ]);

Questionnaire AA_DidYouTest() => Questionnaire(
        title: "AA_DidYouTest",
        name: AppScreen.DIDYOUTEST.name,
        questions: [
          ChoiceQuestionViewModel(
              name: "AA_DidYouTest_1",
              questionText: "Hast du heute den Vokabeltest in cabuu gemacht?",
              choices: CHOICES_YESNO),
        ]);

Questionnaire WeeklyQuestions() => Questionnaire(
        title:
            "Am Ende jeder Woche haben wir noch ein paar zusätzliche Fragen an dich. Denke an die letzten sieben Tage zurück und antworte ehrlich.",
        name: AppScreen.WEEKLYQUESTIONS.name,
        questions: [
          QuestionnaireTextPageViewModel(name: "weekly_intro", text: [
            '### Am Ende jeder Woche haben wir noch ein paar zusätzliche Fragen an dich. Denke an die letzten sieben Tage zurück und antworte ehrlich.',
          ]),
          ChoiceQuestionViewModel(
              name: "perc_int_1",
              questionText:
                  "Abends in der App einen Plan aufzuschreiben, fand ich...",
              choices: CHOICES_ANNOYING_ENJOYABLE),
          ChoiceQuestionViewModel(
              name: "perc_int_2",
              questionText:
                  "Abends in der App einen Plan aufzuschreiben, fand ich...",
              choices: CHOICES_USELESS_HELPFUL),
          ChoiceQuestionViewModel(
              name: "perc_int_3",
              questionText:
                  "Abends in der App einen Plan aufzuschreiben, fand ich...",
              choices: CHOICES_DIFFICULT_EASY),
          ChoiceQuestionViewModel(
              name: "eff_int",
              questionText:
                  "Wenn ich in der App einen Plan aufgeschrieben habe, habe ich am nächsten Tag genau zu dem Zeitpunkt gelernt.",
              choices: CHOICES_FREQUENCY),
          ChoiceQuestionViewModel(
              name: "Weekly_vocabLearning_daysago",
              questionText: "Wann war dein letzter Vokabeltest in der Schule?",
              choices: {
                "0": "Heute",
                "1": DateFormat('EEEE')
                    .format(DateTime.now().subtract(Duration(days: 1))),
                "2": DateFormat('EEEE')
                    .format(DateTime.now().subtract(Duration(days: 2)))
                    .toString(),
                "3": DateFormat('EEEE')
                    .format(DateTime.now().subtract(Duration(days: 3)))
                    .toString(),
                "4": DateFormat('EEEE')
                    .format(DateTime.now().subtract(Duration(days: 4)))
                    .toString(),
                "5": DateFormat('EEEE')
                    .format(DateTime.now().subtract(Duration(days: 5)))
                    .toString(),
                "6": DateFormat('EEEE')
                    .format(DateTime.now().subtract(Duration(days: 6)))
                    .toString(),
                "7": "Mehr als eine Woche her",
              }),
          ChoiceQuestionViewModel(
              name: "learning_mode",
              questionText:
                  "Hast du in den letzten sieben Tagen deine Englischvokabeln auch anders als mit cabuu gelernt (zum Beispiel mit dem Vokabelheft)?",
              choices: {
                "1": "Nein",
                "2": "Ja, an 1-2 Tagen",
                "3": "Ja, an 3-4 Tagen",
                "4": "Ja, an 5-6 Tagen",
                "5": "Ja, jeden Tag",
              }),
          ChoiceQuestionViewModel(
              name: "accomplish_goal",
              questionText:
                  "Ich habe in der letzten Woche genauso häufig Vokabeln gelernt, wie ich vorhatte.",
              choices: CHOICES_APPLIES),
        ]);

Questionnaire FinalQuestionnaire() => Questionnaire(
        title: "FinalQuestionnaire",
        name: AppScreen.FINALQUESTIONNAIRE.name,
        questions: [
          QuestionnaireTextPageViewModel(
              name: "FinalQuestionnaire_Intro",
              text: [
                "### Du nimmst jetzt schon seit einiger Zeit an der Studie teil.",
                "###  Auf den nächsten Seiten haben wir dazu ein paar Fragen an dich.",
                "###  Nimm dir dafür ein paar Minuten Zeit.",
              ]),
          ChoiceQuestionViewModel(
              name: "FinalQuestionnaire_usability_fun",
              questionText:
                  "Es hat mir Spaß gemacht, die App PROMPT zu nutzen.",
              choices: CHOICES_APPLIES),
          ChoiceQuestionViewModel(
              name: "FinalQuestionnaire_usability_difficulty",
              questionText:
                  "Ich fand es schwierig, die App PROMPT zu bedienen.",
              choices: CHOICES_APPLIES),
          ChoiceQuestionViewModel(
              name: "FinalQuestionnaire_usability_helpful",
              questionText:
                  "Die App PROMPT hat mir beim Lernen mit der App cabuu geholfen.",
              choices: CHOICES_APPLIES),
          ChoiceQuestionViewModel(
              name: "FinalQuestionnaire_usability_intention",
              questionText: "Ich würde die App PROMPT gerne weiter benutzen.",
              choices: CHOICES_APPLIES),
          ChoiceQuestionViewModel(
              name: "FinalQuestionnaire_usability_confusion",
              questionText:
                  "Wenn du etwas verwirrend an der App PROMPT fandest, was war das?",
              choices: CHOICES_TEXTFIELD),
          ChoiceQuestionViewModel(
              name: "FinalQuestionnaire_usabilty_good",
              questionText: "Das fand ich gut an der App PROMPT:",
              choices: CHOICES_TEXTFIELD),
          ChoiceQuestionViewModel(
              name: "FinalQuestionnaire_usabilty_bad",
              questionText: "Das fand ich nicht so gut an der App PROMPT:",
              choices: CHOICES_TEXTFIELD),
          ChoiceQuestionViewModel(
              name: "FinalQuestionnaire_usability_workaround",
              questionText:
                  "Wenn du irgendwelche Schwierigkeiten mit der App PROMPT hattest, wie hast du sie gelöst?",
              choices: CHOICES_TEXTFIELD),
          QuestionnaireTextPageViewModel(
              name: "FinalQuestionnaire_Last",
              text: [
                "### Die letzte Vokabelliste sollst du nun alleine lernen.",
                "### Ab morgen brauchst du also nicht mehr täglich PROMPT benutzen.",
                "### Versuche trotzdem daran zu denken, regelmäßig Vokabeln zu lernen. Du hast wieder 20 Tage Zeit zum Lernen, bevor du dich testen sollst.",
              ]),
        ]);
