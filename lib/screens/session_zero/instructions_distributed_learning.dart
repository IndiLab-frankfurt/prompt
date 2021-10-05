import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class InstructionsDistributedLearning extends StatelessWidget {
  const InstructionsDistributedLearning({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: [
          MarkdownBody(
              data:
                  "### Beim Vokabellernen kann man Strategien anwenden, die einem beim Lernen und Erinnern helfen. Auf der nächsten Seite siehst du ein Video, in dem eine solche Strategie und ihre Vorteile erklärt werden.")
        ],
      ),
    );
  }
}
