import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:prompt/shared/ui_helper.dart';
import 'package:prompt/widgets/speech_bubble.dart';

class RewardScreen1 extends StatelessWidget {
  const RewardScreen1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: [
          UIHelper.verticalSpaceLarge,
          SpeechBubble(
            text: "Glückwunsch, du hast deine ersten 5 💎 verdient!",
          ),
          UIHelper.verticalSpaceMedium,
          MarkdownBody(
            data: "## Jetzt haben wir erst mal ein paar Fragen an dich.",
          ),
          UIHelper.verticalSpaceMedium,
          MarkdownBody(
            data:
                "## Bitte beantworte alle Fragen ehrlich. Dir entstehen dadurch keine Nachteile.",
          ),
        ],
      ),
    );
  }
}
