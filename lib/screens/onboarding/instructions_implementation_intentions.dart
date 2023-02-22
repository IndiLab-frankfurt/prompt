import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:prompt/shared/ui_helper.dart';

class InstructionsImplementationIntentions extends StatelessWidget {
  const InstructionsImplementationIntentions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: [
          UIHelper.verticalSpaceLarge,
          MarkdownBody(
              data:
                  "## Es kann schwierig sein, jeden Tag daran zu denken, Vokabeln zu lernen."),
          UIHelper.verticalSpaceMedium,
          MarkdownBody(
              data:
                  "## Auf der nächsten Seite zeigt dir unser Monster einen Trick, der dir dabei hilft, dieses Ziel zu erreichen."),
        ],
      ),
    );
  }
}
