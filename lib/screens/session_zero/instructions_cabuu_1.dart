import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:prompt/shared/ui_helper.dart';

class InstructionsCabuu1 extends StatelessWidget {
  const InstructionsCabuu1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListView(
      children: [
        MarkdownBody(
            data:
                "### Jetzt zeigen wir dir, wie du deinen cabuu-Zugang aktivierst und die Vokabeln eingibst."),
        UIHelper.verticalSpaceMedium(),
        MarkdownBody(data: "### Dein Cabuu Code lautet:"),
        UIHelper.verticalSpaceMedium(),
        Center(child: MarkdownBody(data: "# **123**")),
        UIHelper.verticalSpaceMedium(),
        MarkdownBody(
            data:
                "### Schreibe dir diesen Code auf. Du brauchst ihn gleich, um cabuu freizuschalten.")
      ],
    ));
  }
}
