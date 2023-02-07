import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:prompt/shared/app_strings.dart';
import 'package:prompt/shared/enums.dart';
import 'package:prompt/shared/ui_helper.dart';
import 'package:prompt/widgets/full_width_button.dart';
import 'package:prompt/widgets/speech_bubble.dart';

class DefaultReminderScreen extends StatelessWidget {
  const DefaultReminderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: ,
      body: Container(
        margin: UIHelper.containerMargin,
        child: ListView(children: [
          UIHelper.verticalSpaceLarge(),
          MarkdownBody(data: "# " + AppStrings.ThinkAboutYourGoal),
          UIHelper.verticalSpaceMedium(),
          SpeechBubble(
              text: '"Ich will jeden Tag ein paar Vokabeln mit cabuu lernen!"'),
          UIHelper.verticalSpaceMedium(),
          Align(
            alignment: Alignment.bottomCenter,
            child: FullWidthButton(onPressed: () async {
              await Navigator.pushNamed(context, AppScreen.Mainscreen.name);
            }),
          )
        ]),
      ),
    );
  }
}
