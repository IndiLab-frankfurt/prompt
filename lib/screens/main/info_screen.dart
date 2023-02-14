import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:prompt/shared/app_strings.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(AppStrings.InfoScreen_Header1),
        ),
        body: Container(
          margin: EdgeInsets.all(15),
          child: ListView(
            children: [
              MarkdownBody(data: AppStrings.InfoScreen_Body1),
              MarkdownBody(data: "# " + AppStrings.InfoScreen_Header2),
              MarkdownBody(data: AppStrings.InfoScreen_Body2),
              MarkdownBody(data: "# " + AppStrings.InfoScreen_Header3),
              MarkdownBody(data: AppStrings.InfoScreen_Body3),
              MarkdownBody(data: "# " + AppStrings.InfoScreen_Header4),
              MarkdownBody(data: AppStrings.InfoScreen_Body4)
            ],
          ),
        ));
  }
}
