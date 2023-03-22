import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:prompt/l10n/localization/generated/l10n.dart';
import 'package:prompt/shared/ui_helper.dart';

class InstructionsQuestionnaires extends StatelessWidget {
  const InstructionsQuestionnaires({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // decoration: BoxDecoration(
      //     image: DecorationImage(
      //         image: AssetImage("assets/illustrations/mascot_1_bookpillar.png"),
      //         fit: BoxFit.none,
      //         scale: 3.5,
      //         alignment: Alignment.bottomCenter)),
      child: ListView(
        children: [
          Text(S.of(context).instructionsQuestionnaires_p1),
          UIHelper.verticalSpaceSmall,
          Text(S.of(context).instructionsQuestionnaires_p2),
          UIHelper.verticalSpaceSmall,
          MarkdownBody(data: S.of(context).instructionsQuestionnaires_p3),
          UIHelper.verticalSpaceSmall,
          MarkdownBody(data: S.of(context).instructionsQuestionnaires_p4),
          UIHelper.verticalSpaceSmall,
          MarkdownBody(data: S.of(context).instructionsQuestionnaires_p5),
        ],
      ),
    );
  }
}
