import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:prompt/shared/ui_helper.dart';

class RewardScreen1 extends StatelessWidget {
  const RewardScreen1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: [
          UIHelper.verticalSpaceLarge,
          MarkdownBody(
              data: "### Glückwunsch, du hast deine ersten 5 💎 verdient!"),
          UIHelper.verticalSpaceMedium,
          MarkdownBody(
              data: "### Jetzt haben wir erst mal ein paar Fragen an dich."),
          UIHelper.verticalSpaceMedium,
          MarkdownBody(
              data:
                  "### Bitte beantworte alle Fragen ehrlich. Dir entstehen dadurch keine Nachteile.")
        ],
      ),
    );
  }
}
