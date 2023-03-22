// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a de locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'de';

  static String m0(username) => "Dein Benutzername ist: ${username}";

  static String m1(number) =>
      "Glückwunsch, du hast weitere ${number} 💎 verdient!";

  static String m2(currentDay, maxDays) => "Tag ${currentDay} von ${maxDays}";

  static String m3(numDays) =>
      "Noch ${Intl.plural(numDays, one: '1 Tag', other: '${numDays} Tage')} bis zum nächsten Vokabeltest";

  static String m4(when) => "Wenn ich ${when}, dann lerne ich mit cabuu!";

  static String m5(number) =>
      "Glückwunsch, du hast deine ersten ${number} 💎 verdient!";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "accountManagement_clickToDeleteAccount":
            MessageLookupByLibrary.simpleMessage(
                "Klicke hier, falls du dein Konto löschen möchtest"),
        "accountManagement_deleteAccountExplanation":
            MessageLookupByLibrary.simpleMessage(
                "Du kannst hier deinen Account löschen. Wenn du das tust, werden alle deine Daten gelöscht und du kannst die App nicht mehr benutzen. Das Löschen passiert erst nach manueller Prüfung."),
        "accountManagement_deleteDialog_EnterPassword":
            MessageLookupByLibrary.simpleMessage(
                "Gib hier dein Passwort zur Bestätigung ein"),
        "accountManagement_deleteDialog_title":
            MessageLookupByLibrary.simpleMessage("Konto löschen?"),
        "accountManagement_invalidPassword":
            MessageLookupByLibrary.simpleMessage(
                "Das Passwort war nicht richtig"),
        "accountManagement_yourAccountName": m0,
        "congratsMoreDiamonds": m1,
        "consent_appuse": MessageLookupByLibrary.simpleMessage(
            "Ich habe die Datenschutzerklärung gelesen und bin damit einverstanden, dass mein Kind die App PROMPT-ADAPT unter den genannten Bedingungen verwendet."),
        "consent_readthis": MessageLookupByLibrary.simpleMessage(
            "Bitte lies dir die folgenden Informationen gemeinsam mit deinen Eltern sorgfältig durch."),
        "consent_study": MessageLookupByLibrary.simpleMessage(
            "Ich bin damit einverstanden, dass mein Kind an der Studie PROMP-ADAPT teilnimmt, und die Daten anonymisiert wissenschaftlich ausgewertet werden."),
        "copingPlanEnterP1": MessageLookupByLibrary.simpleMessage(
            "Wie könntest du dieses Hindernis **überwinden**? Notier hier, was du tun könntest:"),
        "dashboard_continueTomorrow": MessageLookupByLibrary.simpleMessage(
            "Morgen geht es weiter! Schaue ab 18 Uhr wieder vorbei."),
        "dashboard_daysOfTotal": m2,
        "dashboard_daysUntilVocabTest": m3,
        "dashboard_inFollowUpPhase": MessageLookupByLibrary.simpleMessage(
            "Du musst PROMPT jetzt nicht mehr täglich nutzen, aber wir benachrichtigen dich in drei Wochen nochmal für eine letzte Aufgabe"),
        "dashboard_mainmessage_beforeEvening":
            MessageLookupByLibrary.simpleMessage(
                "Heute Abend geht es weiter! Schaue ab 18 Uhr wieder vorbei."),
        "dashboard_mainmessage_firstday":
            MessageLookupByLibrary.simpleMessage("Morgen es richtig los"),
        "dashboard_nextVocabToday": MessageLookupByLibrary.simpleMessage(
            "Dein nächster Vokabeltest ist heute."),
        "dashboard_nextVocabTomorrow": MessageLookupByLibrary.simpleMessage(
            "Dein nächster Vokabeltest ist morgen."),
        "dashboard_studyCompletelyFinished": MessageLookupByLibrary.simpleMessage(
            "Danke, dass du so toll mitgemacht hast! Du kannst diese App jetzt deinstallieren"),
        "emojiInternalisation_createPlan": MessageLookupByLibrary.simpleMessage(
            "Erstelle aus Emojis eine Darstellung deines Planes"),
        "general_buttonTexts_cancel":
            MessageLookupByLibrary.simpleMessage("Abbrechen"),
        "general_buttonTexts_confirm":
            MessageLookupByLibrary.simpleMessage("Bestätigen"),
        "general_buttonTexts_logout":
            MessageLookupByLibrary.simpleMessage("Ausloggen"),
        "instructionsCabuu2Finish": MessageLookupByLibrary.simpleMessage(
            "Komme hierher zurück und klicke auf “Weiter”, wenn du damit fertig bist."),
        "instructionsCabuu2Paragraph1": MessageLookupByLibrary.simpleMessage(
            "In unserer Studie sollst du cabuu auf eine ganz bestimmte Art benutzen - wie, erklären wir in unserem Video. Schaue es auf einem anderen Gerät (z. B. Computer) an, damit du cabuu gleichzeitig auf deinem Handy installieren kannst. Den Link zum Video haben deine Eltern per E-Mail erhalten."),
        "instructionsCabuuLink":
            MessageLookupByLibrary.simpleMessage("Hier ist der Link noch mal:"),
        "instructionsCabuuWriteCode": MessageLookupByLibrary.simpleMessage(
            "Um cabuu freizuschalten, brauchst du gleich diesen Code:"),
        "instructionsCabuuWriteDate": MessageLookupByLibrary.simpleMessage(
            "Außerdem brauchst du dieses Datum:"),
        "instructionsDistributedp1": MessageLookupByLibrary.simpleMessage(
            "Beim Vokabellernen kann man Strategien anwenden, die einem beim Lernen und Erinnern helfen. Auf der nächsten Seite siehst du ein Video, in dem eine solche Strategie und ihre Vorteile erklärt werden."),
        "instructionsQuestionnaires_p1": MessageLookupByLibrary.simpleMessage(
            "TODO: Hier eine tolle Erklärung zum Fragebögen ausfüllen."),
        "introductionTakeYourTime": MessageLookupByLibrary.simpleMessage(
            "Auf der nächsten Seite geben wir dir erst einmal eine Einführung. Nimm dir dafür ein paar Minuten Zeit."),
        "labelTextWriteDownBulletPoints": MessageLookupByLibrary.simpleMessage(
            "Schreibe deine Antwort hier auf"),
        "notificationBody_final": MessageLookupByLibrary.simpleMessage(
            "Nimm jetzt an der PROMPT-Abschlussbefragung teil und sichere dir die letzten 💎"),
        "notificationMessage_daily": MessageLookupByLibrary.simpleMessage(
            "Mache jetzt weiter mit PROMPT!"),
        "notificationMessage_vocabTest": MessageLookupByLibrary.simpleMessage(
            "Denk daran, heute den Test in cabuu zu machen!"),
        "notificationTitle_final": MessageLookupByLibrary.simpleMessage(
            "Wir haben noch ein paar Fragen an dich!"),
        "obstacleEnterP1": MessageLookupByLibrary.simpleMessage(
            "Was sind **Hindernisse**, die dich im Alltag davon abhalten, regelmäßig Vokabeln zu lernen? Notiere hier das Hindernis, das dir am meisten im Weg steht:"),
        "obstacleOutcomeHelperText":
            MessageLookupByLibrary.simpleMessage("Stichworte genügen"),
        "outcomeEnterP1": MessageLookupByLibrary.simpleMessage(
            "Denk mal nach: Was wäre für dich persönlich das **Beste** daran, viele Vokabeln zu kennen und eine andere Sprache richtig gut zu sprechen? Notiere deine Antwort in ein paar Stichworten:"),
        "planCreation_completeThePlan":
            MessageLookupByLibrary.simpleMessage("Vervollständige den Plan:"),
        "planCreation_letsCreatePlan": MessageLookupByLibrary.simpleMessage(
            "Erstelle jetzt deinen ersten Plan!"),
        "planCreation_whenAndWhere": MessageLookupByLibrary.simpleMessage(
            "Wann und wo könntest du morgen gut Vokabeln lernen?"),
        "planInputIfI": MessageLookupByLibrary.simpleMessage("Wenn ich"),
        "planInputP1": MessageLookupByLibrary.simpleMessage(
            "**Wann** und **wo** könntest du morgen Vokabeln lernen??"),
        "planInputThenILearnWithCabuu":
            MessageLookupByLibrary.simpleMessage("dann lerne ich mit cabuu!"),
        "planPlaceHolder": m4,
        "planTimingChangeP1": MessageLookupByLibrary.simpleMessage(
            "Wenn du die Benachrichtigung zu einer anderen Uhrzeit erhalten möchtest, kannst du das hier einstellen."),
        "planTimingParagraph1": MessageLookupByLibrary.simpleMessage(
            "Ab morgen sollst du die App PROMPT-ADAPT jeden Abend einmal benutzen; das dauert auch nur 3 Minuten."),
        "planTimingParagraph2": MessageLookupByLibrary.simpleMessage(
            "Zur Erinnerung senden wir dir jeden Abend um 18 Uhr eine Benachrichtigung. Wenn du sie später erhalten möchtest, kannst du das hier einstellen."),
        "rewards1p1": m5,
        "rewards1p2": MessageLookupByLibrary.simpleMessage(
            "Jetzt haben wir erst mal ein paar Fragen an dich."),
        "rewards1p3": MessageLookupByLibrary.simpleMessage(
            "Bitte beantworte alle Fragen ehrlich. Dir entstehen dadurch keine Nachteile."),
        "time": MessageLookupByLibrary.simpleMessage("Uhrzeit"),
        "welcome":
            MessageLookupByLibrary.simpleMessage("Willkommen bei PROMPT-ADAPT!")
      };
}
