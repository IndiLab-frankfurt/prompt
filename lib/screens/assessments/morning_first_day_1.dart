import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:prompt/shared/app_strings.dart';
import 'package:prompt/shared/ui_helper.dart';

class MorningFirstDay1 extends StatelessWidget {
  const MorningFirstDay1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        MarkdownBody(
            data: "### " + AppStrings.MorningAssessment_FirstDay_Screen1_1),
        UIHelper.verticalSpaceMedium(),
        MarkdownBody(
            data: "### " + AppStrings.MorningAssessment_FirstDay_Screen2_1),
      ],
    );
  }
}
