import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:prompt/l10n/localization/generated/l10n.dart';

class InstructionsDistributedLearning extends StatelessWidget {
  const InstructionsDistributedLearning({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/illustrations/mascot_1_sideglance.png"),
              fit: BoxFit.none,
              scale: 3.5,
              alignment: Alignment.bottomCenter)),
      child: ListView(
        children: [MarkdownBody(data: S.of(context).instructionsDistributedp1)],
      ),
    );
  }
}
