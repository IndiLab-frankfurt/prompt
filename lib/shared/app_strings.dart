class AppStrings {
  static String daysParticipated(int days) {
    String dayString = days == 1 ? "Tag" : "Tage";
    return "$days $dayString insgesamt an der Studie teilgenommen";
  }

  static String daysConsecutive(int days) {
    String dayString = days == 1 ? "Tag" : "Tage";
    return "$days $dayString Tage in Folge mitgemacht";
  }

  static String progressToReward(int days, int max) {
    return "Fortschritt zur nächsten Belohnung: $days / $max";
  }

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
      "Du entscheidest selbst, ob du an der Studie teilnehmen möchtest. Du kannst jederzeit aufhören und musst das auch nicht begründen. Dir entstehen dadurch keine Nachteile. Die Angaben, die du während der Studie machst, werden von uns verschlüsselt. Das bedeutet, dass anstelle deines Namens eine Codenummer verwendet wird, sodass niemand weiß, dass das deine Daten sind. Bei Fragen kannst du dich jederzeit an uns wenden. Schreibe uns dazu eine E-Mail an **prompt@idea-frankfurt.eu**";

  static const String LoginScreen_EnterCode = "Code eingeben";

  static const String BoosterPrompt_Header = "BOOSTER PROMPT!";
  static const String BoosterPrompt_Text =
      "Denk daran, dass du dir die Vokabeln am besten merken kannst, wenn du jeden Tag lernst!";

  static const String Login_ForgotPassword =
      "Passwort vergessen? Klicke hier und wir erklären dir, was zu tun ist.";
}
