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

  // Session Zero Welcome Screen
  static const String Welcome_WelcomeToPROMPT = "Willkommen bei PROMPT!";
  static const String Welcome_IntroductionTakeYourTime =
      "Auf der nächsten Seite geben wir dir erst einmal eine Einführung. Nimm dir dafür ein paar Minuten Zeit.";

  // Session Zero Cabuu Link
  static const String CabuuLink_WantToParticipate =
      "Ja, ich möchte an der Studie teilnehmen.";
  static const String CabuuLink_EnterEmail =
      "Gib hier die E-Mail-Adresse ein, mit der du bei cabuu angemeldet bist";
  static const String CabuuLink_EnterUsername =
      "Falls du bei cabuu auch mit einem Benutzernamen angemeldet bist, gib diesen bitte hier ein";

  // Session Zero Plan Creation
  static const String PlanCreation_LetsCreatePlan =
      "Erstelle jetzt für dich selbst einen Plan.\nÜberlege dir einen Zeitpunkt oder Ort, der möglichst jeden Tag passt, um mit cabuu zu lernen (z.B. morgens nach dem Zähneputzen, mittags an der Bushaltestelle).\nVervollständige den Plan:";
  static const String ThinkOfSomething =
      "Überlege dir etwas, das du jeden Tag tust, möglichst auch am Wochenende. Schreibe es in 1-3 Stichworten auf:";
  static const String GotTimeBeforeOrAfter =
      "Hast du davor oder danach direkt Zeit, um mit cabuu zu lernen?";
  static const String Before = "Davor";
  static const String After = "Danach";
  static const String Neither = "Weder noch";

  // Session Zero Plan Display
  static const String PlanDisplay_Excellent = "Prima!";
  static const String PlanDisplay_YourPlanIs = "Dein Plan lautet also:";
  static const String PlanDisplay_RememberYourPlan = "Merke dir den Plan gut!";

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

  //Session Zero  Mascot Selection
  static const String SelectionOfMascot =
      "Hier kannst du dir ein Monster auswählen, das dich im Laufe der Studie begleiten wird. Welches Monster du auswählst, macht für den weiteren Verlauf keinen Unterschied, und es ist nur dafür da, um dich zu motivieren. Wähle also einfach das Monster aus, das dir am besten gefällt.";
  static const String ThinkAboutYourGoal = "Denke an dein Ziel:";

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

  static const String NoTask_Continue_After_Cabuu =
      "Drücke hier, sobald du heute mit cabuu gelernt hast";
  static const String NoTask_ContinueTomorrow =
      "Komme morgen früh hierher zurück und mache weiter";
}
