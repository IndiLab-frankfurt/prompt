import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:prompt/shared/ui_helper.dart';
import 'package:prompt/widgets/onboarding_container.dart';

class InstructionsImplementationIntentions extends StatelessWidget {
  const InstructionsImplementationIntentions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var bgimg = "assets/illustrations/mascot_1_idea.png";
    return OnboardingContainer(
      decorationImage: DecorationImage(
          image: AssetImage(bgimg),
          fit: BoxFit.none,
          scale: 6,
          alignment: Alignment.bottomCenter),
      child: ListView(
        children: [
          MarkdownBody(
              data:
                  "Es kann schwierig sein, jeden Tag daran zu denken, Vokabeln zu lernen."),
          UIHelper.verticalSpaceMedium,
          MarkdownBody(
              data:
                  "Auf der nächsten Seite zeigt dir unser Monster **einen Trick**, der dir dabei hilft, dieses Ziel zu erreichen."),
        ],
      ),
    );
  }
}
