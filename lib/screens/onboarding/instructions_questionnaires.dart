import 'package:flutter/material.dart';
import 'package:prompt/l10n/localization/generated/l10n.dart';

class InstructionsQuestionnaires extends StatelessWidget {
  const InstructionsQuestionnaires({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/illustrations/mascot_1_bookpillar.png"),
              fit: BoxFit.none,
              scale: 3.5,
              alignment: Alignment.bottomCenter)),
      child: ListView(
        children: [Text(S.of(context).instructionsDistributedp1)],
      ),
    );
  }
}
