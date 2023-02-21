import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:prompt/shared/ui_helper.dart';

class InstructionsDistributedLearning extends StatelessWidget {
  const InstructionsDistributedLearning({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/illustrations/mascot_1_sideglance.png"),
              fit: BoxFit.none,
              scale: 2.5,
              alignment: Alignment.bottomCenter)),
      child: ListView(
        children: [
          UIHelper.verticalSpaceLarge,
          MarkdownBody(
              data:
                  "### Beim Vokabellernen kann man Strategien anwenden, die einem beim Lernen und Erinnern helfen. Auf der nächsten Seite siehst du ein Video, in dem eine solche Strategie und ihre Vorteile erklärt werden.")
        ],
      ),
    );
  }
}
