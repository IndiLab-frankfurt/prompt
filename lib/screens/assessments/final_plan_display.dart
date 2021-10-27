import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:prompt/shared/ui_helper.dart';

class FinalPlanDisplay extends StatelessWidget {
  final String plan;
  const FinalPlanDisplay({Key? key, required this.plan}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListView(children: [
      UIHelper.verticalSpaceLarge(),
      MarkdownBody(
          data:
              "### In unserer Studie hast du dir für das Lernen mit cabuu einen Plan gemacht."),
      MarkdownBody(data: "### Dein Plan lautete."),
      UIHelper.verticalSpaceMedium(),
      Center(
          child: MarkdownBody(
        data: "## " + plan,
      )),
      UIHelper.verticalSpaceMedium(),
      MarkdownBody(
          data:
              "### Die nächsten Fragen beziehen sich darauf, wie du diesen Plan fandest."),
    ]));
  }
}
