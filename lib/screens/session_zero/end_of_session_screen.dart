import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:prompt/shared/app_strings.dart';
import 'package:prompt/shared/ui_helper.dart';

class EndOfSessionScreen extends StatelessWidget {
  const EndOfSessionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        UIHelper.verticalSpaceMedium(),
        MarkdownBody(data: "### " + AppStrings.EndofsessionText),
        UIHelper.verticalSpaceMedium(),
        MarkdownBody(data: "### " + AppStrings.SelectionOfMascot),
        UIHelper.verticalSpaceMedium(),
      ],
    );
  }
}
