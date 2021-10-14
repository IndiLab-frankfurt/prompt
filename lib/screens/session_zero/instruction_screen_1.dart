import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:prompt/shared/ui_helper.dart';

class InstructionScreen1 extends StatelessWidget {
  const InstructionScreen1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListView(
      children: [
        MarkdownBody(
            data:
                "### Heute und im Laufe der Studie werden wir dir einige Fragen stellen. Die meisten Fragen beziehen sich darauf, wie du lernst oder was du über das Lernen denkst."),
        UIHelper.verticalSpaceMedium(),
        MarkdownBody(data: "### Meistens zeigen wir dir eine Aussage, z.B.:"),
        MarkdownBody(data: '> ### Ich lerne gerne Vokabeln'),
        UIHelper.verticalSpaceMedium(),
        MarkdownBody(
          data:
              "### Du sollst dann angeben, wie sehr diese Aussage auf **dich persönlich** zutrifft.",
        ),
        UIHelper.verticalSpaceMedium(),
        MarkdownBody(
            data: '### Meistens sind die möglichen Antworten sowas wie:'),
        UIHelper.verticalSpaceMedium(),
        MarkdownBody(data: '* ### Trifft überhaupt nicht zu'),
        MarkdownBody(data: '* ### Trifft eher nicht zu'),
        MarkdownBody(data: '* ### Trifft eher zu'),
        MarkdownBody(data: '* ### Trifft voll und ganz zu'),
      ],
    ));
  }
}
