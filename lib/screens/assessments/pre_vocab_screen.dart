import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:prompt/shared/ui_helper.dart';

class PreVocabScreen extends StatelessWidget {
  const PreVocabScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListView(
      children: [
        UIHelper.verticalSpaceLarge(),
        MarkdownBody(
            data:
                "### Heute sollst du in cabuu den Vokabeltest machen. Wie das geht, zeigen wir dir im Video auf der nächsten Seite."),
        UIHelper.verticalSpaceMedium(),
        MarkdownBody(
            data:
                "### Mach nach dem Video bitte den Test und komm dann direkt zurück zu PROMPT, um ein paar Fragen zu beantworten.")
      ],
    ));
  }
}