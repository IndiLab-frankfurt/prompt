import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:prompt/shared/ui_helper.dart';

class InstructionsImplementationIntentions extends StatelessWidget {
  const InstructionsImplementationIntentions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: UIHelper.baseGradient,
          image: DecorationImage(
              image: AssetImage("assets/illustrations/mascot_1_lightbulb.png"),
              fit: BoxFit.contain,
              alignment: Alignment.bottomCenter)),
      child: ListView(
        children: [
          MarkdownBody(
              data:
                  "### Es kann schwierig sein, jeden Tag ans Vokabellernen zu denken."),
          MarkdownBody(
              data:
                  "### Auf der nächsten Seite zeigt dir unser Monster einen Trick, der dir dabei hilft.")
        ],
      ),
    );
  }
}
