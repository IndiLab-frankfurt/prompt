import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:prompt/shared/ui_helper.dart';

class InstructionScreen3 extends StatelessWidget {
  const InstructionScreen3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListView(
      children: [
        MarkdownBody(
            data:
                "### Es gibt keine richtigen oder falschen Antworten. Manchmal denkst du vielleicht, dass andere Leuten eine Antwort “besser” finden würden und du deshalb diese Antwort anklicken solltest, obwohl sie gar nicht auf dich zutrifft."),
        UIHelper.verticalSpaceMedium(),
        MarkdownBody(
            data: '### Wir wollen aber deine **ehrliche Meinung** wissen!'),
        UIHelper.verticalSpaceMedium(),
        MarkdownBody(
            data:
                '### Wenn du zum Beispiel überhaupt nicht gerne Vokabeln lernst, dann gib das bitte auch als deine ehrliche Meinung an. Genauso natürlich, falls du gerne Vokabeln lernst.'),
        UIHelper.verticalSpaceMedium(),
        MarkdownBody(
          data:
              '### Deine Angaben sind anonym. Das bedeutet, dass wir nicht sehen können, dass *du* diese Antwort gegeben hast.',
        )
      ],
    ));
  }
}
