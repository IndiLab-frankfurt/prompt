import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:intl/intl.dart';
import 'package:prompt/shared/ui_helper.dart';

class PreVocabScreen2 extends StatelessWidget {
  final DateTime nextVocabDate;
  final int nextListNumber;
  const PreVocabScreen2(
      {Key? key, required this.nextVocabDate, required this.nextListNumber})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var format = new DateFormat("dd.MM.yyyy");
    var targetDate = format.format(nextVocabDate.subtract(Duration(days: 1)));

    return Container(
        child: ListView(
      children: [
        UIHelper.verticalSpaceLarge(),
        MarkdownBody(
            data:
                "### Heute sollst du in cabuu den Vokabeltest machen. Drücke dazu in cabuu auf Liste $nextListNumber und wähle 'Abfrage'."),
        UIHelper.verticalSpaceMedium(),
        if (nextListNumber < 6)
          MarkdownBody(
              data:
                  "### Nachdem du den Test gemacht hast, sollst du schon einmal den Lernplan für Liste ${nextListNumber + 1} aktivieren. Klicke dazu auf die Liste und wähle 'Lernplan'."),
        if (nextListNumber < 6)
          MarkdownBody(
              data: "### Dein nächster Lernplan endet am: $targetDate"),
        UIHelper.verticalSpaceMedium(),
        if (nextListNumber < 6)
          MarkdownBody(
              data:
                  "### Mach bitte den Test und lege den Lernplan an. Komme danach direkt zurück zu PROMPT, um ein paar Fragen zu beantworten."),
        if (nextListNumber >= 6)
          MarkdownBody(
              data:
                  "### Heute sollst du in cabuu den letzten Test machen. Klicke dazu in cabuu auf Liste 6 und wähle 'Abfrage'."),
        if (nextListNumber >= 6)
          MarkdownBody(
              data:
                  "### Mach bitte den Test und komm danach direkt zurück zu PROMPT, um die letzten Fragen zu beantworten. Danach bist du fertig mit der Studie."),
      ],
    ));
  }
}
