import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:prompt/shared/ui_helper.dart';

class MorningLastDay1 extends StatelessWidget {
  const MorningLastDay1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        MarkdownBody(data: "### "),
        UIHelper.verticalSpaceMedium(),
        MarkdownBody(data: "### "),
      ],
    );
  }
}
