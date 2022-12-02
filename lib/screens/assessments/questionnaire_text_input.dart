import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:prompt/shared/ui_helper.dart';

typedef void TextInputCallback(String val);

class QuestionnaireTextInput extends StatelessWidget {
  final String question;
  final TextInputType textInputType;
  final TextInputCallback callback;

  const QuestionnaireTextInput(
      {Key? key,
      required this.question,
      required this.callback,
      this.textInputType = TextInputType.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          MarkdownBody(data: '## $question'),
          UIHelper.verticalSpaceSmall(),
          TextField(
            keyboardType: textInputType,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
            ),
            onChanged: (value) => callback(value),
          ),
        ],
      ),
    );
  }
}
