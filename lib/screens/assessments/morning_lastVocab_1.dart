import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:prompt/shared/app_strings.dart';
import 'package:prompt/shared/ui_helper.dart';

class MorningLastVocab1 extends StatelessWidget {
  const MorningLastVocab1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListView(
      children: [
        MarkdownBody(data: "### " + AppStrings.MorningAssessment_lastVocab1_1),
        UIHelper.verticalSpaceMedium(),
        MarkdownBody(data: "### " + AppStrings.MorningAssessment_lastVocab1_2),
      ],
    ));
  }
}
