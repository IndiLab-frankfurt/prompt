import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:prompt/shared/ui_helper.dart';

class VocabLearnTimingScreen extends StatelessWidget {
  const VocabLearnTimingScreen({Key? key}) : super(key: key);
  // TODO: Finish when there is time
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
        MarkdownBody(
            data: "### Wann möchtest du an das Vokabellernen erinnert werden?"),
        UIHelper.verticalSpaceSmall(),
        MarkdownBody(
            data: "### Wann möchtest du an das Vokabellernen erinnert werden?"),
      ],
    ));
  }
}
