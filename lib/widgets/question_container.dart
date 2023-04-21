import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:prompt/shared/ui_helper.dart';

class QuestionContainer extends StatelessWidget {
  final String data;
  final List<Widget> choices;
  final String instructions;
  const QuestionContainer(
      {super.key,
      required this.data,
      required this.choices,
      required this.instructions});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Theme.of(context).dialogBackgroundColor.withOpacity(0.9),
            border: Border.all(color: Color(0xFF000000), width: 1),
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
          ),
          child: Column(
            children: <Widget>[
              MarkdownBody(
                data: "${this.instructions}",
              ),
              UIHelper.verticalSpaceMedium,
              MarkdownBody(
                data: "**${this.data}**",
              ),
              UIHelper.verticalSpaceMedium,
              ...this.choices,
            ],
          ),
        ),
      ],
    );
  }
}
