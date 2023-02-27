import 'package:intl/intl.dart';

class AppStrings {
  // Idle Screen
  static const String ChangeBackground = "Hintergrund ändern";

  static String daysParticipated(int days) {
    String dayString = days == 1 ? "Tag" : "Tage";
    return "$days $dayString insgesamt an der Studie teilgenommen";
  }

  static String daysConsecutive(int days) {
    String dayString = days == 1 ? "Tag" : "Tage";
    return "$days $dayString Tage in Folge mitgemacht";
  }

  static String daysOfTotal(int days, int max) {
    return "Tag $days von $max";
  }

  static String progressToReward(int days, int max) {
    return "Fortschritt zur nächsten Belohnung: $days / $max";
  }

  // Onboarding Cabuu Link
  static const String CabuuLink_WantToParticipate =
      "Ja, ich möchte an der Studie teilnehmen.";
  static const String CabuuLink_EnterEmail =
      "Gib hier die E-Mail-Adresse ein, mit der du bei cabuu angemeldet bist";
  static const String CabuuLink_EnterUsername =
      "Falls du bei cabuu auch mit einem Benutzernamen angemeldet bist, gib diesen bitte hier ein";

  // Onboarding Plan Creation
  static const String PlanCreation_LetsCreatePlan =
      "Erstelle jetzt deinen ersten Plan!";
  static const String PlanCreation_PlanCreationExplanation =
      "Wann und wo könntest du morgen gut Vokabeln lernen?";
  static const String PlanCreation_CompleteThePlan =
      "Vervollständige den Plan:";
  static const String ThinkOfSomething =
      "Überlege dir etwas, das du jeden Tag tust, möglichst auch am Wochenende. Schreibe es in 1-3 Stichworten auf:";
  static const String GotTimeBeforeOrAfter =
      "Hast du davor oder danach direkt Zeit, um mit cabuu zu lernen?";
  static const String Before = "Davor";
  static const String After = "Danach";
  static const String Neither = "Weder noch";

  // Onboarding Plan Display
  static const String PlanDisplay_Excellent = "Prima!";
  static const String PlanDisplay_YourPlanIs = "Dein Plan lautet also:";
  static const String PlanDisplay_RememberYourPlan = "Merke dir den Plan gut!";

  // Onboarding Why Vocabulary Learning Screen
  static const String WhyVocab_ParagraphOne =
      "In der Studie PROMPT wollen wir dir dabei helfen, Vokabeln so zu lernen, dass du sie dir besonders gut merken kannst.";
  static const String WhyVocab_ParagraphTwo =
      "Denk mal nach: Warum ist es für dich wichtig, Englischvokabeln zu lernen? Wie könnte es für dich auch außerhalb der Schule gut sein, viele Englischvokabeln zu kennen?";

  static const String GoalIntention_ParagraphOne =
      "Damit du es schaffst, regelmäßig Vokabeln zu lernen, solltest du dir ein **Ziel** setzen";
  static const String GoalIntention_ParagraphTwo =
      "Nimm dir jetzt vor, jeden Tag ein paar Vokabeln mit cabuu zu lernen. Denk dran: Du musst auch gar nicht lange lernen.";
  static const String GoalIntention_SayToYourself = "Sag zu dir selbst:";
  static const String GoalIntention_Plan =
      '"Ich will jeden Tag ein paar Vokabeln mit cabuu lernen"';

  // Goal Intention
  static const String HelpLearnVocabulary =
      "In der Studie PROMPT wollen wir dir dabei helfen, Vokabeln so zu lernen, dass du sie dir besonders gut merken kannst.";
  static const String ThinkAboutWhy =
      "Denk mal nach: Warum ist es für dich wichtig, Vokabeln zu lernen? Wie könnte es für dich in Zukunft von Vorteil sein, viele Vokabeln gelernt zu haben?";
  static const String WriteYourResponse =
      "Schreibe deine Antwort hier auf (Stichworte genügen):";

  // Internalisation Screen
  static const Internalisation_ThinkAboutYourGoal = "Denke an dein Ziel:";
  static const Internalisation_ToReachYourGoal =
      "Um dein Ziel zu erreichen, hast du folgenden Plan:";

  // Shared Across Many Screens
  static const String Continue = "Weiter";

  // Emoji Internalisation Screen
  static const String EmojiInternalisation_Instruction =
      "Erstelle aus Emojis eine Darstellung deines Planes";

