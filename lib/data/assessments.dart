import 'package:prompt/models/question.dart';
import 'package:prompt/models/questionnaire.dart';

var questionnaireDidYouLearn = Questionnaire(
    title: "Hast du heute mit cabuu Vokabeln gelernt?",
    name: "aa_didyoulearntoday",
    questions: [
      ChoiceQuestion(
          choices: {"1": "Ja", "2": "Nein"},
          name: "aa_didyoulearntoday",
          questionText: "Hast du heute mit cabuu Vokabeln gelernt?"),
    ]);

var questionnaireSrl = Questionnaire(
    title: "Gib an, wie oft folgende Aussagen auf dich zutreffen.",
    name: "srl",
    questions: [
      ChoiceQuestion(name: "srl_1", questionText: "SRL PAGE 0", choices: {
        "1": "(Fast) nie",
        "2": "Selten",
        "3": "Hin und wieder",
        "4": "Oft",
        "5": "(Fast) immer"
      }),
      ChoiceQuestion(name: "srl_2", questionText: "SRL PAGE 1", choices: {
        "1": "(Fast) nie",
        "2": "Selten",
        "3": "Hin und wieder",
        "4": "Oft",
        "5": "(Fast) immer"
      }),
      ChoiceQuestion(name: "srl_3", questionText: "SRL PAGE 2", choices: {
        "1": "(Fast) nie",
        "2": "Selten",
        "3": "Hin und wieder",
        "4": "Oft",
        "5": "(Fast) immer"
      }),
      ChoiceQuestion(name: "srl_4", questionText: "SRL PAGE 3", choices: {
        "1": "(Fast) nie",
        "2": "Selten",
        "3": "Hin und wieder",
        "4": "Oft",
        "5": "(Fast) immer"
      })
    ]);

var questionnaireSelfEfficacy = Questionnaire(
    title: "Gib an, wie oft folgende Aussagen auf dich zutreffen.",
    name: "srl",
    questions: [
      ChoiceQuestion(name: "se_0", questionText: "EFFICACY PAGE 0", choices: {
        "1": "(Fast) nie",
        "2": "Selten",
        "3": "Hin und wieder",
        "4": "Oft",
        "5": "(Fast) immer"
      }),
      ChoiceQuestion(name: "se_1", questionText: "EFFICACY PAGE 1", choices: {
        "1": "(Fast) nie",
        "2": "Selten",
        "3": "Hin und wieder",
        "4": "Oft",
        "5": "(Fast) immer"
      }),
      ChoiceQuestion(name: "se_2", questionText: "EFFICACY PAGE 2", choices: {
        "1": "(Fast) nie",
        "2": "Selten",
        "3": "Hin und wieder",
        "4": "Oft",
        "5": "(Fast) immer"
      }),
      ChoiceQuestion(name: "se_3", questionText: "EFFICACY PAGE 3", choices: {
        "1": "(Fast) nie",
        "2": "Selten",
        "3": "Hin und wieder",
        "4": "Oft",
        "5": "(Fast) immer"
      })
    ]);

