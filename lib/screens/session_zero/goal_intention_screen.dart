import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:prompt/shared/app_strings.dart';
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
        MarkdownBody(data: "### " + AppStrings.HelpLearnVocabulary),
        UIHelper.verticalSpaceMedium(),
        MarkdownBody(data: "### " + AppStrings.ThinkAboutWhy),
        UIHelper.verticalSpaceMedium(),
        MarkdownBody(data: "### " + AppStrings.WriteYourResponse),
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
