import 'package:flutter/material.dart';
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
        Text(
            "In der Studie PROMPT wollen wir dir dabei helfen, Vokabeln so zu lernen, dass du sie dir besonders gut merken kannst."),
        UIHelper.verticalSpaceMedium(),
        Text(
            "Denk mal nach: Warum ist es für dich wichtig, Vokabeln zu lernen? Wie könnte es für dich in Zukunft von Vorteil sein, viele Vokabeln gelernt zu haben?"),
        UIHelper.verticalSpaceMedium(),
        Text("Schreibe deine Antwort hier auf (Stichworte genügen):"),
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