const srl = {
  "title": "Gib an, wie oft folgende Aussagen auf dich zutreffen.",
  "name": "srl",
  "type": "single",
  "questions": [
    {
      "name": "srl_1",
      "questionText": "Wann ich Vokabeln lerne, lege ich vorher fest.",
      "labels": {
        "1": "(Fast) nie",
        "2": "Selten",
        "3": "Hin und wieder",
        "4": "Oft",
        "5": "(Fast) immer"
      }
    },
    {
      "name": "srl_2",
      "questionText": "Beim Vokabellernen bin ich ängstlich und nervös.",
      "labels": {
        "1": "(Fast) nie",
        "2": "Selten",
        "3": "Hin und wieder",
        "4": "Oft",
        "5": "(Fast) immer"
      }
    },
    {
      "name": "srl_3",
      "questionText":
          "Ich vergesse, Vokabeln zu lernen, obwohl ich es eigentlich vorhatte.",
      "labels": {
        "1": "(Fast) nie",
        "2": "Selten",
        "3": "Hin und wieder",
        "4": "Oft",
        "5": "(Fast) immer"
      }
    },
    {
      "name": "srl_4",
      "questionText":
          "Ich will Vokabeln lernen, aber dann kommt mir etwas dazwischen.",
      "labels": {
        "1": "(Fast) nie",
        "2": "Selten",
        "3": "Hin und wieder",
        "4": "Oft",
        "5": "(Fast) immer"
      }
    },
    {
      "name": "srl_5",
      "questionText": "Beim Vokabellernen ist mir langweilig.",
      "labels": {
        "1": "(Fast) nie",
        "2": "Selten",
        "3": "Hin und wieder",
        "4": "Oft",
        "5": "(Fast) immer"
      }
    },
    {
      "name": "srl_6",
      "questionText":
          "Beim Lernen von Vokabeln kann ich mich nur schlecht konzentrieren.",
      "labels": {
        "1": "(Fast) nie",
        "2": "Selten",
        "3": "Hin und wieder",
        "4": "Oft",
        "5": "(Fast) immer"
      }
    },
    {
      "name": "srl_7",
      "questionText":
          "Ich verspreche mir oft selbst, Vokabeln zu lernen, lege dann aber meine Füße hoch.",
      "labels": {
        "1": "(Fast) nie",
        "2": "Selten",
        "3": "Hin und wieder",
        "4": "Oft",
        "5": "(Fast) immer"
      }
    },
    {
      "name": "srl_8",
      "questionText":
          "Wenn ich keine Lust habe, kann ich mich trotzdem zum Vokabellernen überwinden.",
      "labels": {
        "1": "(Fast) nie",
        "2": "Selten",
        "3": "Hin und wieder",
        "4": "Oft",
        "5": "(Fast) immer"
      }
    },
    {
      "name": "srl_9",
      "questionText":
          "Zum Lernen von Vokabeln suche ich mir einen ruhigen Ort.",
      "labels": {
        "1": "(Fast) nie",
        "2": "Selten",
        "3": "Hin und wieder",
        "4": "Oft",
        "5": "(Fast) immer"
      }
    },
    {
      "name": "srl_10",
      "questionText": "Ich entscheide ganz spontan, wann ich Vokabeln lerne.",
      "labels": {
        "1": "(Fast) nie",
        "2": "Selten",
        "3": "Hin und wieder",
        "4": "Oft",
        "5": "(Fast) immer"
      }
    },
    {
      "name": "srl_11",
      "questionText": "Beim Lernen von Vokabeln bin ich frustriert.",
      "labels": {
        "1": "(Fast) nie",
        "2": "Selten",
        "3": "Hin und wieder",
        "4": "Oft",
        "5": "(Fast) immer"
      }
    },
    {
      "name": "srl_12",
      "questionText":
          "Ich nehme mir vor, Vokabeln zu lernen, vergesse es dann aber.",
      "labels": {
        "1": "(Fast) nie",
        "2": "Selten",
        "3": "Hin und wieder",
        "4": "Oft",
        "5": "(Fast) immer"
      }
    },
    {
      "name": "srl_13",
      "questionText":
          "Ich habe so viel anderes zu tun, dass ich gar nicht zum Lernen von Vokabeln komme.",
      "labels": {
        "1": "(Fast) nie",
        "2": "Selten",
        "3": "Hin und wieder",
        "4": "Oft",
        "5": "(Fast) immer"
      }
    },
    {
      "name": "srl_14",
      "questionText": "Ich denke während des Vokabellernens an andere Dinge.",
      "labels": {
        "1": "(Fast) nie",
        "2": "Selten",
        "3": "Hin und wieder",
        "4": "Oft",
        "5": "(Fast) immer"
      }
    },
    {
      "name": "srl_15",
      "questionText": "Beim Lernen von Vokabeln mache ich mir Sorgen.",
      "labels": {
        "1": "(Fast) nie",
        "2": "Selten",
        "3": "Hin und wieder",
        "4": "Oft",
        "5": "(Fast) immer"
      }
    },
    {
      "name": "srl_16",
      "questionText":
          "Während ich Vokabeln lerne, mache ich nebenbei andere Dinge (z.B. Fernsehen, Musik hören).",
      "labels": {
        "1": "(Fast) nie",
        "2": "Selten",
        "3": "Hin und wieder",
        "4": "Oft",
        "5": "(Fast) immer"
      }
    },
    {
      "name": "srl_17",
      "questionText":
          "Auch wenn ich es hasse, dass ich mit dem Vokabellernen nicht in die Gänge komme, kann ich es nicht ändern.",
      "labels": {
        "1": "(Fast) nie",
        "2": "Selten",
        "3": "Hin und wieder",
        "4": "Oft",
        "5": "(Fast) immer"
      }
    },
    {
      "name": "srl_18",
      "questionText":
          "Wenn mir beim Vokabellernen langweilig ist, höre ich auf oder gebe mir keine Mühe mehr.",
      "labels": {
        "1": "(Fast) nie",
        "2": "Selten",
        "3": "Hin und wieder",
        "4": "Oft",
        "5": "(Fast) immer"
      }
    },
    {
      "name": "srl_19",
      "questionText":
          "Ich sorge dafür, dass beim Vokabellernen so wenige Ablenkungen wie möglich auftreten.",
      "labels": {
        "1": "(Fast) nie",
        "2": "Selten",
        "3": "Hin und wieder",
        "4": "Oft",
        "5": "(Fast) immer"
      }
    },
    {
      "name": "srl_20",
      "questionText": "Beim Vokabellernen ärgere ich mich.",
      "labels": {
        "1": "(Fast) nie",
        "2": "Selten",
        "3": "Hin und wieder",
        "4": "Oft",
        "5": "(Fast) immer"
      }
    },
    {
      "name": "srl_21",
      "questionText":
          "Ich weiß genau, wie oft oder an welchen Tagen ich Vokabeln lernen will.",
      "labels": {
        "1": "(Fast) nie",
        "2": "Selten",
        "3": "Hin und wieder",
        "4": "Oft",
        "5": "(Fast) immer"
      }
    },
    {
      "name": "srl_22",
      "questionText": "Ich denke einfach nicht daran, Vokabeln zu lernen.",
      "labels": {
        "1": "(Fast) nie",
        "2": "Selten",
        "3": "Hin und wieder",
        "4": "Oft",
        "5": "(Fast) immer"
      }
    },
    {
      "name": "srl_23",
      "questionText": "Zum Lernen von Vokabeln fehlt mir die Zeit.",
      "labels": {
        "1": "(Fast) nie",
        "2": "Selten",
        "3": "Hin und wieder",
        "4": "Oft",
        "5": "(Fast) immer"
      }
    },
    {
      "name": "srl_24",
      "questionText": "Beim Vokabellernen habe ich Spaß.",
      "labels": {
        "1": "(Fast) nie",
        "2": "Selten",
        "3": "Hin und wieder",
        "4": "Oft",
        "5": "(Fast) immer"
      }
    },
    {
      "name": "srl_25",
      "questionText":
          "Während ich Vokabeln lerne, schweifen meine Gedanken ab.",
      "labels": {
        "1": "(Fast) nie",
        "2": "Selten",
        "3": "Hin und wieder",
        "4": "Oft",
        "5": "(Fast) immer"
      }
    },
    {
      "name": "srl_26",
      "questionText":
          "Ich schiebe das Vokabellernen auf, sogar wenn es mir wichtig ist.",
      "labels": {
        "1": "(Fast) nie",
        "2": "Selten",
        "3": "Hin und wieder",
        "4": "Oft",
        "5": "(Fast) immer"
      }
    },
    {
      "name": "srl_27",
      "questionText":
          "Wenn ich beim Vokabellernen die Lust verliere, fällt es mir schwer, weiterzumachen.",
      "labels": {
        "1": "(Fast) nie",
        "2": "Selten",
        "3": "Hin und wieder",
        "4": "Oft",
        "5": "(Fast) immer"
      }
    },
    {
      "name": "srl_28",
      "questionText":
          "Nachdem ich Vokabeln gelernt habe, bin ich stolz auf mich.",
      "labels": {
        "1": "(Fast) nie",
        "2": "Selten",
        "3": "Hin und wieder",
        "4": "Oft",
        "5": "(Fast) immer"
      }
    },
    {
      "name": "srl_29",
      "questionText":
          "Ich sehe zu, dass ich alle möglichen Ablenkungen beseitige, bevor ich anfange, Vokabeln zu lernen.",
      "labels": {
        "1": "(Fast) nie",
        "2": "Selten",
        "3": "Hin und wieder",
        "4": "Oft",
        "5": "(Fast) immer"
      }
    }
  ]
};
