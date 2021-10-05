import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:prompt/shared/ui_helper.dart';

class InstructionScreen4 extends StatelessWidget {
  const InstructionScreen4({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListView(
      children: [
        MarkdownBody(
            data:
                '### Weil du PROMPT jeden Tag benutzen sollst, werden wir dir an vielen Tagen dieselben Fragen noch mal stellen. Das machen wir, weil eine Aussage an einem Tag mehr und an einem anderen Tag weniger auf dich zutreffen kann. Zum Beispiel trifft die Aussage '),
        MarkdownBody(data: '> ### “Heute habe ich Lust, Vokabeln zu lernen”'),
        MarkdownBody(
            data:
                '### vielleicht heute voll und ganz auf dich zu, morgen aber überhaupt nicht. Überlege also jeden Tag genau, wie sehr die Aussage **jetzt gerade** auf dich zutrifft.'),
        UIHelper.verticalSpaceMedium(),
        MarkdownBody(
          data: '### Wir starten jetzt mit den ersten Fragen',
        )
      ],
    ));
  }
}
