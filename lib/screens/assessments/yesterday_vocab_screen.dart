import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:intl/intl.dart';

class YesterdayVocabScreen extends StatelessWidget {
  final DateTime nextVocabTestDate;
  const YesterdayVocabScreen({Key? key, required this.nextVocabTestDate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var format = new DateFormat("dd.MM.yyyy");
    var targetDate = format.format(nextVocabTestDate);
    return Container(
        child: ListView(
      children: [
        MarkdownBody(
            data:
                "### Du solltest gestern den Vokabeltest durchführen und deinen neuen Lernplan aktivieren"),
        MarkdownBody(data: "### Hast du beides gemacht?"),
        MarkdownBody(data: "### Falls ja: Prima, mache hier weiter."),
        MarkdownBody(data: "### Falls nicht: Hole das bitte jetzt nach."),
        MarkdownBody(data: "### Dein nächster Lernplan endet am $targetDate"),
      ],
    ));
  }
}
