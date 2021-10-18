import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:prompt/shared/app_strings.dart';
import 'package:prompt/shared/ui_helper.dart';

class MorningFirstDay2 extends StatelessWidget {
  final DateTime nextVocabTestDate;
  const MorningFirstDay2({Key? key, required this.nextVocabTestDate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        MarkdownBody(
            data: "### " + AppStrings.MorningAssessment_FirstDay_Screen2_1),
        UIHelper.verticalSpaceMedium(),
        MarkdownBody(
            data: "### " +
                AppStrings.MorningAssessment_FirstDay_Screen2_2(
                    nextVocabTestDate)),
      ],
    );
  }
}
