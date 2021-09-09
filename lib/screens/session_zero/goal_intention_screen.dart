import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:prompt/shared/app_strings.dart';
import 'package:prompt/shared/ui_helper.dart';
import 'package:prompt/widgets/speech_bubble.dart';

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
        MarkdownBody(data: "### " + AppStrings.GoalIntention_ParagraphOne),
        UIHelper.verticalSpaceMedium(),
        MarkdownBody(data: "### " + AppStrings.GoalIntention_ParagraphTwo),
        UIHelper.verticalSpaceMedium(),
        MarkdownBody(data: "### " + AppStrings.GoalIntention_SayToYourself),
        SpeechBubble(text: AppStrings.GoalIntention_Plan)
      ],
    );
  }
}
