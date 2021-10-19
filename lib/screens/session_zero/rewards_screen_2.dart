import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:prompt/shared/ui_helper.dart';

class RewardScreen2 extends StatelessWidget {
  const RewardScreen2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: [
          UIHelper.verticalSpaceLarge(),
          MarkdownBody(
              data: "### Glückwunsch, du hast noch einmal 5 💎 verdient!")
        ],
      ),
    );
  }
}
