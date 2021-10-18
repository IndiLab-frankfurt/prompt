import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:prompt/shared/app_strings.dart';
import 'package:prompt/shared/ui_helper.dart';

class MorningLastVocab2 extends StatelessWidget {
  const MorningLastVocab2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListView(
      children: [
        MarkdownBody(
            data:
                "### " + "Mache hier weiter, sobald du den Test gemacht hast"),
        UIHelper.verticalSpaceMedium(),
      ],
    ));
  }
}
