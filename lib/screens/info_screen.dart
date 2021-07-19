import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({Key? key}) : super(key: key);

  final String _body1 =
      "PROMPT ist eine Studie des *DIPF | Leibniz-Institut für Bildungsforschung und Bildungsinformation*. Mit deiner Hilfe wollen wir herausfinden, wie wir Kinder am besten beim Lernen mit Apps unterstützen können. Deshalb stellen wir dir während der Studie einige Fragen dazu, wie du Vokabeln lernst. Außerdem stellen wir dir Aufgaben. Zum Beispiel sollst du dir für das Monster Lernpläne merken. Dabei ist es wichtig, dass du dich bei den Aufgaben richtig anstrengst und alle Fragen ehrlich beantwortest.";
  final String _headline2 = "# Belohnung";
  final String _body2 =
      """In dieser App bekommst du 💎 als Belohnung wenn du an einem Tag **alle** Aufgaben erledigst. 
      Das heißt, dass du dir an jedem Tag **morgens den Plan merken** und **abends die Erinnerungsaufgabe** abschließen musst, damit du 💎 bekommst. Für deine 💎 bekommst du am Ende einen Gutschein und zwar mit mehr Guthaben, je mehr 💎 du gesammelt hast! Insgesamt bis zu 12 Euro. 
      Deine 💎 dienen außerdem als Lose in unserem Gewinnspiel, bei dem du zusätzlich 25€ Guthaben für einen Gutschein gewinnen kannst.""";
  final String _headline3 = "# Wie lange dauert die Studie?";
  final String _body3 =
      "Die Studie dauert insgesamt 28 Tage. Am ersten Tag, an dem du in die Studie eingeführt wirst, dauert es ungefähr 15-20 Minuten. An den darauffolgenden 27 Tage sollst du die App PROMPT dann zweimal täglich benutzen: Einmal möglichst schon morgens und das zweite Mal 6 Stunden später. Die App erinnert dich daran. Das dauert dann auch nur noch ungefähr 5 Minuten pro Tag.";
  final String _headline4 = "# Freiwilligkeit & Datenschutz?";
  final String _body4 =
      "Du entscheidest selbst, ob du an der Studie teilnehmen möchtest. Du kannst jederzeit aufhören und musst das auch nicht begründen. Dir entstehen dadurch keine Nachteile. Die Angaben, die du während der Studie machst, werden von uns verschlüsselt. Das bedeutet, dass anstelle deines Namens eine Codenummer verwendet wird, sodass niemand weiß, dass das deine Daten sind. Bei Fragen kannst du dich jederzeit an uns wenden. Schreibe uns dazu eine E-Mail an prompt@idea-frankfurt.eu";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Über PROMPT'),
        ),
        body: Container(
          margin: EdgeInsets.all(15),
          child: ListView(
            children: [
              // MarkdownBody(data: _headline1),
              MarkdownBody(data: _body1),
              MarkdownBody(data: _headline2),
              MarkdownBody(data: _body2),
              MarkdownBody(data: _headline3),
              MarkdownBody(data: _body3),
              MarkdownBody(data: _headline4),
              MarkdownBody(data: _body4)
            ],
          ),
        ));
  }
}
