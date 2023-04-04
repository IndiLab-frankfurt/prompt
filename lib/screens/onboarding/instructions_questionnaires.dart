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
          Text(
            S.of(context).instructionsQuestionnaires_p1,
            style: Theme.of(context).textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
          UIHelper.verticalSpaceMedium,
          Text(S.of(context).instructionsQuestionnaires_p2),
          UIHelper.verticalSpaceSmall,
          Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Theme.of(context).dialogBackgroundColor.withOpacity(0.9),
              border: Border.all(color: Color(0xFF000000), width: 1),
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
            ),
            child: Text(
              S.of(context).instructionsQuestionnaires_p2b,
              textAlign: TextAlign.center,
            ),
          ),
          UIHelper.verticalSpaceSmall,
          MarkdownBody(data: S.of(context).instructionsQuestionnaires_p3),
          UIHelper.verticalSpaceSmall,
          Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Theme.of(context).dialogBackgroundColor.withOpacity(0.9),
              border: Border.all(color: Color(0xFF000000), width: 1),
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
            ),
            child: Text(
              S.of(context).instructionsQuestionnaires_p4,
              textAlign: TextAlign.left,
            ),
          ),
          UIHelper.verticalSpaceSmall,
          MarkdownBody(data: S.of(context).instructionsQuestionnaires_p5),
        ],
      ),
    );
  }
}
