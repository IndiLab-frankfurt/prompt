import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:intl/intl.dart';
import 'package:prompt/shared/ui_helper.dart';

class InstructionsCabuu1 extends StatelessWidget {
  const InstructionsCabuu1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var format = new DateFormat("dd.MM.yyyy");
    var targetDate = format.format(DateTime.now().add(Duration(days: 8)));
    return Container(
        child: ListView(
      children: [
        MarkdownBody(
            data:
                "### Jetzt zeigen wir dir, wie du deinen cabuu-Zugang aktivierst und die Vokabeln eingibst."),
        UIHelper.verticalSpaceSmall(),
        MarkdownBody(data: "### Dein Cabuu Code lautet:"),
        UIHelper.verticalSpaceSmall(),
        Center(child: MarkdownBody(data: "# **123**")),
        UIHelper.verticalSpaceSmall(),
        MarkdownBody(
            data:
                "### Schreibe dir diesen Code auf. Du brauchst ihn gleich, um cabuu freizuschalten."),
        UIHelper.verticalSpaceLarge(),
        UIHelper.verticalSpaceMedium(),
        MarkdownBody(data: "### Schreibe dir außerdem dieses Datum auf:"),
        UIHelper.verticalSpaceSmall(),
        Center(child: MarkdownBody(data: "# **$targetDate**")),
        UIHelper.verticalSpaceSmall(),
        MarkdownBody(data: "### Wofür du das brauchst, erfährst du gleich."),
      ],
    ));
  }
}
