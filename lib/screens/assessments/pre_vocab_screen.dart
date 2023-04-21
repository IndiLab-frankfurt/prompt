import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:intl/intl.dart';
import 'package:prompt/shared/ui_helper.dart';

class PreVocabScreen extends StatelessWidget {
  final DateTime nextVocabDate;
  const PreVocabScreen({Key? key, required this.nextVocabDate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var format = new DateFormat("dd.MM.yyyy");
    var targetDate = format.format(nextVocabDate);
    var difference = nextVocabDate.difference(DateTime.now());

    var listNumber = difference.inDays ~/ 9 + 1;
    return Container(
        child: ListView(
      children: [
        UIHelper.verticalSpaceLarge,
        MarkdownBody(
            data:
                "### Heute sollst du in cabuu den Vokabeltest machen. Drücke dazu in cabuu auf Liste $listNumber"),
        UIHelper.verticalSpaceMedium,
        MarkdownBody(
            data:
                "### Nachdem du den test gemacht hast, sollst du schon einmal den Lernplan für Liste ${listNumber + 1} aktivieren. Klicke dazu auf die Liste und wähle 'Lernplan'."),
        MarkdownBody(data: "### Dein nächster Lernplan endet am: $targetDate"),
        UIHelper.verticalSpaceMedium,
        MarkdownBody(
            data:
                "### Mach bitte den Test und lege den Lernplan an. Komme danach direkt zurück zu PROMPT, um ein paar Fragen zu beantworten."),
      ],
    ));
  }
}