  // Study Info Screen
  static const String InfoScreen_Header1 = "Über PROMPT";
  static const String InfoScreen_Body1 =
      "PROMPT ist eine Studie des *DIPF | Leibniz-Institut für Bildungsforschung und Bildungsinformation*. Mit deiner Hilfe wollen wir herausfinden, wie wir Kinder am besten beim Lernen mit Apps unterstützen können. Deshalb stellen wir dir während der Studie einige Fragen dazu, wie du Vokabeln lernst. Außerdem stellen wir dir Aufgaben. Zum Beispiel sollst du dir für das Monster Lernpläne merken. Dabei ist es wichtig, dass du dich bei den Aufgaben richtig anstrengst und alle Fragen ehrlich beantwortest.";
  static const String InfoScreen_Header2 = "Belohnung";
  static const String InfoScreen_Body2 =
      """In dieser App bekommst du 💎 als Belohnung wenn du an einem Tag **alle** Aufgaben erledigst. 
      Das heißt, dass du dir an jedem Tag **morgens den Plan merken** und **abends die Erinnerungsaufgabe** abschließen musst, damit du 💎 bekommst. Für deine 💎 bekommst du am Ende einen Gutschein und zwar mit mehr Guthaben, je mehr 💎 du gesammelt hast! Insgesamt bis zu 12 Euro. 
      Deine 💎 dienen außerdem als Lose in unserem Gewinnspiel, bei dem du zusätzlich 25€ Guthaben für einen Gutschein gewinnen kannst.""";
  static const String InfoScreen_Header3 = "Wie lange dauert die Studie?";
  static const String InfoScreen_Body3 =
      "Die Studie dauert insgesamt 28 Tage. Am ersten Tag, an dem du in die Studie eingeführt wirst, dauert es ungefähr 15-20 Minuten. An den darauffolgenden 27 Tage sollst du die App PROMPT dann zweimal täglich benutzen: Einmal möglichst schon morgens und das zweite Mal 6 Stunden später. Die App erinnert dich daran. Das dauert dann auch nur noch ungefähr 5 Minuten pro Tag.";
  static const String InfoScreen_Header4 = "Freiwilligkeit & Datenschutz";
  static const String InfoScreen_Body4 =
      "Du entscheidest selbst, ob du an der Studie teilnehmen möchtest. Du kannst jederzeit aufhören und musst das auch nicht begründen. Dir entstehen dadurch keine Nachteile. Die Angaben, die du während der Studie machst, werden von uns verschlüsselt. Das bedeutet, dass anstelle deines Namens eine Codenummer verwendet wird, sodass niemand weiß, dass das deine Daten sind. Bei Fragen kannst du dich jederzeit an uns wenden. Schreibe uns dazu eine E-Mail an prompt@idea-frankfurt.eu";

  static const String LoginScreen_EnterCode = "Code eingeben";

  static const String BoosterPrompt_Header = "BOOSTER PROMPT!";
  static const String BoosterPrompt_Text =
      "Denk daran, dass du dir die Vokabeln am besten merken kannst, wenn du jeden Tag lernst!";

  // DASHBOARD
  static const String Dashboard_Continue_After_Cabuu =
      "Drücke hier, sobald du heute mit cabuu gelernt hast.";
  static const String Dashboard_ContinueTomorrow =
      "Komme morgen früh hierher zurück und mache weiter.";
  static const String Dashboard_StartTomorrow = "Morgen geht es richtig los";
  static const String Dashboard_MainMessage_FirstDay =
      "Morgen geht es richtig los!";
  static const String Dashboard_MainMessage_BeforeEvening =
      "Heute Abend geht es weiter! Schaue ab 18 Uhr wieder vorbei.";
  static const String Dashboard_ClickAfterVocabTest =
      "Drücke hier, wenn du deinen Vokabeltest erledigt hast";

  static const String MorningAssessment_FirstDay_Screen1_1 =
      "Benutze PROMPT ab jetzt **jeden Tag** und zwar am besten schon **morgens**. Die ersten Fragen sollst du nämlich beantworten, **bevor** du mit cabuu lernst.";
  static const String MorningAssessment_FirstDay_Screen1_2 =
      "An Tagen, an denen du mit cabuu gelernt hast, benutzt du PROMPT **danach noch einmal**. An Tagen, an denen du nicht mit cabuu gelernt hast, benutzt du PROMPT erst wieder am nächsten Tag.";

  static const String MorningAssessment_FirstDay_Screen2_1 =
      'Du solltest bereits in cabuu den Lernplan für Liste 1 angelegt haben. Klicke auf "Weiter", wenn du das gemacht hast.';
  // ignore: non_constant_identifier_names
  static String MorningAssessment_FirstDay_Screen2_2(DateTime datetime) {
    var format = new DateFormat("dd.MM.yyyy");
    var targetDate = format.format(datetime);
    return '**Falls du den Lernplan noch nicht erstellt hast**: Klicke in cabuu auf Liste 1 und wähle "Lernplan". Gib als End-Datum ein: $targetDate';
  }

  static const String MorningAssessment_lastVocab1_1 =
      'Heute sollst du in cabuu den letzten Test machen. Klicke dazu in cabuu auf Liste 6 und wähle "Abfrage".';
  static const String MorningAssessment_lastVocab1_2 =
      'Mach bitte den Test und komm danach direkt zurück zu PROMPT, um die letzten Fragen zu beantworten. Danach bist du fertig mit der Studie.';

  static const String Login_ForgotPassword =
      "Passwort vergessen? Klicke hier und wir erklären dir, was zu tun ist.";
}
