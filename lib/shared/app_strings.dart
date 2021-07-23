class AppStrings {
  // Idle Screen
  static const String ChangeBackground = "Hintergrund ändern";
  static const String ProgressToReward = "Fortschritt zur nächsten Belohnung";
  static String daysParticipated(int days) {
    String dayString = days == 1 ? "Tag" : "Tage";
    return "$days $dayString insgesamt mitgemacht";
  }

  static String daysConsecutive(int days) {
    String dayString = days == 1 ? "Tag" : "Tage";
    return "$days $dayString Tage in Folge mitgemacht";
  }

  static String daysOfTotal(int days, int max) {
    return "Tag $days von $max";
  }

  // Plan Creation
  static const String LetsCreatePlan =
      "Lass uns jetzt zusammen einen Plan erstellen";
  static const String ThinkOfSomething =
      "Überlege dir etwas, das du jeden Tag tust, möglichst auch am Wochenende. Schreibe es in 1-3 Stichworten auf:";
  static const String GotTimeBeforeOrAfter =
      "Hast du davor oder danach direkt Zeit, um mit cabuu zu lernen?";
  static const String Before = "Davor";
  static const String After = "Danach";
  static const String Neither = "Weder noch";

  // Shared Across Many Screens
  static const String Continue = "Weiter";

  // Mascot Selection
  static const String SelectionOfMascot = "Auswahl des Monsters";
  static const String ThinkAboutYourGoal = "Denk an dein Ziel:";

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
}
