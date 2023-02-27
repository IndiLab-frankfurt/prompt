import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
        children: [
          MarkdownBody(
              data: AppLocalizations.of(context)!.instructionsDistributedp1)
        ],
      ),
    );
  }
}
