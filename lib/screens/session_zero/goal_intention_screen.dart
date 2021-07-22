import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:prompt/shared/ui_helper.dart';

class GoalIntentionScreen extends StatefulWidget {
  GoalIntentionScreen({Key? key}) : super(key: key);

  @override
  _GoalIntentionScreenState createState() => _GoalIntentionScreenState();
}

class _GoalIntentionScreenState extends State<GoalIntentionScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        MarkdownBody(
            data:
                "### In der Studie PROMPT wollen wir dir dabei helfen, Vokabeln so zu lernen, dass du sie dir besonders gut merken kannst."),
        UIHelper.verticalSpaceMedium(),
        MarkdownBody(
            data:
                "### Denk mal nach: Warum ist es für dich wichtig, Vokabeln zu lernen? Wie könnte es für dich in Zukunft von Vorteil sein, viele Vokabeln gelernt zu haben?"),
        UIHelper.verticalSpaceMedium(),
        MarkdownBody(
            data: "### Schreibe deine Antwort hier auf (Stichworte genügen):"),
        UIHelper.verticalSpaceMedium(),
        TextField(
          decoration: InputDecoration(hintText: ''),
          onChanged: (String text) {
            setState(() {});
          },
        )
      ],
    );
  }
}
