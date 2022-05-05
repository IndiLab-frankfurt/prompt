import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class InstructionsImplementationIntentions extends StatelessWidget {
  const InstructionsImplementationIntentions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
