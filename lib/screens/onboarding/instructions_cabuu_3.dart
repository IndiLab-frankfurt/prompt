import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:prompt/shared/ui_helper.dart';

class InstructionsCabuu3 extends StatelessWidget {
  const InstructionsCabuu3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListView(
      children: [
        MarkdownBody(
            data:
                "### Hast du deine 6 Vokabellisten in cabuu angelegt und den ersten Lernplan aktiviert? Prima!"),
        UIHelper.verticalSpaceMedium,
        MarkdownBody(
            data:
                "### Mit dem Lernen in cabuu sollst du erst *ab morgen* beginnen."),
        UIHelper.verticalSpaceMedium,
        MarkdownBody(
            data:
                "### Jetzt haben wir erst noch ein paar Fragen an dich. Dabei geht es darum, was du glaubst, wie das Vokabellernen mit cabuu in den nächsten Wochen für dich werden wird.")
      ],
    ));
  }
}
