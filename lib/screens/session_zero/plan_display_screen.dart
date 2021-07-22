import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:prompt/shared/ui_helper.dart';
import 'package:prompt/viewmodels/session_zero_view_model.dart';
import 'package:prompt/widgets/speech_bubble.dart';
import 'package:provider/provider.dart';

class PlanDisplayScreen extends StatelessWidget {
  const PlanDisplayScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var vm = Provider.of<SessionZeroViewModel>(context);
    return Container(
        child: ListView(
      children: [
        MarkdownBody(data: "# Prima!"),
        UIHelper.verticalSpaceMedium(),
        MarkdownBody(data: '### Dein Plan lautet also:'),
        UIHelper.verticalSpaceMedium(),
        SpeechBubble(text: '"${vm.plan}"'),
        UIHelper.verticalSpaceMedium(),
        MarkdownBody(data: "### Merke dir den Plan gut!")
      ],
    ));
  }
}
