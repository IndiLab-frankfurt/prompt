// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Willkommen bei PROMPT-ADAPT!`
  String get welcome {
    return Intl.message(
      'Willkommen bei PROMPT-ADAPT!',
      name: 'welcome',
      desc: '',
      args: [],
    );
  }

  /// `Auf der nächsten Seite geben wir dir erst einmal eine Einführung. Nimm dir dafür ein paar Minuten Zeit.`
  String get introductionTakeYourTime {
    return Intl.message(
      'Auf der nächsten Seite geben wir dir erst einmal eine Einführung. Nimm dir dafür ein paar Minuten Zeit.',
      name: 'introductionTakeYourTime',
      desc: '',
      args: [],
    );
  }

  /// `Glückwunsch, du hast weitere {number} 💎 verdient!`
  String congratsMoreDiamonds(String number) {
    return Intl.message(
      'Glückwunsch, du hast weitere $number 💎 verdient!',
      name: 'congratsMoreDiamonds',
      desc: '',
      args: [number],
    );
  }

  /// `Glückwunsch, du hast deine ersten {number} 💎 verdient!`
  String rewards1p1(String number) {
    return Intl.message(
      'Glückwunsch, du hast deine ersten $number 💎 verdient!',
      name: 'rewards1p1',
      desc: '',
      args: [number],
    );
  }

  /// `Wenn ich {when}, dann lerne ich mit cabuu!`
  String planPlaceHolder(String when) {
    return Intl.message(
      'Wenn ich $when, dann lerne ich mit cabuu!',
      name: 'planPlaceHolder',
      desc: '',
      args: [when],
    );
  }

  /// `Schreibe deine Antwort hier auf.`
  String get labelTextWriteDownBulletPoints {
    return Intl.message(
      'Schreibe deine Antwort hier auf.',
      name: 'labelTextWriteDownBulletPoints',
      desc: '',
      args: [],
    );
  }

  /// `Stichworte genügen`
  String get obstacleOutcomeHelperText {
    return Intl.message(
      'Stichworte genügen',
      name: 'obstacleOutcomeHelperText',
      desc: '',
      args: [],
    );
  }

  /// `Jetzt haben wir erst mal ein paar Fragen an dich.`
  String get rewards1p2 {
    return Intl.message(
      'Jetzt haben wir erst mal ein paar Fragen an dich.',
      name: 'rewards1p2',
      desc: '',
      args: [],
    );
  }

  /// `Bitte beantworte alle Fragen ehrlich. Dir entstehen dadurch keine Nachteile.`
  String get rewards1p3 {
    return Intl.message(
      'Bitte beantworte alle Fragen ehrlich. Dir entstehen dadurch keine Nachteile.',
      name: 'rewards1p3',
      desc: '',
      args: [],
    );
  }

  /// `Ab morgen sollst du die App PROMPT-ADAPT jeden Abend einmal benutzen; das dauert auch nur 3 Minuten.`
  String get planTimingParagraph1 {
    return Intl.message(
      'Ab morgen sollst du die App PROMPT-ADAPT jeden Abend einmal benutzen; das dauert auch nur 3 Minuten.',
      name: 'planTimingParagraph1',
      desc: '',
      args: [],
    );
  }

  /// `Zur Erinnerung senden wir dir jeden Abend um 18 Uhr eine Benachrichtigung. Wenn du sie später erhalten möchtest, kannst du das hier einstellen.`
  String get planTimingParagraph2 {
    return Intl.message(
      'Zur Erinnerung senden wir dir jeden Abend um 18 Uhr eine Benachrichtigung. Wenn du sie später erhalten möchtest, kannst du das hier einstellen.',
      name: 'planTimingParagraph2',
      desc: '',
      args: [],
    );
  }

  /// `Heute und im Laufe der Studie werden wir dir einige Fragen stellen.`
  String get instructionsQuestionnaires_p1 {
    return Intl.message(
      'Heute und im Laufe der Studie werden wir dir einige Fragen stellen.',
      name: 'instructionsQuestionnaires_p1',
      desc: '',
      args: [],
    );
  }

  /// `Meistens zeigen wir dir eine Aussage, z.B.: Ich lerne gerne Vokabeln.`
  String get instructionsQuestionnaires_p2 {
    return Intl.message(
      'Meistens zeigen wir dir eine Aussage, z.B.: Ich lerne gerne Vokabeln.',
      name: 'instructionsQuestionnaires_p2',
      desc: '',
      args: [],
    );
  }

  /// `Überlege, wie sehr die Aussage auf **dich persönlich** zutrifft und wähle die passende Antwort:`
  String get instructionsQuestionnaires_p3 {
    return Intl.message(
      'Überlege, wie sehr die Aussage auf **dich persönlich** zutrifft und wähle die passende Antwort:',
      name: 'instructionsQuestionnaires_p3',
      desc: '',
      args: [],
    );
  }

  /// ` - Gar nicht \n - Eher nicht \n - Teils/teils \n - Eher ja \n - Voll und ganz`
  String get instructionsQuestionnaires_p4 {
    return Intl.message(
      ' - Gar nicht \n - Eher nicht \n - Teils/teils \n - Eher ja \n - Voll und ganz',
      name: 'instructionsQuestionnaires_p4',
      desc: '',
      args: [],
    );
  }

  /// `Wenn die Aussage z.B. eher auf dich zutrifft, wähle “eher ja”. Wenn die Aussage perfekt auf dich zutrifft, wähle “voll und ganz“.`
  String get instructionsQuestionnaires_p5 {
    return Intl.message(
      'Wenn die Aussage z.B. eher auf dich zutrifft, wähle “eher ja”. Wenn die Aussage perfekt auf dich zutrifft, wähle “voll und ganz“.',
      name: 'instructionsQuestionnaires_p5',
      desc: '',
      args: [],
    );
  }

  /// `In unserer Studie sollst du cabuu auf eine ganz bestimmte Art benutzen - wie, erklären wir in unserem Video. Schaue es auf einem anderen Gerät (z. B. Computer) an, damit du cabuu gleichzeitig auf deinem Handy installieren kannst. Den Link zum Video haben deine Eltern per E-Mail erhalten.`
  String get instructionsCabuu2Paragraph1 {
    return Intl.message(
      'In unserer Studie sollst du cabuu auf eine ganz bestimmte Art benutzen - wie, erklären wir in unserem Video. Schaue es auf einem anderen Gerät (z. B. Computer) an, damit du cabuu gleichzeitig auf deinem Handy installieren kannst. Den Link zum Video haben deine Eltern per E-Mail erhalten.',
      name: 'instructionsCabuu2Paragraph1',
      desc: '',
      args: [],
    );
  }

  /// `Hier ist der Link noch mal:`
  String get instructionsCabuuLink {
    return Intl.message(
      'Hier ist der Link noch mal:',
      name: 'instructionsCabuuLink',
      desc: '',
      args: [],
    );
  }

  /// `Um cabuu freizuschalten, brauchst du gleich diesen Code:`
  String get instructionsCabuuWriteCode {
    return Intl.message(
      'Um cabuu freizuschalten, brauchst du gleich diesen Code:',
      name: 'instructionsCabuuWriteCode',
      desc: '',
      args: [],
    );
  }

  /// `Außerdem brauchst du dieses Datum:`
  String get instructionsCabuuWriteDate {
    return Intl.message(
      'Außerdem brauchst du dieses Datum:',
      name: 'instructionsCabuuWriteDate',
      desc: '',
      args: [],
    );
  }

  /// `Komme hierher zurück und klicke auf “Weiter”, wenn du damit fertig bist.`
  String get instructionsCabuu2Finish {
    return Intl.message(
      'Komme hierher zurück und klicke auf “Weiter”, wenn du damit fertig bist.',
      name: 'instructionsCabuu2Finish',
      desc: '',
      args: [],
    );
  }

  /// `Beim Vokabellernen kann man Strategien anwenden, die einem beim Lernen und Erinnern helfen. Auf der nächsten Seite siehst du ein Video, in dem eine solche Strategie und ihre Vorteile erklärt werden.`
  String get instructionsDistributedp1 {
    return Intl.message(
      'Beim Vokabellernen kann man Strategien anwenden, die einem beim Lernen und Erinnern helfen. Auf der nächsten Seite siehst du ein Video, in dem eine solche Strategie und ihre Vorteile erklärt werden.',
      name: 'instructionsDistributedp1',
      desc: '',
      args: [],
    );
  }

  /// `Was sind **Hindernisse**, die dich im Alltag davon abhalten, regelmäßig Vokabeln zu lernen? Notiere hier das Hindernis, das dir am meisten im Weg steht:`
  String get obstacleEnterP1 {
    return Intl.message(
      'Was sind **Hindernisse**, die dich im Alltag davon abhalten, regelmäßig Vokabeln zu lernen? Notiere hier das Hindernis, das dir am meisten im Weg steht:',
      name: 'obstacleEnterP1',
      desc: '',
      args: [],
    );
  }

  /// `Denk mal nach: Was wäre für dich persönlich das **Beste** daran, viele Vokabeln zu kennen und eine andere Sprache richtig gut zu sprechen? Notiere deine Antwort in ein paar Stichworten:`
  String get outcomeEnterP1 {
    return Intl.message(
      'Denk mal nach: Was wäre für dich persönlich das **Beste** daran, viele Vokabeln zu kennen und eine andere Sprache richtig gut zu sprechen? Notiere deine Antwort in ein paar Stichworten:',
      name: 'outcomeEnterP1',
      desc: '',
      args: [],
    );
  }

  /// `Wie könntest du dieses Hindernis **überwinden**? Notier hier, was du tun könntest:`
  String get copingPlanEnterP1 {
    return Intl.message(
      'Wie könntest du dieses Hindernis **überwinden**? Notier hier, was du tun könntest:',
      name: 'copingPlanEnterP1',
      desc: '',
      args: [],
    );
  }

  /// `**Wann** und **wo** könntest du morgen Vokabeln lernen?`
  String get planInputP1 {
    return Intl.message(
      '**Wann** und **wo** könntest du morgen Vokabeln lernen?',
      name: 'planInputP1',
      desc: '',
      args: [],
    );
  }

  /// `Wenn ich`
  String get planInputIfI {
    return Intl.message(
      'Wenn ich',
      name: 'planInputIfI',
      desc: '',
      args: [],
    );
  }

  /// `dann lerne ich mit cabuu!`
  String get planInputThenILearnWithCabuu {
    return Intl.message(
      'dann lerne ich mit cabuu!',
      name: 'planInputThenILearnWithCabuu',
      desc: '',
      args: [],
    );
  }

  /// `Wenn du die Benachrichtigung zu einer anderen Uhrzeit erhalten möchtest, kannst du das hier einstellen.`
  String get planTimingChangeP1 {
    return Intl.message(
      'Wenn du die Benachrichtigung zu einer anderen Uhrzeit erhalten möchtest, kannst du das hier einstellen.',
      name: 'planTimingChangeP1',
      desc: '',
      args: [],
    );
  }

  /// `Uhrzeit`
  String get time {
    return Intl.message(
      'Uhrzeit',
      name: 'time',
      desc: '',
      args: [],
    );
  }

  /// `Erstelle jetzt deinen ersten Plan!`
  String get planCreation_letsCreatePlan {
    return Intl.message(
      'Erstelle jetzt deinen ersten Plan!',
      name: 'planCreation_letsCreatePlan',
      desc: '',
      args: [],
    );
  }

  /// `Wann und wo könntest du morgen gut Vokabeln lernen?`
  String get planCreation_whenAndWhere {
    return Intl.message(
      'Wann und wo könntest du morgen gut Vokabeln lernen?',
      name: 'planCreation_whenAndWhere',
      desc: '',
      args: [],
    );
  }

  /// `Vervollständige den Plan:`
  String get planCreation_completeThePlan {
    return Intl.message(
      'Vervollständige den Plan:',
      name: 'planCreation_completeThePlan',
      desc: '',
      args: [],
    );
  }

  /// `Bitte lies dir die folgenden Informationen gemeinsam mit deinen Eltern sorgfältig durch.`
  String get consent_readthis {
    return Intl.message(
      'Bitte lies dir die folgenden Informationen gemeinsam mit deinen Eltern sorgfältig durch.',
      name: 'consent_readthis',
      desc: '',
      args: [],
    );
  }

  /// `Ich habe die Datenschutzerklärung gelesen und bin damit einverstanden, dass mein Kind die App PROMPT-ADAPT unter den genannten Bedingungen verwendet.`
  String get consent_appuse {
    return Intl.message(
      'Ich habe die Datenschutzerklärung gelesen und bin damit einverstanden, dass mein Kind die App PROMPT-ADAPT unter den genannten Bedingungen verwendet.',
      name: 'consent_appuse',
      desc: '',
      args: [],
    );
  }

  /// `Ich bin damit einverstanden, dass mein Kind an der Studie PROMPT-ADAPT teilnimmt, und die Daten anonymisiert wissenschaftlich ausgewertet werden.`
  String get consent_study {
    return Intl.message(
      'Ich bin damit einverstanden, dass mein Kind an der Studie PROMPT-ADAPT teilnimmt, und die Daten anonymisiert wissenschaftlich ausgewertet werden.',
      name: 'consent_study',
      desc: '',
      args: [],
    );
  }

  /// `Morgen es richtig los`
  String get dashboard_mainmessage_firstday {
    return Intl.message(
      'Morgen es richtig los',
      name: 'dashboard_mainmessage_firstday',
      desc: '',
      args: [],
    );
  }

  /// `Morgen geht es weiter! Schaue ab 18 Uhr wieder vorbei.`
  String get dashboard_continueTomorrow {
    return Intl.message(
      'Morgen geht es weiter! Schaue ab 18 Uhr wieder vorbei.',
      name: 'dashboard_continueTomorrow',
      desc: '',
      args: [],
    );
  }

  /// `Heute Abend geht es weiter! Schaue ab 18 Uhr wieder vorbei.`
  String get dashboard_mainmessage_beforeEvening {
    return Intl.message(
      'Heute Abend geht es weiter! Schaue ab 18 Uhr wieder vorbei.',
      name: 'dashboard_mainmessage_beforeEvening',
      desc: '',
      args: [],
    );
  }

  /// `Dein nächster Vokabeltest ist heute.`
  String get dashboard_nextVocabToday {
    return Intl.message(
      'Dein nächster Vokabeltest ist heute.',
      name: 'dashboard_nextVocabToday',
      desc: '',
      args: [],
    );
  }

  /// `Dein nächster Vokabeltest ist morgen.`
  String get dashboard_nextVocabTomorrow {
    return Intl.message(
      'Dein nächster Vokabeltest ist morgen.',
      name: 'dashboard_nextVocabTomorrow',
      desc: '',
      args: [],
    );
  }

  /// `Noch {numDays, plural, =1{1 Tag} other{{numDays} Tage}} bis zum nächsten Vokabeltest`
  String dashboard_daysUntilVocabTest(num numDays) {
    return Intl.message(
      'Noch ${Intl.plural(numDays, one: '1 Tag', other: '$numDays Tage')} bis zum nächsten Vokabeltest',
      name: 'dashboard_daysUntilVocabTest',
      desc: '',
      args: [numDays],
    );
  }

  /// `Danke, dass du so toll mitgemacht hast! Du kannst diese App jetzt deinstallieren.`
  String get dashboard_studyCompletelyFinished {
    return Intl.message(
      'Danke, dass du so toll mitgemacht hast! Du kannst diese App jetzt deinstallieren.',
      name: 'dashboard_studyCompletelyFinished',
      desc: '',
      args: [],
    );
  }

  /// `Du musst PROMPT jetzt nicht mehr täglich nutzen, aber wir benachrichtigen dich in drei Wochen nochmal für eine letzte Aufgabe.`
  String get dashboard_inFollowUpPhase {
    return Intl.message(
      'Du musst PROMPT jetzt nicht mehr täglich nutzen, aber wir benachrichtigen dich in drei Wochen nochmal für eine letzte Aufgabe.',
      name: 'dashboard_inFollowUpPhase',
      desc: '',
      args: [],
    );
  }

  /// `Tag {currentDay} von {maxDays}`
  String dashboard_daysOfTotal(num currentDay, num maxDays) {
    return Intl.message(
      'Tag $currentDay von $maxDays',
      name: 'dashboard_daysOfTotal',
      desc: '',
      args: [currentDay, maxDays],
    );
  }

  /// `Mache jetzt weiter mit PROMPT!`
  String get notificationMessage_daily {
    return Intl.message(
      'Mache jetzt weiter mit PROMPT!',
      name: 'notificationMessage_daily',
      desc: '',
      args: [],
    );
  }

  /// `Denk daran, heute den Test in cabuu zu machen!`
  String get notificationMessage_vocabTest {
    return Intl.message(
      'Denk daran, heute den Test in cabuu zu machen!',
      name: 'notificationMessage_vocabTest',
      desc: '',
      args: [],
    );
  }

  /// `Wir haben noch ein paar Fragen an dich!`
  String get notificationTitle_final {
    return Intl.message(
      'Wir haben noch ein paar Fragen an dich!',
      name: 'notificationTitle_final',
      desc: '',
      args: [],
    );
  }

  /// `Nimm jetzt an der PROMPT-Abschlussbefragung teil und sichere dir die letzten 💎.`
  String get notificationBody_final {
    return Intl.message(
      'Nimm jetzt an der PROMPT-Abschlussbefragung teil und sichere dir die letzten 💎.',
      name: 'notificationBody_final',
      desc: '',
      args: [],
    );
  }

  /// `Erstelle aus Emojis eine Darstellung deines Planes.`
  String get emojiInternalisation_createPlan {
    return Intl.message(
      'Erstelle aus Emojis eine Darstellung deines Planes.',
      name: 'emojiInternalisation_createPlan',
      desc: '',
      args: [],
    );
  }

  /// `Dein Benutzername ist: {username}`
  String accountManagement_yourAccountName(String username) {
    return Intl.message(
      'Dein Benutzername ist: $username',
      name: 'accountManagement_yourAccountName',
      desc: '',
      args: [username],
    );
  }

  /// `Dein Benutzername ist: {cabuuCode}`
  String accountManagement_yourCabuuCode(String cabuuCode) {
    return Intl.message(
      'Dein Benutzername ist: $cabuuCode',
      name: 'accountManagement_yourCabuuCode',
      desc: '',
      args: [cabuuCode],
    );
  }

  /// `Du kannst hier deinen Account löschen. Wenn du das tust, werden alle deine Daten gelöscht und du kannst die App nicht mehr benutzen. Das Löschen passiert erst nach manueller Prüfung.`
  String get accountManagement_deleteAccountExplanation {
    return Intl.message(
      'Du kannst hier deinen Account löschen. Wenn du das tust, werden alle deine Daten gelöscht und du kannst die App nicht mehr benutzen. Das Löschen passiert erst nach manueller Prüfung.',
      name: 'accountManagement_deleteAccountExplanation',
      desc: '',
      args: [],
    );
  }

  /// `Klicke hier, falls du dein Konto löschen möchtest.`
  String get accountManagement_clickToDeleteAccount {
    return Intl.message(
      'Klicke hier, falls du dein Konto löschen möchtest.',
      name: 'accountManagement_clickToDeleteAccount',
      desc: '',
      args: [],
    );
  }

  /// `Das Passwort war nicht richtig.`
  String get accountManagement_invalidPassword {
    return Intl.message(
      'Das Passwort war nicht richtig.',
      name: 'accountManagement_invalidPassword',
      desc: '',
      args: [],
    );
  }

  /// `Konto löschen?`
  String get accountManagement_deleteDialog_title {
    return Intl.message(
      'Konto löschen?',
      name: 'accountManagement_deleteDialog_title',
      desc: '',
      args: [],
    );
  }

  /// `Gib hier dein Passwort zur Bestätigung ein.`
  String get accountManagement_deleteDialog_EnterPassword {
    return Intl.message(
      'Gib hier dein Passwort zur Bestätigung ein.',
      name: 'accountManagement_deleteDialog_EnterPassword',
      desc: '',
      args: [],
    );
  }

  /// `Abbrechen`
  String get general_buttonTexts_cancel {
    return Intl.message(
      'Abbrechen',
      name: 'general_buttonTexts_cancel',
      desc: '',
      args: [],
    );
  }

  /// `Bestätigen`
  String get general_buttonTexts_confirm {
    return Intl.message(
      'Bestätigen',
      name: 'general_buttonTexts_confirm',
      desc: '',
      args: [],
    );
  }

  /// `Ausloggen`
  String get general_buttonTexts_logout {
    return Intl.message(
      'Ausloggen',
      name: 'general_buttonTexts_logout',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'de'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
